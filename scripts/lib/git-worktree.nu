# Repository worktree operations. Public operations return records; only the CLI prints/exits.

def result [operation: string, status: string, target: record, data: record = {}, issues: list = [], steps: list<string> = []] {
    {operation: $operation, status: $status, target: $target, data: $data, issues: $issues, completed_steps: $steps}
}

def issue [code: string, message: string] {
    {code: $code, message: $message}
}

def blocked [operation: string, target: record, code: string, message: string, data: record = {}] {
    result $operation blocked $target $data [(issue $code $message)]
}

def git [repo: string, args: list<string>] {
    try {
        with-env {
            GIT_OPTIONAL_LOCKS: '0', GIT_TERMINAL_PROMPT: '0',
            GIT_NO_LAZY_FETCH: '1', GIT_NO_REPLACE_OBJECTS: '1'
        } {
            ^git --no-pager -C $repo ...$args | complete
        }
    } catch {|err|
        {exit_code: 127, stdout: '', stderr: $err.msg}
    }
}

def checked [repo: string, args: list<string>] {
    let output = (git $repo $args)
    if $output.exit_code != 0 {
        error make {msg: $"Git failed \(($output.exit_code)\): ($output.stderr | str trim)"}
    }
    $output.stdout
}

# Remove the protocol's final LF, not whitespace that may belong to a path.
def line [value: string] { $value | str replace --regex '\n$' '' }

def oid [repo: string, ref: string] {
    let output = (git $repo [rev-parse --verify $"($ref)^{commit}"])
    if $output.exit_code == 0 { $output.stdout | str trim } else { null }
}

def branch-name [repo: string] {
    let output = (git $repo [symbolic-ref --quiet HEAD])
    let ref = (line $output.stdout)
    if $output.exit_code == 0 and ($ref | str starts-with 'refs/heads/') {
        $ref | str substring 11..
    } else { null }
}

def valid-branch [repo: string, branch: string] {
    let output = (git $repo [check-ref-format --branch $branch])
    ($output.exit_code == 0) and ((line $output.stdout) == $branch)
}

# worktree list --porcelain -z preserves spaces, tabs, quotes, and newlines in paths.
export def parse-worktrees [text: string] {
    $text | split row "\u{0}\u{0}" | where {|group| $group != '' } | each {|group|
        mut entry: record = {path: null, head: null, branch: null, locked: false, prunable: false}
        for field in ($group | split row "\u{0}" | where {|field| $field != '' }) {
            if ($field | str starts-with 'worktree ') {
                $entry.path = ($field | str substring 9..)
            } else if ($field | str starts-with 'HEAD ') {
                $entry.head = ($field | str substring 5..)
            } else if ($field | str starts-with 'branch refs/heads/') {
                $entry.branch = ($field | str substring 18..)
            } else if ($field == 'locked') or ($field | str starts-with 'locked ') {
                $entry.locked = true
            } else if ($field == 'prunable') or ($field | str starts-with 'prunable ') {
                $entry.prunable = true
            }
        }
        if $entry.path == null { error make {msg: 'Invalid worktree porcelain record.'} }
        $entry
    }
}

# With --no-renames, each porcelain v1 -z record has exactly one path.
export def parse-changes [text: string] {
    $text | split row "\u{0}" | where {|entry| $entry != '' } | each {|entry|
        if ($entry | str length) < 4 or ($entry | str substring 2..2) != ' ' {
            error make {msg: 'Invalid status porcelain record.'}
        }
        {code: ($entry | str substring 0..1), path: ($entry | str substring 3..)}
    }
}

def worktrees [repo: string] {
    parse-worktrees (checked $repo [worktree list --porcelain -z])
}

def common-dir [repo: string] {
    line (checked $repo [rev-parse --path-format=absolute --git-common-dir]) | path expand --strict
}

def context [repo: string] {
    if (checked $repo [rev-parse --is-bare-repository] | str trim) == 'true' {
        error make {msg: 'Bare repositories are not supported.'}
    }
    let entries = (worktrees $repo)
    if ($entries | is-empty) { error make {msg: 'No primary worktree found.'} }
    let primary = ($entries.0.path | path expand --strict)
    {
        primary: $primary,
        common: (common-dir $repo),
        current: (line (checked $repo [rev-parse --show-toplevel]) | path expand --strict),
        worktrees: $entries,
        main_head: (oid $repo refs/heads/main)
    }
}

def changes [repo: string] {
    let entries = (parse-changes (checked $repo [status --porcelain=v1 -z --no-renames --untracked-files=all --ignored=matching --ignore-submodules=none]))
    {
        tracked: ($entries | where {|entry| $entry.code not-in ['??' '!!'] } | length),
        untracked: ($entries | where code == '??' | length),
        ignored: ($entries | where code == '!!' | length),
        paths: ($entries | first 20),
        truncated: (($entries | length) > 20)
    }
}

def merged [repo: string, head: any, main: any] {
    if $head == null or $main == null { return null }
    let output = (git $repo [merge-base --is-ancestor $head $main])
    match $output.exit_code {
        0 => true,
        1 => false,
        _ => { error make {msg: $"Cannot determine merge status: ($output.stderr | str trim)"} }
    }
}

def upstream [repo: string, branch: any, head: any] {
    if $branch == null { return null }
    let ref = (line (checked $repo [for-each-ref '--format=%(upstream)' $"refs/heads/($branch)"]))
    if $ref == '' { return null }
    let upstream_head = (oid $repo $ref)
    let counts = if $head != null and $upstream_head != null {
        checked $repo [rev-list --left-right --count $"($head)...($upstream_head)"] | split words | each { into int }
    } else { [null null] }
    {ref: $ref, head: $upstream_head, ahead: $counts.0, behind: $counts.1, cached: true}
}

def target [ctx: record, branch: any, path: any] {
    {repo: $ctx.primary, branch: $branch, worktree: $path}
}

def select-worktree [ctx: record, branch: any] {
    if $branch == null {
        $ctx.worktrees | where path == $ctx.current
    } else {
        $ctx.worktrees | where branch == $branch
    }
}

# An existing registered path may now belong to a different repository/worktree.
def worktree-matches [ctx: record, entry: record] {
    try {
        let root = (line (checked $entry.path [rev-parse --show-toplevel]) | path expand --strict)
        ($root == ($entry.path | path expand --strict) and
            (common-dir $entry.path) == $ctx.common and
            (branch-name $entry.path) == $entry.branch)
    } catch { false }
}

def inspect-state [ctx: record, branch: any, entries: list] {
    let head = if $branch == null { oid $ctx.current HEAD } else { oid $ctx.primary $"refs/heads/($branch)" }
    let local = if ($entries | length) == 1 and ($entries.0.path | path exists) {
        changes $entries.0.path
    } else { null }
    {
        head: $head, main_head: $ctx.main_head,
        merged_into_main: (merged $ctx.primary $head $ctx.main_head),
        upstream: (upstream $ctx.primary $branch $head),
        worktrees: $entries, changes: $local
    }
}

# Repository-routing variables can make Git ignore --repo / -C. Refuse, rather than
# silently mutating a different repository or a caller-selected alternate index.
export def environment-issues [] {
    let routing = [GIT_DIR GIT_WORK_TREE GIT_COMMON_DIR GIT_INDEX_FILE GIT_NAMESPACE GIT_OBJECT_DIRECTORY GIT_ALTERNATE_OBJECT_DIRECTORIES GIT_CONFIG GIT_CONFIG_COUNT GIT_CONFIG_PARAMETERS GIT_SHALLOW_FILE GIT_GRAFT_FILE]
    let present = ($env | columns | where {|name| $name in $routing })
    if ($present | is-empty) { [] } else {
        [(issue unsafe_git_environment $"Unset repository-routing Git variables first: ($present | str join ', ').")]
    }
}

def guarded [operation: string, repo: string, branch: any, action: closure] {
    let initial = {repo: $repo, branch: $branch, worktree: null}
    let issues = (environment-issues)
    if not ($issues | is-empty) { return (result $operation blocked $initial {} $issues) }
    try {
        let ctx = (context $repo)
        if ($ctx.common | path join info grafts | path exists --no-symlink) {
            return (blocked $operation $initial grafts_present 'Legacy graft files are unsupported; remove the override before using the helper.')
        }
        if $branch != null and not (valid-branch $ctx.primary $branch) {
            return (blocked $operation $initial invalid_branch 'Use a literal, valid local branch name.')
        }
        do $action $ctx
    } catch {|err|
        result $operation error $initial {} [(issue git_error $err.msg)]
    }
}

export def inspect [repo: string, branch?: string] {
    guarded inspect $repo $branch {|ctx|
        let selected = if $branch == null { branch-name $ctx.current } else { $branch }
        let entries = (select-worktree $ctx $selected)
        let path = if ($entries | length) == 1 { $entries.0.path } else { null }
        if $path != null and ($path | path exists) and not (worktree-matches $ctx $entries.0) {
            return (blocked inspect (target $ctx $selected $path) target_mismatch 'The registered path no longer matches the selected repository and worktree.')
        }
        let state = (inspect-state $ctx $selected $entries)
        if $selected != null and $state.head == null {
            blocked inspect (target $ctx $selected $path) branch_missing 'The selected local branch does not exist.'
        } else {
            result inspect ok (target $ctx $selected $path) $state
        }
    }
}

def create-checked [ctx: record, branch: string] {
    let container = ($ctx.primary | path dirname | path join agents-worktrees)
    let path = ($container | path join ($branch | str replace --all '/' '-'))
    let selected = (target $ctx $branch $path)
    if $ctx.main_head == null { return (blocked create $selected main_missing 'Local main must have a commit.') }
    # Unlike commit resolution, raw existence also detects dangling symbolic refs.
    let existing = (git $ctx.primary [show-ref --exists $"refs/heads/($branch)"])
    if $existing.exit_code == 0 {
        return (blocked create $selected branch_exists 'The local branch ref already exists; inspect it instead.')
    }
    if $existing.exit_code != 2 {
        return (result create error $selected {} [(issue ref_lookup_failed $"Cannot inspect the branch reference: ($existing.stderr | str trim)")])
    }
    if ($container | path type) == 'symlink' or (($container | path expand) != ($container | path expand --no-symlink)) {
        return (blocked create $selected symlink_path 'The worktree container must not redirect through a symlink.')
    }
    if ($container | path exists --no-symlink) and ($container | path type) != 'dir' {
        return (blocked create $selected invalid_container 'The worktree container exists but is not a directory.')
    }
    if ($path | path exists --no-symlink) or ($ctx.worktrees | any {|entry| $entry.path == $path }) {
        return (blocked create $selected path_exists 'The derived worktree path already exists or is registered.')
    }
    if (oid $ctx.primary refs/heads/main) != $ctx.main_head {
        return (blocked create $selected state_changed 'main changed during inspection; inspect again.')
    }
    let container_existed = ($container | path exists --no-symlink)
    let output = (git $ctx.primary [worktree add -b $branch $path $ctx.main_head])
    if $output.exit_code == 0 {
        return (result create ok $selected {base: main, base_head: $ctx.main_head} [] [branch_created worktree_created])
    }
    # Native Git can leave a branch/worktree behind when checkout or a hook fails.
    # Report observed state, never assume that failed work should be rolled back.
    let observed = {
        branch_head: (oid $ctx.primary $"refs/heads/($branch)"),
        path_exists: ($path | path exists --no-symlink),
        container_created: ((not $container_existed) and ($container | path exists --no-symlink))
    }
    let status = if $observed.branch_head != null or $observed.path_exists or $observed.container_created { 'partial' } else { 'error' }
    result create $status $selected {base_head: $ctx.main_head, observed_after_failure: $observed} [(issue create_failed ($output.stderr | str trim))]
}

export def create [repo: string, branch: string] {
    guarded create $repo $branch {|ctx| create-checked $ctx $branch }
}

# Git status can hide assume-unchanged/skip-worktree entries. Do not remove such
# worktrees, or worktrees with submodules or an in-progress Git operation.
def extra-cleanup-issues [repo: string] {
    let flags = (checked $repo [ls-files -v -z] | split row "\u{0}" | where {|entry| $entry != '' } | each {|entry| $entry | str substring 0..0 })
    let hidden = ($flags | any {|flag| $flag == 'S' or $flag != ($flag | str uppercase) })
    let submodules = (checked $repo [ls-files --stage -z] | split row "\u{0}" | any {|entry| $entry | str starts-with '160000 ' })
    let pending = ([MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD rebase-apply rebase-merge sequencer BISECT_LOG] | where {|name|
        line (checked $repo [rev-parse --path-format=absolute --git-path $name]) | path exists
    })
    [
        (if $hidden { issue hidden_index_changes 'Assume-unchanged or skip-worktree entries require manual review.' }),
        (if $submodules { issue submodules_present 'Worktrees containing submodules require manual cleanup.' }),
        (if not ($pending | is-empty) { issue operation_in_progress $"Finish the Git operation first: ($pending | str join ', ')." })
    ] | compact
}

# Detached worktrees can still reserve a branch during rebase or bisect. Include
# these administrative refs instead of relying only on the displayed HEAD branch.
def branch-in-use [repo: string, branch: string, excluding: any = null] {
    let ref = $"refs/heads/($branch)"
    let common = (common-dir $repo)
    for entry in (worktrees $repo | where {|entry| $entry.path != $excluding }) {
        if $entry.branch == $branch { return true }
        if not ($entry.path | path exists) or (common-dir $entry.path) != $common {
            error make {msg: 'Cannot verify branch use in an unavailable or mismatched worktree.'}
        }
        for name in [rebase-merge/head-name rebase-apply/head-name rebase-merge/update-refs BISECT_START] {
            let marker = (line (checked $entry.path [rev-parse --path-format=absolute --git-path $name]))
            if ($marker | path exists) {
                let names = (open --raw $marker | lines)
                if $ref in $names or $branch in $names { return true }
            }
        }
    }
    false
}

def cleanup-check [ctx: record, branch: string, abandon: bool] {
    let entries = (select-worktree $ctx $branch)
    let path = if ($entries | length) == 1 { $entries.0.path } else { null }
    let selected = (target $ctx $branch $path)
    if $branch == 'main' { return (blocked cleanup $selected protected_target 'main cannot be removed.') }
    if ($entries | length) != 1 {
        return (blocked cleanup $selected worktree_not_unique 'Exactly one registered worktree must use the branch.')
    }
    let entry = $entries.0
    if ($entry.path | path expand) == $ctx.primary {
        return (blocked cleanup $selected protected_target 'The primary checkout cannot be removed.')
    }
    if $entry.locked or $entry.prunable or not ($entry.path | path exists) {
        return (blocked cleanup $selected unavailable_worktree 'Locked, missing, or prunable worktrees require manual attention.')
    }
    if ($entry.path | path expand --strict) != ($entry.path | path expand --no-symlink) {
        return (blocked cleanup $selected symlink_path 'The registered worktree path must not redirect through a symlink.')
    }
    let head = (oid $ctx.primary $"refs/heads/($branch)")
    if $head == null or not (worktree-matches $ctx $entry) {
        return (blocked cleanup $selected target_mismatch 'Worktree identity no longer matches the selected repository and branch.')
    }
    let symbolic = (git $ctx.primary [symbolic-ref --quiet $"refs/heads/($branch)"])
    if $symbolic.exit_code != 1 {
        return (blocked cleanup $selected symbolic_branch 'Cleanup requires an ordinary local branch ref, not a symbolic ref.')
    }
    if (branch-in-use $ctx.primary $branch $entry.path) {
        return (blocked cleanup $selected branch_in_use 'Another worktree or Git operation reserves this branch.')
    }
    let state = (inspect-state $ctx $branch $entries)
    let extra = (extra-cleanup-issues $entry.path)
    if not ($extra | is-empty) { return (result cleanup blocked $selected $state $extra) }
    if ($state.changes.tracked + $state.changes.untracked + $state.changes.ignored) > 0 {
        return (blocked cleanup $selected local_changes 'Preserve or discard local changes separately before cleanup.' $state)
    }
    if not $abandon and $state.merged_into_main != true {
        return (blocked cleanup $selected unmerged_branch 'The branch is not merged into main; explicit abandonment is required.' $state)
    }
    result cleanup ok $selected ($state | insert abandon $abandon)
}

def partial [selected: record, code: string, message: string, steps: list<string>, data: record = {}] {
    result cleanup partial $selected $data [(issue $code $message)] $steps
}

def finish-cleanup [ctx: record, snapshot: record] {
    let selected = $snapshot.target
    let ref = $"refs/heads/($selected.branch)"
    let removed = [worktree_removed]
    try {
        if (branch-in-use $ctx.primary $selected.branch) {
            return (partial $selected branch_in_use 'A worktree or Git operation now reserves this branch; it was retained.' $removed)
        }
        if (git $ctx.primary [symbolic-ref --quiet $ref]).exit_code != 1 {
            return (partial $selected state_changed 'The branch ref changed type; it was retained.' $removed)
        }
        if not $snapshot.data.abandon and (merged $ctx.primary $snapshot.data.head (oid $ctx.primary refs/heads/main)) != true {
            return (partial $selected state_changed 'Merge status changed; the branch was retained.' $removed)
        }
        # Compare-and-delete prevents discarding commits added since the safety check.
        let output = (git $ctx.primary [update-ref --no-deref -d $ref $snapshot.data.head])
        if $output.exit_code != 0 {
            return (partial $selected branch_delete_failed ($output.stderr | str trim) $removed {expected_head: $snapshot.data.head})
        }
    } catch {|err|
        return (partial $selected branch_delete_failed $err.msg $removed)
    }
    let deleted = [worktree_removed branch_deleted]
    try {
        if (oid $ctx.primary $ref) != null {
            return (partial $selected branch_recreated 'The branch was recreated concurrently; its configuration was retained.' $deleted)
        }
        let pattern = $'^branch\.($selected.branch | str escape-regex)\.[^.]+$'
        let keys = (git $ctx.primary [config --local --name-only --get-regexp $pattern])
        if $keys.exit_code == 0 {
            let output = (git $ctx.primary [config --local --remove-section $"branch.($selected.branch)"])
            if $output.exit_code != 0 {
                return (partial $selected config_cleanup_failed ($output.stderr | str trim) $deleted)
            }
        } else if $keys.exit_code != 1 {
            return (partial $selected config_cleanup_failed ($keys.stderr | str trim) $deleted)
        }
        result cleanup ok $selected {removed_head: $snapshot.data.head, abandoned: $snapshot.data.abandon} [] $deleted
    } catch {|err|
        partial $selected config_cleanup_failed $err.msg $deleted
    }
}

export def cleanup [repo: string, branch: string, --abandon] {
    guarded cleanup $repo $branch {|ctx|
        let snapshot = (cleanup-check $ctx $branch $abandon)
        if $snapshot.status != 'ok' { return $snapshot }
        let fresh = (cleanup-check (context $ctx.primary) $branch $abandon)
        if $fresh.status != 'ok' { return $fresh }
        if $fresh.target != $snapshot.target or $fresh.data.head != $snapshot.data.head or $fresh.data.main_head != $snapshot.data.main_head {
            return (blocked cleanup $snapshot.target state_changed 'Target or base changed during inspection; inspect again.')
        }
        # Stay in the primary checkout even when invoked from the directory removed below.
        cd $ctx.primary
        let output = (git $ctx.primary [worktree remove $snapshot.target.worktree])
        if $output.exit_code != 0 {
            let remains = ($snapshot.target.worktree | path exists --no-symlink)
            # A nonzero removal can still have deleted some files. Do not imply
            # that an existing directory proves the operation had no effects.
            return (result cleanup partial $snapshot.target {path_exists: $remains, mutation_attempted: true} [(issue worktree_remove_failed ($output.stderr | str trim))])
        }
        finish-cleanup $ctx $snapshot
    }
}
