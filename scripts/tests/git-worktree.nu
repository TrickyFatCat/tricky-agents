#!/usr/bin/env nu

use std/assert
use ../lib/git-worktree.nu

# Every mutation in this suite targets a newly created temporary repository.
def g [repo: string, args: list<string>] {
    let output = (^git -C $repo ...$args | complete)
    if $output.exit_code != 0 { error make {msg: $"Fixture Git command failed: ($output.stderr | str trim)"} }
    $output.stdout | str replace --regex '\n$' ''
}

def fixture [root: string, name: string] {
    let home = ($root | path join $name)
    let repo = ($home | path join 'repo space')
    mkdir $repo
    g $repo [init --initial-branch=main] | ignore
    'baseline' | save ($repo | path join note.txt)
    "ignored/\n" | save ($repo | path join .gitignore)
    g $repo [add .] | ignore
    g $repo [commit -m initial] | ignore
    {home: $home, repo: $repo}
}

def head [repo: string, branch: string] { g $repo [rev-parse $"refs/heads/($branch)"] }

def missing-branch [repo: string, branch: string] {
    let output = (^git -C $repo show-ref --verify --quiet $"refs/heads/($branch)" | complete)
    assert equal $output.exit_code 1
}

def made [repo: string, branch: string] {
    let response = (git-worktree create $repo $branch)
    assert equal $response.status ok
    $response.target.worktree
}

def blocked-by [response: record, code: string] {
    assert equal $response.status blocked
    assert ($response.issues | any {|entry| $entry.code == $code })
}

def run-cli [script: string, repo: string, args: list<string>] {
    let output = (^$nu.current-exe --no-config-file $script ...$args --repo $repo | complete)
    if ($output.stdout | lines | length) != 1 {
        error make {msg: $"Expected one JSON result: ($output | to json --raw)"}
    }
    {exit_code: $output.exit_code, response: ($output.stdout | from json)}
}

def cases [root: string, script: string] {
    [
        {name: 'NUL parsers preserve unusual paths', run: {||
            let strange = "/tmp/a space\tquote\"\n雪"
            let trees = (git-worktree parse-worktrees $"worktree ($strange)\u{0}HEAD abc\u{0}branch refs/heads/topic/one\u{0}locked a reason\u{0}\u{0}worktree /tmp/other\u{0}HEAD def\u{0}detached\u{0}\u{0}")
            assert equal ($trees | length) 2
            assert equal $trees.0.path $strange
            assert equal $trees.0.branch topic/one
            assert $trees.0.locked
            assert equal $trees.1.branch null
            let changed = (git-worktree parse-changes " M line\nname\u{0}?? quote\"name\u{0}!! ignored/\u{0}")
            assert equal $changed.0.path "line\nname"
            assert equal $changed.1.code '??'
            assert equal $changed.2.code '!!'
        }}
        {name: 'create and inspect preserve a dirty primary', run: {||
            let f = (fixture $root create)
            'unrelated edit' | save --force ($f.repo | path join note.txt)
            let created = (run-cli $script $f.repo [create topic/one])
            assert equal $created.exit_code 0
            let path = $created.response.target.worktree
            assert equal $path ($f.home | path join agents-worktrees topic-one)
            assert equal (head $f.repo topic/one) (head $f.repo main)
            let inspected = (run-cli $script $path [inspect])
            assert equal $inspected.response.target.branch topic/one
            assert equal $inspected.response.target.repo $f.repo
            assert equal $inspected.response.data.changes.tracked 0
            assert equal (open --raw ($f.repo | path join note.txt)) 'unrelated edit'
            let removed = (run-cli $script $path [cleanup topic/one])
            assert equal $removed.exit_code 0
            assert (not ($path | path exists))
            missing-branch $f.repo topic/one
            assert equal (open --raw ($f.repo | path join note.txt)) 'unrelated edit'
        }}
        {name: 'branch, directory, and flattened-name collisions', run: {||
            let f = (fixture $root collisions)
            made $f.repo a/b-c | ignore
            blocked-by (git-worktree create $f.repo a/b-c) branch_exists
            blocked-by (git-worktree create $f.repo a-b/c) path_exists
            let occupied = ($f.home | path join agents-worktrees occupied)
            mkdir $occupied
            'keep me' | save ($occupied | path join sentinel)
            blocked-by (git-worktree create $f.repo occupied) path_exists
            assert equal (open --raw ($occupied | path join sentinel)) 'keep me'
            for branch in ['../escape' '-bad' 'bad name' '@{-1}'] {
                blocked-by (git-worktree create $f.repo $branch) invalid_branch
            }
            missing-branch $f.repo occupied
        }}
        {name: 'cleanup protects main and the primary checkout', run: {||
            let f = (fixture $root protected)
            blocked-by (git-worktree cleanup $f.repo main --abandon) protected_target
            g $f.repo [switch -c primary-other] | ignore
            blocked-by (git-worktree cleanup $f.repo primary-other --abandon) protected_target
            assert ($f.repo | path exists)
        }}
        {name: 'merged cleanup deletes only the exact local branch configuration', run: {||
            let f = (fixture $root configuration)
            let branch = 'topic/a+b'
            let path = (made $f.repo $branch)
            g $f.repo [config $"branch.($branch).description" 'remove this'] | ignore
            g $f.repo [config $"branch.($branch).extra.description" 'preserve this'] | ignore
            let response = (git-worktree cleanup $f.repo $branch)
            assert equal $response.status ok
            assert equal $response.completed_steps [worktree_removed branch_deleted]
            assert (not ($path | path exists))
            missing-branch $f.repo $branch
            assert equal (g $f.repo [config --get $"branch.($branch).extra.description"]) 'preserve this'
            let removed = (^git -C $f.repo config --get $"branch.($branch).description" | complete)
            assert equal $removed.exit_code 1
        }}
        {name: 'unmerged work requires abandonment and remote branches survive', run: {||
            let f = (fixture $root abandon)
            let remote = ($f.home | path join remote.git)
            g $f.repo [init --bare $remote] | ignore
            g $f.repo [remote add origin $remote] | ignore
            let path = (made $f.repo topic/abandon)
            'unique work' | save --force ($path | path join note.txt)
            g $path [commit -am unique] | ignore
            g $path [push origin topic/abandon] | ignore
            let expected = (head $f.repo topic/abandon)
            let refused = (run-cli $script $f.repo [cleanup topic/abandon])
            assert equal $refused.exit_code 2
            blocked-by $refused.response unmerged_branch
            assert ($path | path exists)
            let removed = (run-cli $script $f.repo [cleanup topic/abandon --abandon])
            assert equal $removed.exit_code 0
            assert $removed.response.data.abandoned
            assert equal $removed.response.data.removed_head $expected
            assert (not ($path | path exists))
            missing-branch $f.repo topic/abandon
            assert equal (head $remote topic/abandon) $expected
        }}
        {name: 'tracked, staged, untracked, and ignored files always block abandonment', run: {||
            let f = (fixture $root local-changes)
            let path = (made $f.repo topic/dirty)
            let expected = (head $f.repo topic/dirty)
            'modified' | save --force ($path | path join note.txt)
            for abandon in [false true] {
                blocked-by (git-worktree cleanup $f.repo topic/dirty --abandon=$abandon) local_changes
            }
            g $path [add note.txt] | ignore
            blocked-by (git-worktree cleanup $f.repo topic/dirty --abandon) local_changes
            'new' | save ($path | path join "new\n雪")
            mkdir ($path | path join ignored)
            'ignored data' | save ($path | path join ignored secret)
            let response = (git-worktree cleanup $f.repo topic/dirty --abandon)
            blocked-by $response local_changes
            assert equal $response.data.changes.tracked 1
            assert equal $response.data.changes.untracked 1
            assert equal $response.data.changes.ignored 1
            assert equal (head $f.repo topic/dirty) $expected
            assert equal (open --raw ($path | path join ignored secret)) 'ignored data'
        }}
        {name: 'dirty-path output is bounded without hiding counts', run: {||
            let f = (fixture $root many-files)
            let path = (made $f.repo topic/many)
            for n in 1..25 { 'data' | save ($path | path join $"file-($n)") }
            let response = (git-worktree inspect $f.repo topic/many)
            assert equal $response.data.changes.untracked 25
            assert equal ($response.data.changes.paths | length) 20
            assert $response.data.changes.truncated
            blocked-by (git-worktree cleanup $f.repo topic/many --abandon) local_changes
        }}
        {name: 'hidden index flags block cleanup', run: {||
            let f = (fixture $root index-flags)
            for flag in [assume-unchanged skip-worktree] {
                let branch = $"topic/($flag)"
                let path = (made $f.repo $branch)
                g $path [update-index $"--($flag)" note.txt] | ignore
                'hidden edit' | save --force ($path | path join note.txt)
                blocked-by (git-worktree cleanup $f.repo $branch --abandon) hidden_index_changes
                assert equal (open --raw ($path | path join note.txt)) 'hidden edit'
            }
        }}
        {name: 'locks and pending operations block cleanup', run: {||
            let f = (fixture $root pending)
            let path = (made $f.repo topic/pending)
            g $f.repo [worktree lock --reason 'keep this' $path] | ignore
            blocked-by (git-worktree cleanup $f.repo topic/pending --abandon) unavailable_worktree
            g $f.repo [worktree unlock $path] | ignore
            let marker = (g $path [rev-parse --path-format=absolute --git-path MERGE_HEAD])
            (head $f.repo main) | save $marker
            blocked-by (git-worktree cleanup $f.repo topic/pending --abandon) operation_in_progress
            assert ($marker | path exists)
        }}
        {name: 'branches checked out more than once are protected', run: {||
            let f = (fixture $root multiple)
            let first = (made $f.repo topic/shared)
            let second = ($f.home | path join second)
            g $f.repo [worktree add --force $second topic/shared] | ignore
            blocked-by (git-worktree cleanup $f.repo topic/shared --abandon) worktree_not_unique
            assert ($first | path exists)
            assert ($second | path exists)
        }}
        {name: 'missing and detached targets are inspectable but not guessed for cleanup', run: {||
            let f = (fixture $root detached)
            let path = ($f.home | path join detached)
            g $f.repo [worktree add --detach $path main] | ignore
            let response = (git-worktree inspect $path)
            assert equal $response.status ok
            assert equal $response.target.branch null
            assert equal $response.target.worktree $path
            blocked-by (git-worktree inspect $f.repo nonexistent) branch_missing
            blocked-by (git-worktree cleanup $f.repo nonexistent --abandon) worktree_not_unique
        }}
        {name: 'NUL path handling works in real newline and Unicode directories', run: {||
            let f = (fixture $root "newline\n雪")
            let path = (made $f.repo topic/unusual)
            let response = (run-cli $script $f.repo [inspect topic/unusual])
            assert equal $response.response.target.worktree $path
            assert equal $response.response.target.repo $f.repo
            assert equal (git-worktree cleanup $f.repo topic/unusual).status ok
        }}
        {name: 'symlink containers and dangling path collisions are refused', run: {||
            let f = (fixture $root symlinks)
            let outside = ($f.home | path join outside)
            mkdir $outside
            ^ln -s $outside ($f.home | path join agents-worktrees)
            blocked-by (git-worktree create $f.repo topic/link) symlink_path
            let f2 = (fixture $root dangling)
            mkdir ($f2.home | path join agents-worktrees)
            ^ln -s ($f2.home | path join absent) ($f2.home | path join agents-worktrees topic-link)
            blocked-by (git-worktree create $f2.repo topic/link) path_exists
        }}
        {name: 'invalid worktree containers are rejected before branch creation', run: {||
            let f = (fixture $root file-container)
            'preserve this file' | save ($f.home | path join agents-worktrees)
            blocked-by (git-worktree create $f.repo topic/container) invalid_container
            missing-branch $f.repo topic/container
            let f2 = (fixture $root dangling-container)
            ^ln -s ($f2.home | path join absent) ($f2.home | path join agents-worktrees)
            blocked-by (git-worktree create $f2.repo topic/container) symlink_path
            missing-branch $f2.repo topic/container
        }}
        {name: 'missing main and bare repositories cannot be used for creation', run: {||
            let f = (fixture $root missing-main)
            g $f.repo [branch -m main other] | ignore
            blocked-by (git-worktree create $f.repo topic/new) main_missing
            missing-branch $f.repo topic/new
            let bare = ($f.home | path join bare.git)
            g $f.repo [init --bare $bare] | ignore
            assert equal (git-worktree create $bare topic/new).status error
            missing-branch $bare topic/new
        }}
        {name: 'repository-routing environment variables are rejected', run: {||
            let f = (fixture $root environment)
            with-env {GIT_DIR: ($f.repo | path join .git)} {
                blocked-by (git-worktree create $f.repo topic/environment) unsafe_git_environment
            }
            missing-branch $f.repo topic/environment
        }}
        {name: 'the test runner rejects inherited metadata routing before fixtures', run: {||
            let f = (fixture $root runner-environment)
            let index = ($f.repo | path join .git index)
            let before = (open --raw $index | hash sha256)
            let expected = (head $f.repo main)
            let suite = ($script | path dirname | path join tests/git-worktree.nu)
            for variables in [{GIT_INDEX_FILE: $index} {GIT_DIR: ($f.repo | path join .git)} {GIT_WORK_TREE: $f.repo}] {
                let output = (with-env $variables {
                    ^$nu.current-exe --no-config-file $suite | complete
                })
                assert equal $output.exit_code 2
                let response = ($output.stdout | from json)
                assert equal $response.status blocked
                assert equal $response.tests 0
                assert equal (open --raw $index | hash sha256) $before
                assert equal (head $f.repo main) $expected
                assert equal (open --raw ($f.repo | path join note.txt)) baseline
            }
        }}
        {name: 'branch identity is exact when tags and other branches collide', run: {||
            let f = (fixture $root ref-ambiguity)
            let path = (made $f.repo topic)
            g $f.repo [tag topic main] | ignore
            let other = (made $f.repo heads/topic)
            let response = (run-cli $script $path [inspect])
            assert equal $response.response.target.branch topic
            assert equal $response.response.target.worktree $path
            assert equal (git-worktree cleanup $f.repo topic).status ok
            missing-branch $f.repo topic
            assert ($other | path exists)
            assert equal (g $f.repo [rev-parse refs/tags/topic]) (head $f.repo main)
            assert equal (head $f.repo heads/topic) (head $f.repo main)
        }}
        {name: 'partial-clone checkout never lazily fetches missing blobs', run: {||
            let f = (fixture $root partial-clone)
            let remote = ($f.home | path join remote.git)
            let clone = ($f.home | path join clone)
            g $f.repo [init --bare $remote] | ignore
            g $remote [config uploadpack.allowFilter 'true'] | ignore
            g $remote [symbolic-ref HEAD refs/heads/main] | ignore
            g $f.repo [remote add origin $remote] | ignore
            g $f.repo [push origin main] | ignore
            g $f.repo [clone --no-local --filter=blob:none --no-checkout $remote $clone] | ignore
            let blob = (g $f.repo [rev-parse main:note.txt])
            let before = (with-env {GIT_NO_LAZY_FETCH: '1'} {
                ^git -C $clone cat-file -e $blob | complete
            })
            assert ($before.exit_code != 0)
            let trace = ($f.home | path join trace.log)
            let response = (with-env {GIT_TRACE: $trace, GIT_NO_LAZY_FETCH: '0'} {
                git-worktree create $clone topic/offline
            })
            assert equal $response.status partial
            let after = (with-env {GIT_NO_LAZY_FETCH: '1'} {
                ^git -C $clone cat-file -e $blob | complete
            })
            assert ($after.exit_code != 0)
            assert (not (open --raw $trace | str contains ' fetch '))
        }}
        {name: 'replacement refs cannot authorize normal cleanup', run: {||
            let f = (fixture $root replacement-ancestry)
            let path = (made $f.repo topic/underlying)
            let tree = (g $f.repo [rev-parse 'main^{tree}'])
            let orphan = (g $f.repo [commit-tree $tree -m unrelated])
            g $f.repo [update-ref refs/heads/topic/underlying $orphan] | ignore
            g $f.repo [replace --graft main $orphan] | ignore
            let adjusted = (^git -C $f.repo merge-base --is-ancestor $orphan refs/heads/main | complete)
            assert equal $adjusted.exit_code 0
            let response = (git-worktree inspect $f.repo topic/underlying)
            assert equal $response.data.merged_into_main false
            blocked-by (git-worktree cleanup $f.repo topic/underlying) unmerged_branch
            assert ($path | path exists)
            assert equal (head $f.repo topic/underlying) $orphan
        }}
        {name: 'legacy graft files and graft environment overrides are refused', run: {||
            let f = (fixture $root grafts)
            let path = (made $f.repo topic/grafts)
            let marker = ($f.repo | path join .git info grafts)
            mkdir ($marker | path dirname)
            $"(head $f.repo main)\n" | save $marker
            blocked-by (git-worktree inspect $f.repo topic/grafts) grafts_present
            blocked-by (git-worktree cleanup $f.repo topic/grafts --abandon) grafts_present
            blocked-by (git-worktree create $f.repo topic/another) grafts_present
            assert ($path | path exists)
            with-env {GIT_GRAFT_FILE: $marker} {
                blocked-by (git-worktree inspect $f.repo) unsafe_git_environment
            }
        }}
        {name: 'creation preserves dangling symbolic refs and their destinations', run: {||
            let f = (fixture $root dangling-branch)
            g $f.repo [symbolic-ref refs/heads/topic refs/heads/other] | ignore
            blocked-by (git-worktree create $f.repo topic) branch_exists
            assert equal (g $f.repo [symbolic-ref refs/heads/topic]) refs/heads/other
            missing-branch $f.repo other
            assert (not ($f.home | path join agents-worktrees topic | path exists))
        }}
        {name: 'raw-ref lookup failures cannot create worktrees', run: {||
            let f = (fixture $root malformed-branch)
            let ref = ($f.repo | path join .git refs heads topic)
            'not an oid' | save $ref
            let response = (git-worktree create $f.repo topic)
            assert equal $response.status error
            assert equal $response.issues.0.code ref_lookup_failed
            assert equal (open --raw $ref) 'not an oid'
            assert (not ($f.home | path join agents-worktrees topic | path exists))
        }}
        {name: 'inspection refuses a different repository occupying a stale path', run: {||
            let f = (fixture $root stale-registration)
            let path = (made $f.repo topic/stale)
            let moved = ($f.home | path join moved-worktree)
            mv $path $moved
            let other = (fixture $root replacement-repository)
            mv $other.repo $path
            'foreign repository' | save --force ($path | path join note.txt)
            blocked-by (git-worktree inspect $f.repo topic/stale) target_mismatch
            assert equal (git-worktree cleanup $f.repo topic/stale --abandon).status blocked
            assert equal (open --raw ($path | path join note.txt)) 'foreign repository'
            assert equal (open --raw ($moved | path join note.txt)) baseline
        }}
        {name: 'upstream information stays cached without fetching', run: {||
            let f = (fixture $root cached)
            let remote = ($f.home | path join remote.git)
            g $f.repo [init --bare $remote] | ignore
            g $f.repo [remote add origin $remote] | ignore
            g $f.repo [push --set-upstream origin main] | ignore
            let old = (head $f.repo main)
            let tree = (g $f.repo [rev-parse 'main^{tree}'])
            let advance = (g $f.repo [commit-tree $tree -p $old -m advance])
            g $f.repo [push origin $"($advance):refs/heads/staging"] | ignore
            g $remote [update-ref refs/heads/main $advance] | ignore
            let response = (git-worktree inspect $f.repo main)
            assert equal $response.data.upstream.head $old
            assert $response.data.upstream.cached
            assert equal $response.data.upstream.ahead 0
            assert equal $response.data.upstream.behind 0
            assert equal (g $f.repo [rev-parse refs/remotes/origin/main]) $old
        }}
        {name: 'failed checkout hooks report remaining creation state', run: {||
            let f = (fixture $root hook-failure)
            let hook = ($f.repo | path join .git hooks post-checkout)
            mkdir ($hook | path dirname)
            "#!/bin/sh\nexit 1\n" | save $hook
            ^chmod +x $hook
            let response = (git-worktree create $f.repo topic/hook)
            assert equal $response.status partial
            assert $response.data.observed_after_failure.path_exists
            assert equal $response.data.observed_after_failure.branch_head (head $f.repo main)
        }}
        {name: 'branch deletion failure reports partial completion without rollback', run: {||
            let f = (fixture $root ref-lock)
            let path = (made $f.repo topic/locked-ref)
            let expected = (head $f.repo topic/locked-ref)
            let lock = (g $f.repo [rev-parse --path-format=absolute --git-path refs/heads/topic/locked-ref.lock])
            'held' | save $lock
            let response = (run-cli $script $f.repo [cleanup topic/locked-ref])
            assert equal $response.exit_code 3
            assert equal $response.response.status partial
            assert equal $response.response.completed_steps [worktree_removed]
            assert (not ($path | path exists))
            assert equal (head $f.repo topic/locked-ref) $expected
            assert ($lock | path exists)
        }}
        {name: 'compare-and-delete retains commits added after inspection', run: {||
            let f = (fixture $root stale-ref)
            let path = (made $f.repo topic/stale)
            let old = (head $f.repo main)
            let tree = (g $f.repo [rev-parse 'main^{tree}'])
            let advanced = (g $f.repo [commit-tree $tree -p $old -m concurrent])
            let bin = ($f.home | path join bin)
            mkdir $bin
            let real_git = (which git | first | get path)
            let shim = ($bin | path join git)
            let shim_source = '#!/bin/sh
if [ "$4" = "update-ref" ]; then
  "$REAL_GIT" -C "$3" update-ref "$7" "$NEW_HEAD"
fi
exec "$REAL_GIT" "$@"
'
            $shim_source | save $shim
            ^chmod +x $shim
            let response = (with-env {PATH: ($env.PATH | prepend $bin), REAL_GIT: $real_git, NEW_HEAD: $advanced} {
                git-worktree cleanup $f.repo topic/stale --abandon
            })
            assert equal $response.status partial
            assert equal $response.completed_steps [worktree_removed]
            assert equal (head $f.repo topic/stale) $advanced
            assert (not ($path | path exists))
        }}
        {name: 'detached Git operations can reserve another branch', run: {||
            let f = (fixture $root reserved)
            let path = (made $f.repo topic/reserved)
            let other = ($f.home | path join rebasing)
            g $f.repo [worktree add --detach $other main] | ignore
            let marker = (g $other [rev-parse --path-format=absolute --git-path rebase-merge/head-name])
            mkdir ($marker | path dirname)
            "refs/heads/topic/reserved\n" | save $marker
            blocked-by (git-worktree cleanup $f.repo topic/reserved --abandon) branch_in_use
            assert ($path | path exists)
            assert ($marker | path exists)
        }}
        {name: 'submodule worktrees require manual cleanup', run: {||
            let f = (fixture $root submodules)
            let path = (made $f.repo topic/submodules)
            g $path [update-index --add --cacheinfo $"160000,(head $f.repo main),embedded"] | ignore
            g $path [commit -m gitlink] | ignore
            blocked-by (git-worktree cleanup $f.repo topic/submodules --abandon) submodules_present
            assert ($path | path exists)
        }}
        {name: 'cleanup can be invoked from inside its target worktree', run: {||
            let f = (fixture $root current-directory)
            let path = (made $f.repo topic/current)
            let response = (do {
                cd $path
                run-cli $script '.' [cleanup topic/current]
            })
            assert equal $response.exit_code 0
            assert (not ($path | path exists))
            missing-branch $f.repo topic/current
        }}
        {name: 'failed removal with files already deleted reports uncertainty', run: {||
            let f = (fixture $root removal-failure)
            let path = (made $f.repo topic/partial)
            let expected = (head $f.repo topic/partial)
            let bin = ($f.home | path join bin)
            mkdir $bin
            let real_git = (which git | first | get path)
            let shim = ($bin | path join git)
            let shim_source = '#!/bin/sh
if [ "$4" = "worktree" ] && [ "$5" = "remove" ]; then
  rm -- "$6/note.txt"
  echo "simulated removal failure" >&2
  exit 1
fi
exec "$REAL_GIT" "$@"
'
            $shim_source | save $shim
            ^chmod +x $shim
            let response = (with-env {PATH: ($env.PATH | prepend $bin), REAL_GIT: $real_git} {
                git-worktree cleanup $f.repo topic/partial
            })
            assert equal $response.status partial
            assert $response.data.mutation_attempted
            assert $response.data.path_exists
            assert equal $response.completed_steps []
            assert equal (head $f.repo topic/partial) $expected
            assert (not ($path | path join note.txt | path exists))
        }}
        {name: 'human output and Git errors have appropriate CLI exits', run: {||
            let f = (fixture $root cli)
            let human = (^$nu.current-exe --no-config-file $script inspect --repo $f.repo --human | complete)
            assert equal $human.exit_code 0
            assert ($human.stdout | str contains 'inspect: ok')
            let outside = ($f.home | path join not-a-repo)
            mkdir $outside
            let failed = (run-cli $script $outside [inspect])
            assert equal $failed.exit_code 1
            assert equal $failed.response.status error
        }}
    ]
}

# Run the deterministic suite. Failed fixtures are retained for diagnosis.
def main [] {
    # Stop before even creating fixtures if Git could target the caller's metadata.
    let issues = (git-worktree environment-issues)
    if not ($issues | is-empty) {
        print ({status: 'blocked', tests: 0, issues: $issues} | to json --raw)
        exit 2
    }
    let root = (mktemp --directory --tmpdir-path /tmp git-worktree-tests.XXXXXX)
    let script = ($env.CURRENT_FILE | path dirname | path join .. git-worktree.nu | path expand --strict)
    let config = ($root | path join empty-gitconfig)
    let template = ($root | path join empty-template)
    mkdir $template
    '' | save $config
    let results = (do {
        # Isolate remaining Git settings (including trace destinations and ancestry
        # overrides). Individual cases can still deliberately inject their own.
        for name in ($env | columns | where {|name| $name | str starts-with 'GIT_' }) {
            hide-env $name
        }
        with-env {
            GIT_CONFIG_NOSYSTEM: '1', GIT_CONFIG_GLOBAL: $config, GIT_TEMPLATE_DIR: $template,
            GIT_AUTHOR_NAME: 'Worktree tests', GIT_AUTHOR_EMAIL: 'tests@example.invalid',
            GIT_COMMITTER_NAME: 'Worktree tests', GIT_COMMITTER_EMAIL: 'tests@example.invalid'
        } {
            cases $root $script | each {|test|
                try { do $test.run; {name: $test.name, status: 'pass'} } catch {|err|
                    {name: $test.name, status: 'fail', message: $err.msg, detail: ($err.debug | str substring 0..<1600)}
                }
            }
        }
    })
    let failures = ($results | where status == fail)
    if ($failures | is-empty) {
        rm --recursive --force $root
        print ({status: 'pass', tests: ($results | length)} | to json --raw)
    } else {
        print ({status: 'fail', tests: ($results | length), failures: $failures, fixtures: $root} | to json --raw)
        exit 1
    }
}
