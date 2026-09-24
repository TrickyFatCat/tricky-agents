#!/usr/bin/env nu

# Merges a finished worktree into main, then cleans up.

# Prints a refusal to stderr and exits with code 2.
#
# A refusal is not an error.
# The command is valid, but a safety rule stops it.
def refuse [msg: string, detail: string] {
    # Prints plain text, not an error box, so a refusal does not read as an error.
    print -e $"(ansi red)Refused(ansi reset): ($msg)\n"
    print -e $detail
    exit 2
}

# Stops the script with an error box and exit code 1.
def fail [msg: string, detail: string] {
    error make --unspanned {
        msg: $msg
        help: $detail
    }
}

# Runs git and returns {stdout, stderr, exit_code}, without stopping on a failure.
# Callers decide whether a failure is a refusal or an error.
# After the push, a failed git call must not skip the rest of the cleanup report.
def git-run [...args: string] {
    ^git ...$args | complete
}

# Returns the text after prefix on the first line that starts with it.
# Returns "" when no line starts with prefix.
# lines is one worktree's block of `git worktree list --porcelain` output.
def field [lines: list<string>, prefix: string] {
    let hit = $lines | where {|l| $l | str starts-with $prefix }

    if ($hit | is-empty) {
        ""
    } else {
        $hit | first | str replace $prefix ""
    }
}

# Returns one record per worktree as {path, branch, detached}, the primary checkout included.
# branch is "" for a detached worktree.
def worktrees [root: string] {
    let listed = git-run "-C" $root "worktree" "list" "--porcelain"

    if $listed.exit_code != 0 {
        fail "could not list worktrees" ($listed.stderr | str trim)
    }

    $listed.stdout
    | split row "\n\n"
    | where {|block| ($block | str trim) != "" }
    | each {|block|
        let lines = $block | lines

        {
            path: (field $lines "worktree " | path expand --no-symlink)
            branch: (field $lines "branch refs/heads/")
            detached: ($lines | any {|l| ($l | str trim) == "detached" })
        }
    }
}

# Returns the primary checkout's path, even when root is another worktree.
# Fails when root is not inside a git repository.
def primary-checkout [root: string] {
    let common = git-run "-C" $root "rev-parse" "--git-common-dir"

    if $common.exit_code != 0 {
        fail "not a git repository" ($common.stderr | str trim)
    }

    # Every worktree shares one git folder, which sits inside the primary checkout.
    $root | path join ($common.stdout | str trim) | path expand --no-symlink | path dirname
}

# Returns true when every commit in ancestor is already in descendant.
# Also returns false when git fails, for example on an unknown ref.
def contains [repo: string, ancestor: string, descendant: string] {
    (git-run "-C" $repo "merge-base" "--is-ancestor" $ancestor $descendant).exit_code == 0
}

# Returns changed and untracked files, one per line, or "" when the checkout is clean.
# extra goes to git status as it is, such as --ignored.
def status-of [repo: string, ...extra: string] {
    let status = git-run "-C" $repo "status" "--porcelain" ...$extra

    if $status.exit_code != 0 {
        fail $"could not read the status of ($repo)" ($status.stderr | str trim)
    }

    $status.stdout | str trim
}

# Refuses when the committed global-agents.md does not match a fresh build.
# Also refuses when the build itself refuses or fails.
#
# The tools link to that file, so the merge makes it live at once.
# The check uses the worktree's own build script.
# A branch that changes the build is checked with its own new rules.
def check-build [worktree: string] {
    let committed = $worktree | path join "global" "global-agents.md"
    let fresh = mktemp --tmpdir "global-agents.XXXXXX.md"
    let built = ^nu ($worktree | path join "scripts" "build-global-agents.nu") --out $fresh | complete

    let same = $built.exit_code == 0 and ((open --raw $fresh) == (open --raw $committed))
    rm $fresh

    if $built.exit_code != 0 {
        refuse "the rules build does not pass" $"($built.stderr | str trim)\n\nFix the sources in the worktree and commit, then run this again."
    }

    if not $same {
        refuse "global-agents.md is stale" $"The committed file differs from a fresh build of its sources. In the worktree, run:\n\n  (ansi blue)nu scripts/build-global-agents.nu(ansi reset)\n\nthen commit global-agents.md and run this again."
    }
}

# Merges a finished worktree into main, then cleans up.
#
#   1. Fast-forward main to the branch.
#   2. Push main.
#   3. Remove the worktree and the local branch.
#   4. Delete the branch on origin.
#
#   nu scripts/worktree-merge.nu                          the worktree you are in
#   nu scripts/worktree-merge.nu ../tricky-agents-combat
#
# All checks run before step 1.
# A refusal leaves everything as it was.
#
# The merge is fast-forward only.
# If main has new commits, the script refuses.
# Rebase the branch onto origin/main, then run it again.
#
# Also refuses when:
#
#   - the worktree holds uncommitted, untracked or ignored files;
#   - the primary checkout is not on main, or is not clean;
#   - global-agents.md differs from a fresh build of its sources;
#   - local main holds commits that origin does not;
#   - origin/<branch> holds commits that the branch does not.
#
# Step 3 runs the primary checkout's worktree-cleanup.nu.
# Its safety checks still apply.
# The worktree's own copy is not used, because step 3 deletes it.
#
# Exit codes: 0 done, 1 error, 2 refused, 3 main pushed but cleanup incomplete.
def --env main [
    path?: string   # any folder inside the worktree to merge (default: the current folder)
] {
    # Resolves the repository from the script's location, not from the working directory.
    let root = $env.FILE_PWD | path join ".." | path expand
    let primary = primary-checkout $root

    let top = git-run "-C" ($path | default $env.PWD) "rev-parse" "--show-toplevel"

    if $top.exit_code != 0 {
        fail "not inside a git checkout" ($top.stderr | str trim)
    }

    let worktree = $top.stdout | str trim | path expand --no-symlink

    # --- Checks.
    # Nothing changes until all of them pass.

    let hit = worktrees $primary | where path == $worktree

    if ($hit | is-empty) {
        fail "not a worktree of this repository" $"  (ansi red)($worktree)(ansi reset)"
    }

    let wt = $hit | first

    if $worktree == $primary {
        refuse "that is the primary checkout" $"Run this from a worktree, or pass the worktree's path."
    }

    if $wt.detached {
        refuse "worktree has a detached HEAD" $"  (ansi red)($worktree)(ansi reset)\n\nThere is no branch to merge."
    }

    let branch = $wt.branch

    if $branch == "main" {
        refuse "branch is main" "main is merged into, never merged."
    }

    let dirty = status-of $worktree "--ignored"

    if ($dirty | is-not-empty) {
        refuse "worktree is not clean" $"($dirty)\n\nCommit or delete these first. Ignored files count: removing the worktree would lose them."
    }

    let current = git-run "-C" $primary "branch" "--show-current"

    if ($current.stdout | str trim) != "main" {
        refuse "primary checkout is not on main" $"  (ansi red)($primary)(ansi reset)\n\nSwitch it back to main first."
    }

    let primary_dirty = status-of $primary

    if ($primary_dirty | is-not-empty) {
        refuse "primary checkout is not clean" $"($primary_dirty)\n\nThese files are live. Commit or remove them first."
    }

    check-build $worktree

    let fetched = git-run "-C" $primary "fetch" "--prune" "--quiet" "origin"

    if $fetched.exit_code != 0 {
        fail "could not fetch origin" ($fetched.stderr | str trim)
    }

    if not (contains $primary "main" "origin/main") {
        refuse "local main has commits origin does not" $"Push or drop them first:\n\n  (ansi blue)git -C ($primary) log origin/main..main(ansi reset)"
    }

    if not (contains $primary "origin/main" $branch) {
        refuse "main has moved on" $"($branch) does not contain the latest origin/main. In the worktree, run:\n\n  (ansi blue)git rebase origin/main(ansi reset)\n\nthen run this again."
    }

    # The remote branch may hold commits pushed from another place.
    # Compares changes, not commits, so a branch that was pushed and then rebased can still merge.
    let remote_head = git-run "-C" $primary "rev-parse" "--verify" "--quiet" $"refs/remotes/origin/($branch)"
    let on_remote = $remote_head.exit_code == 0

    if $on_remote {
        let extra = git-run "-C" $primary "cherry" $branch $"origin/($branch)"
        let missing = $extra.stdout | lines | where {|l| $l | str starts-with "+" }

        if $extra.exit_code != 0 or ($missing | is-not-empty) {
            refuse $"origin/($branch) has commits this branch does not" $"Pull them into the worktree first:\n\n  (ansi blue)git log ($branch)..origin/($branch)(ansi reset)"
        }
    }

    # --- Actions.
    # From here on, the script changes the repository.

    # Local main may be behind origin/main, and the checks above allow that.
    # The branch must land on top of the latest main.
    let synced = git-run "-C" $primary "merge" "--ff-only" "--quiet" "origin/main"

    if $synced.exit_code != 0 {
        fail "could not update local main" ($synced.stderr | str trim)
    }

    let merged = git-run "-C" $primary "merge" "--ff-only" "--quiet" $branch

    if $merged.exit_code != 0 {
        fail $"could not merge ($branch)" ($merged.stderr | str trim)
    }

    let head = (git-run "-C" $primary "rev-parse" "--short" "main").stdout | str trim
    print $"Merged (ansi green)($branch)(ansi reset) into main at ($head)"

    let pushed = git-run "-C" $primary "push" "--quiet" "origin" "main"

    if $pushed.exit_code != 0 {
        fail "could not push main" $"($pushed.stderr | str trim)\n\nLocal main is merged at ($head). Push it by hand, then run worktree-cleanup.nu."
    }

    print "Pushed main"

    mut incomplete = []

    # The script may run from inside the worktree.
    # The cleanup then deletes the folder the script stands in.
    # Moves to the primary checkout first, so the later commands still run.
    # Keep --env on main, so main does not return to the deleted folder when it ends.
    let started_in = $env.PWD
    cd $primary

    let cleanup = ^nu ($primary | path join "scripts" "worktree-cleanup.nu") $worktree | complete
    print -n $cleanup.stdout
    print -e -n $cleanup.stderr

    if $cleanup.exit_code != 0 {
        $incomplete = ($incomplete | append "the worktree or local branch")
    }

    # With the lease, the delete runs only if the remote branch has not moved.
    # If someone pushed to it after the check, the delete fails and their work stays.
    if $on_remote {
        let sha = $remote_head.stdout | str trim
        let deleted = git-run "-C" $primary "push" "--quiet" $"--force-with-lease=refs/heads/($branch):($sha)" "origin" $":refs/heads/($branch)"

        if $deleted.exit_code == 0 {
            print $"Deleted (ansi green)origin/($branch)(ansi reset)"
        } else {
            print -e $"($deleted.stderr | str trim)"
            $incomplete = ($incomplete | append $"origin/($branch)")
        }
    }

    if $started_in == $worktree or ($started_in | str starts-with $"($worktree)/") {
        print $"\nYour shell was inside the removed worktree. Move to (ansi blue)($primary)(ansi reset)."
    }

    if ($incomplete | is-not-empty) {
        print -e $"\n(ansi yellow)Partly done(ansi reset): main is pushed, but these are still there: ($incomplete | str join ', ')"
        exit 3
    }
}
