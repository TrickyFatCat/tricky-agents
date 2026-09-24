#!/usr/bin/env nu

# Creates a new branch from main, in a new worktree beside the primary checkout.

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
# Callers decide whether a failure is a refusal, a warning or an error.
def git-run [...args: string] {
    ^git ...$args | complete
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

# Updates main from origin.
# Skips the update with a warning when the primary checkout is not on main.
# A failure is only a warning, because a branch from an older main still works.
# If main moves on before the merge, worktree-merge.nu asks for a rebase.
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

# Creates a new branch from main, in a new worktree beside the primary checkout.
#
#   nu scripts/worktree-create.nu combat-review
#
# The folder always goes next to the primary checkout.
# This holds even when you run the script from inside another worktree.
# A plain `git worktree add ../<name>` puts it there only from the primary checkout.
# The folder name is the primary checkout's name, a dash, and the branch name.
#
# The script first updates main from origin.
# The branch then starts from the latest work, and the merge later needs no rebase.
# If the update fails, for example offline, the branch starts from local main.
# The same happens when the primary checkout is not on main.
#
# Refuses when the branch is main, when the branch already exists, or when the folder path is in use.
#
# Exit codes: 0 done, 1 error, 2 refused.
def main [
    branch: string   # the new branch name (a / becomes - in the folder name)
] {
    # Resolves the repository from the script's location, not from the working directory.
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

    # Checks path type, not path exists, so a broken symlink counts as in use.
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
