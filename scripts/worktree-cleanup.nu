#!/usr/bin/env nu

# Remove a finished worktree and the branch it had checked out.
#
#   nu scripts/worktree-cleanup.nu ../tricky-agents-combat
#   nu scripts/worktree-cleanup.nu ../tricky-agents-combat --abandon
#
# Creating a worktree needs no script: `git worktree add -b <branch> <path>`.
# Removing one does, because two things must agree — the worktree is gone and
# the branch is gone — and getting the second one wrong loses commits.
#
# The branch is deleted with a compare-and-delete against the head the worktree
# had. Anything committed to that branch between the merged check and the delete
# makes the delete fail rather than discard the work.
#
# A lock is cleared rather than refused. Once the worktree is clean and the
# branch is merged there is no work in progress left for the lock to guard.
#
# Exit codes: 0 done, 1 error, 2 refused, 3 worktree gone but branch kept.

# A refusal is not an error. The command is well-formed and a safety rule is
# declining it, so it gets plain output rather than Nushell's error box.
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

# Run git, handing back `complete`'s {exit_code, stdout, stderr}.
#
# Every git call goes through this. A failing external command stops the rest of
# the enclosing function but leaves the script's own exit code at 0, so an
# unchecked `git worktree remove` would fail silently and look like success.
def git-run [...args: string] {
    ^git ...$args | complete
}

# The value after a `git worktree list --porcelain` key, or "" when absent.
def field [lines: list<string>, prefix: string] {
    let hit = $lines | where {|l| $l | str starts-with $prefix }

    if ($hit | is-empty) {
        ""
    } else {
        $hit | first | str replace $prefix ""
    }
}

# Every worktree of this repository as {path, head, branch, detached, locked}.
#
# `locked` appears bare or with a reason after it. Reading it matters: git
# refuses to remove a locked worktree, so the script clears the lock first, and
# the reason is what it names in the output when it does.
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
            head: (field $lines "HEAD ")
            branch: (field $lines "branch refs/heads/")
            detached: ($lines | any {|l| ($l | str trim) == "detached" })
            locked: ($lines | any {|l| ($l | str trim) == "locked" or ($l | str starts-with "locked ") })
            reason: (field $lines "locked ")
        }
    }
}

# The two git dirs are the same path in the primary checkout; in a worktree the
# first sits under the second.
def is-primary [checkout: string] {
    let dir = git-run "-C" $checkout "rev-parse" "--git-dir"
    let common = git-run "-C" $checkout "rev-parse" "--git-common-dir"

    if $dir.exit_code != 0 or $common.exit_code != 0 {
        return false
    }

    let here = $checkout | path join ($dir.stdout | str trim) | path expand --no-symlink
    let shared = $checkout | path join ($common.stdout | str trim) | path expand --no-symlink

    $here == $shared
}

# The primary checkout, wherever this script was run from.
#
# The shared git dir sits in the primary checkout, so its parent is that
# checkout. A hint that says "pull" has to name the checkout holding `main`,
# not whichever worktree the script happens to live in.
def primary-checkout [root: string] {
    let common = git-run "-C" $root "rev-parse" "--git-common-dir"

    if $common.exit_code != 0 {
        return $root
    }

    $root | path join ($common.stdout | str trim) | path expand --no-symlink | path dirname
}

def main [
    path: string    # the worktree directory to remove
    --abandon       # remove the branch even though main has not merged it
] {
    # From the script's own location, so any working directory works.
    let root = $env.FILE_PWD | path join ".." | path expand

    # First, because every later check reads this path. A symlinked one would
    # let them describe a different directory than `git worktree remove` acts on.
    let literal = $path | path expand --no-symlink

    if $literal != ($path | path expand) {
        refuse "path resolves through a symlink" $"  (ansi red)($path)(ansi reset)\n\nIt leads to ($path | path expand). Pass the real directory."
    }

    if ($literal | path type) != "dir" {
        fail "no such directory" $"  (ansi red)($literal)(ansi reset)"
    }

    let all = worktrees $root
    let hit = $all | where path == $literal

    if ($hit | is-empty) {
        let known = $all | get path | each {|p| $"  ($p)" } | str join "\n"
        fail "not a worktree of this repository" $"  (ansi red)($literal)(ansi reset)\n\nKnown worktrees:\n\n($known)"
    }

    let wt = $hit | first

    if (is-primary $literal) {
        refuse "that is the primary checkout" $"  (ansi red)($literal)(ansi reset)\n\nThis is where the live symlinks point. Only worktrees are removable here."
    }

    if $wt.detached {
        refuse "worktree has a detached HEAD" $"  (ansi red)($literal)(ansi reset)\n\nThere is no branch to remove, so this script has nothing to guard. Use (ansi blue)git worktree remove(ansi reset) directly."
    }

    if $wt.branch == "main" {
        refuse "branch is main" $"  (ansi red)($literal)(ansi reset)\n\nmain is never deleted."
    }

    let status = git-run "-C" $literal "status" "--porcelain" "--ignored"

    if $status.exit_code != 0 {
        fail "could not read the worktree status" ($status.stderr | str trim)
    }

    let dirty = $status.stdout | str trim

    if ($dirty | is-not-empty) {
        refuse "worktree is not clean" $"($dirty)\n\nCommit, stash or delete these first. Ignored files count: they are not in git, so removing the worktree would lose them."
    }

    if (not $abandon) {
        let merged = git-run "-C" $root "branch" "--merged" "main" "--format" "%(refname:short)"

        if $merged.exit_code != 0 {
            fail "could not read merged branches" ($merged.stderr | str trim)
        }

        let names = $merged.stdout | lines | each {|l| $l | str trim }

        if $wt.branch not-in $names {
            # Local main is the authority: origin/main is a cache of the last
            # fetch, so it explains the refusal without ever lifting it.
            # Without this, "merge it" is the advice given to someone who did.
            let remote = git-run "-C" $root "branch" "--merged" "origin/main" "--format" "%(refname:short)"
            let on_remote = $remote.exit_code == 0 and ($wt.branch in ($remote.stdout | lines | each {|l| $l | str trim }))

            if $on_remote {
                refuse $"branch ($wt.branch) is merged on the remote, not locally" $"  (ansi red)($literal)(ansi reset)\n\norigin/main has it as of your last fetch; local main does not. Update the primary checkout, then run this again:\n\n  (ansi blue)git -C (primary-checkout $root) pull --ff-only(ansi reset)"
            }

            refuse $"branch ($wt.branch) is not merged into main" $"  (ansi red)($literal)(ansi reset)\n\nMerge it, or pass (ansi blue)--abandon(ansi reset) to throw the work away."
        }
    }

    # After the clean and merged checks, never before them. A lock is cleared
    # only for a worktree this script is about to remove, so a refusal higher up
    # leaves it in place for whoever set it.
    if $wt.locked {
        let why = if ($wt.reason | is-empty) { "no reason recorded" } else { $wt.reason }
        let unlocked = git-run "-C" $root "worktree" "unlock" $literal

        if $unlocked.exit_code != 0 {
            fail "could not unlock the worktree" ($unlocked.stderr | str trim)
        }

        print $"Cleared lock (ansi yellow)($why)(ansi reset)"
    }

    let removed = git-run "-C" $root "worktree" "remove" $literal

    if $removed.exit_code != 0 {
        let note = if $wt.locked { "\n\nThe lock was cleared first, so the worktree is now unlocked." } else { "" }

        fail "could not remove the worktree" $"($removed.stderr | str trim)($note)"
    }

    # The ref goes only if it still points at the head the worktree had, so a
    # commit added since the checks above fails this instead of being discarded.
    let ref = $"refs/heads/($wt.branch)"
    let unref = git-run "-C" $root "update-ref" "-d" $ref $wt.head

    if $unref.exit_code != 0 {
        print -e $"(ansi yellow)Partly done(ansi reset): worktree removed, branch kept\n"
        print -e $"  (ansi green)($literal)(ansi reset)  removed"
        print -e $"  (ansi yellow)($wt.branch)(ansi reset)  still here, it moved past ($wt.head | str substring 0..7)\n"
        print -e ($unref.stderr | str trim)
        print -e $"\nCheck it with (ansi blue)git log ($wt.branch)(ansi reset), then delete it yourself."
        exit 3
    }

    print $"Removed (ansi green)($literal)(ansi reset) and branch (ansi green)($wt.branch)(ansi reset) at ($wt.head | str substring 0..7)"
}
