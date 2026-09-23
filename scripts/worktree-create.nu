#!/usr/bin/env nu

# Create a worktree beside the primary checkout, on a new branch from main.
#
#   nu scripts/worktree-create.nu combat-review
#
# The folder is placed next to the primary checkout wherever the script is run
# from. `git worktree add ../<name>` only does that from the primary checkout;
# from inside another worktree, `../` nests the new one somewhere else.
#
# Main is updated from origin first, so the branch starts from current work and
# merges later as a fast-forward. Offline, the branch starts from local main.
#
# Exit codes: 0 done, 1 error, 2 refused.

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
# A failing external command does not change the script's exit code, so every
# result is checked by hand.
def git-run [...args: string] {
    ^git ...$args | complete
}

# The shared git dir sits in the primary checkout, so its parent is that
# checkout, even when this script runs from a worktree's copy.
def primary-checkout [root: string] {
    let common = git-run "-C" $root "rev-parse" "--git-common-dir"

    if $common.exit_code != 0 {
        fail "not a git repository" ($common.stderr | str trim)
    }

    $root | path join ($common.stdout | str trim) | path expand --no-symlink | path dirname
}

# Fast-forward main from origin when the primary checkout allows it. A failure
# is a warning, not a stop: a branch from slightly old main still works.
def update-main [primary: string] {
    let current = git-run "-C" $primary "branch" "--show-current"

    if ($current.stdout | str trim) != "main" {
        print -e $"(ansi yellow)Warning(ansi reset): the primary checkout is not on main, so main was not updated.\n"
        return
    }

    let pulled = git-run "-C" $primary "pull" "--ff-only" "--quiet"

    if $pulled.exit_code != 0 {
        print -e $"(ansi yellow)Warning(ansi reset): could not update main, so the branch starts from local main.\n"
        print -e $"($pulled.stderr | str trim)\n"
    }
}

def main [
    branch: string   # the new branch; a / in it becomes - in the folder name
] {
    # From the script's own location, so any working directory works.
    let root = $env.FILE_PWD | path join ".." | path expand
    let primary = primary-checkout $root

    if $branch == "main" {
        refuse "branch is main" "A worktree gets its own branch. main stays in the primary checkout."
    }

    let valid = git-run "-C" $primary "check-ref-format" "--branch" $branch

    if $valid.exit_code != 0 {
        fail $"invalid branch name '($branch)'" ($valid.stderr | str trim)
    }

    let known = git-run "-C" $primary "rev-parse" "--verify" "--quiet" $"refs/heads/($branch)"

    if $known.exit_code == 0 {
        refuse $"branch ($branch) already exists" $"Pick another name, or find its worktree with (ansi blue)git worktree list(ansi reset)."
    }

    let folder = $"($primary | path basename)-($branch | str replace --all '/' '-')"
    let target = $primary | path dirname | path join $folder

    # `path exists` follows links, so a dead symlink would look like free space.
    if ($target | path type | default "" | is-not-empty) {
        refuse "target path already exists" $"  (ansi red)($target)(ansi reset)\n\nPick another branch name, or remove what is there."
    }

    update-main $primary

    let added = git-run "-C" $primary "worktree" "add" "--quiet" "-b" $branch $target "main"

    if $added.exit_code != 0 {
        fail "could not create the worktree" ($added.stderr | str trim)
    }

    let head = git-run "-C" $target "rev-parse" "--short" "HEAD"

    print $"Created (ansi green)($target)(ansi reset) on branch (ansi green)($branch)(ansi reset) from main at ($head.stdout | str trim)"
}
