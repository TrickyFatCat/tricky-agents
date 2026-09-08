#!/usr/bin/env nu

use lib/git-worktree.nu

# Exit codes: 0 success, 2 blocked, 1 error, 3 partial completion.
def emit [response: record, human: bool] {
    if $human {
        print $"($response.operation): ($response.status)"
        print $"Repository: ($response.target.repo)"
        if $response.target.branch != null { print $"Branch: ($response.target.branch)" }
        if $response.target.worktree != null { print $"Worktree: ($response.target.worktree)" }
        if $response.operation == 'inspect' and $response.status == 'ok' {
            print $"Merged into main: ($response.data.merged_into_main | default 'unknown')"
            if $response.data.changes != null {
                let changes = $response.data.changes
                print $"Local files: ($changes.tracked) tracked changes, ($changes.untracked) untracked, ($changes.ignored) ignored"
            }
            print 'Upstream information is locally cached; no fetch was performed.'
        }
        for entry in $response.issues { print $"($entry.code): ($entry.message)" }
        if not ($response.completed_steps | is-empty) {
            print $"Completed: ($response.completed_steps | str join ', ')"
        }
    } else {
        print ($response | to json --raw)
    }
    exit (match $response.status { ok => 0, blocked => 2, partial => 3, _ => 1 })
}

# Inspect a repository's current branch, or an explicitly selected local branch.
def 'main inspect' [branch?: string, --repo: string = '.', --human] {
    emit (git-worktree inspect $repo $branch) $human
}

# Create a branch and sibling worktree from the local main commit. Does not fetch.
def 'main create' [branch: string, --repo: string = '.', --human] {
    emit (git-worktree create $repo $branch) $human
}

# Remove a clean linked worktree and local branch. --abandon permits unmerged commits,
# but never uncommitted, untracked, or ignored files. No remote branches are deleted.
def 'main cleanup' [branch: string, --repo: string = '.', --abandon, --human] {
    let location = ($repo | path expand)
    # Keep this child process in a retained directory so Nushell can emit the
    # result even when the invocation directory is the worktree being removed.
    cd ($location | path split | first)
    emit (git-worktree cleanup $location $branch --abandon=$abandon) $human
}

# Inspect, create, or clean up Git worktrees. See docs/git-worktree-helper.md.
def main [] {
    help main | print
}
