#!/usr/bin/env nu

# Merge a finished worktree into main, then clean up:
#
#   1. Fast-forward main to the branch.
#   2. Push main.
#   3. Remove the worktree and the local branch.
#   4. Delete the branch on origin.
#
#   nu scripts/worktree-merge.nu                          the worktree you are in
#   nu scripts/worktree-merge.nu ../tricky-agents-combat
#
# All checks run before step 1. A refusal leaves everything as it was.
#
# The merge is fast-forward only. If main has new commits, the script refuses.
# Rebase the branch onto origin/main, then run it again.
#
# Step 3 uses the primary checkout's worktree-cleanup.nu, so its safety checks
# still run. The worktree's own copy is not used, because step 3 deletes it.
#
# Exit codes: 0 done, 1 error, 2 refused, 3 main pushed but cleanup incomplete.

# A refusal is not an error. The command is valid, but a safety rule stops it.
# So it prints plain text, not Nushell's error box.
def refuse [msg: string, detail: string] {
    print -e $"(ansi red)Refused(ansi reset): ($msg)\n"
    print -e $detail
    exit 2
}

def fail [msg: string, detail: string] {
    error make --unspanned {
        msg: $msg
        help: $detail
    }
}

# Without `complete`, a failed git call stops the whole script with exit 1. The
# caller could not turn it into a refusal or a clear message. After the push,
# stopping early would also skip the rest of the cleanup report.
def git-run [...args: string] {
    ^git ...$args | complete
}

# The text after a key in `git worktree list --porcelain` output, or "" when
# the key is missing.
def field [lines: list<string>, prefix: string] {
    let hit = $lines | where {|l| $l | str starts-with $prefix }

    if ($hit | is-empty) {
        ""
    } else {
        $hit | first | str replace $prefix ""
    }
}

# One record per worktree: {path, branch, detached}.
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

# All worktrees share one git folder, and it lives inside the primary checkout.
# So the parent of that folder is the primary checkout. This also works when the
# script runs from a worktree's copy.
def primary-checkout [root: string] {
    let common = git-run "-C" $root "rev-parse" "--git-common-dir"

    if $common.exit_code != 0 {
        fail "not a git repository" ($common.stderr | str trim)
    }

    $root | path join ($common.stdout | str trim) | path expand --no-symlink | path dirname
}

# True when every commit in `ancestor` is already in `descendant`.
def contains [repo: string, ancestor: string, descendant: string] {
    (git-run "-C" $repo "merge-base" "--is-ancestor" $ancestor $descendant).exit_code == 0
}

# Changed and untracked files, one per line. Empty means clean.
def status-of [repo: string, ...extra: string] {
    let status = git-run "-C" $repo "status" "--porcelain" ...$extra

    if $status.exit_code != 0 {
        fail $"could not read the status of ($repo)" ($status.stderr | str trim)
    }

    $status.stdout | str trim
}

# Refuse when the committed global-agents.md does not match a fresh build of
# its sources.
#
# The tools link to that file, so the merge makes it live at once. The check
# uses the worktree's own build script. A branch that changes the build is
# checked with its own new rules.
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

# Without --env, Nushell goes back to the starting folder when main ends. If
# that folder was the removed worktree, the script fails after all the work is
# done. --env keeps the `cd` to the primary checkout made before the cleanup.
def --env main [
    path?: string   # the worktree to merge. The default is the current folder.
] {
    # Found from the script's own location, not from the current folder.
    let root = $env.FILE_PWD | path join ".." | path expand
    let primary = primary-checkout $root

    let top = git-run "-C" ($path | default $env.PWD) "rev-parse" "--show-toplevel"

    if $top.exit_code != 0 {
        fail "not inside a git checkout" ($top.stderr | str trim)
    }

    let worktree = $top.stdout | str trim | path expand --no-symlink

    # --- Checks. Nothing changes until all of them pass.

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

    # The remote branch may hold commits pushed from another place. `git cherry`
    # marks a commit with + when the local branch has no equal change. A commit
    # that was only rebased has an equal change, so it does not block the merge.
    let remote_head = git-run "-C" $primary "rev-parse" "--verify" "--quiet" $"refs/remotes/origin/($branch)"
    let on_remote = $remote_head.exit_code == 0

    if $on_remote {
        let extra = git-run "-C" $primary "cherry" $branch $"origin/($branch)"
        let missing = $extra.stdout | lines | where {|l| $l | str starts-with "+" }

        if $extra.exit_code != 0 or ($missing | is-not-empty) {
            refuse $"origin/($branch) has commits this branch does not" $"Pull them into the worktree first:\n\n  (ansi blue)git log ($branch)..origin/($branch)(ansi reset)"
        }
    }

    # --- Actions. From here on, the script changes the repository.

    # Local main may be behind origin/main. The checks above allow that, and the
    # branch must land on top of the latest main.
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

    # When the script runs from inside the worktree, the cleanup deletes the
    # folder it stands in. Nushell then refuses to start any more commands.
    let started_in = $env.PWD
    cd $primary

    let cleanup = ^nu ($primary | path join "scripts" "worktree-cleanup.nu") $worktree | complete
    print -n $cleanup.stdout
    print -e -n $cleanup.stderr

    if $cleanup.exit_code != 0 {
        $incomplete = ($incomplete | append "the worktree or local branch")
    }

    # The lease deletes the remote branch only if it still points at the commit
    # checked above. If someone pushed to it since then, the delete fails and
    # their work stays.
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
