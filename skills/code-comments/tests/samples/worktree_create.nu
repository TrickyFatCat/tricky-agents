#!/usr/bin/env nu

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

def git-run [...args: string] {
    ^git ...$args | complete
}

def primary-checkout [root: string] {
    let common = git-run "-C" $root "rev-parse" "--git-common-dir"

    if $common.exit_code != 0 {
        fail "not a git repository" ($common.stderr | str trim)
    }

    $root | path join ($common.stdout | str trim) | path expand --no-symlink | path dirname
}

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
    branch: string
] {
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
