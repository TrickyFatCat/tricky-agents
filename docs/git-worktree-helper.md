# Git worktree helper

A user-invoked Nushell CLI for inspecting, creating, and cleaning up local Git worktrees. It automates mechanical checks and operations, not approval or semantic conflict resolution. Repository instructions and [the controlled workflow](controlled-workflow.md) still govern when an operation is authorized.

## Requirements and layout

Tested on Linux with Nushell **0.115.1** and Git **2.55.0**. Other versions and platforms have not been validated. No Nushell plugins or third-party test framework are required.

- `scripts/git-worktree.nu` — CLI and output rendering.
- `scripts/lib/git-worktree.nu` — record-returning operations and parsers.
- `scripts/tests/git-worktree.nu` — deterministic parser and integration tests.

The CLI supports non-bare repositories with a primary checkout. Creation uses the local `main` commit. The primary checkout is identified through Git's worktree registration, not by assuming the invocation directory is primary.

## Commands

Run from this checkout, or provide the script's absolute path:

```sh
nu --no-config-file scripts/git-worktree.nu inspect
nu --no-config-file scripts/git-worktree.nu inspect chore/example --repo /path/to/repository
nu --no-config-file scripts/git-worktree.nu create chore/example --repo /path/to/repository
nu --no-config-file scripts/git-worktree.nu cleanup chore/example --repo /path/to/repository
```

All commands default `--repo` to the current directory. Add `--human` for a readable summary instead of compact JSON. `--help` shows Nushell's normal usage information.

### Inspection

With no branch argument, `inspect` selects the current branch, or the current detached worktree. With a branch argument, it selects that exact local branch.

The result includes its commit, registered worktrees, changes, whether it is merged into local `main`, and upstream divergence when an upstream is configured and its tracking ref is available. A branch without a worktree can still be inspected. Before collecting file changes, inspection verifies that an existing registered path still identifies the expected repository and worktree; stale paths occupied by another repository are refused.

Upstream information is **locally cached**. The helper issues no fetch commands and disables Git's automatic fetching of missing objects, including in partial clones. Missing required objects cause a failure result rather than a lazy fetch. Callers remain responsible for refreshing and checking the stable base when their workflow requires it. `status: "ok"` means inspection succeeded, not that cleanup is permitted or approved.

Change counts include all reported entries. The `paths` sample is limited to 20 entries; `truncated: true` explicitly indicates omitted paths. Tracked changes, untracked files, and ignored files are counted separately. Renames are inspected as additions/deletions to keep each NUL-delimited status record unambiguous.

### Creation

`create` creates a new local branch and worktree from the inspected local `main` commit, leaving the primary checkout's files and branch unchanged.

The path follows this repository's sibling layout:

```text
/path/to/repository
/path/to/agents-worktrees/chore-example
```

Slashes in the branch name become hyphens. Existing branch refs (including dangling symbolic refs), registered paths, existing filesystem entries (including dangling symlinks), and redirected worktree containers are refused. A raw-ref lookup error also prevents creation. The helper does not silently reuse existing work or invent another name; inspect the existing target instead.

Native Git checkout hooks may execute. Hooks are not sandboxed and can have their own side effects, including network operations. If checkout or a hook fails, the result reports any observed remaining branch/path rather than attempting rollback.

### Cleanup and abandonment

Normal `cleanup` removes a clean linked worktree and deletes its local branch only when its commit is an ancestor of local `main`.

Ancestry and divergence checks use **underlying commit history**, ignoring replacement refs. Legacy `info/grafts` files are refused, as are inherited `GIT_GRAFT_FILE` and `GIT_SHALLOW_FILE` overrides. Results can therefore differ from ordinary Git commands configured to use a replacement-adjusted graph.

Explicit abandonment permits discarding unmerged commits:

```sh
nu --no-config-file scripts/git-worktree.nu cleanup chore/example --abandon --repo /path/to/repository
```

`--abandon` does **not** permit discarding tracked changes, untracked files, or ignored files. Those must be preserved or explicitly handled separately. The helper never automatically stashes, commits, or discards them.

Cleanup also refuses protected targets (`main` and the primary checkout), ambiguous registrations, symbolic branch refs, symlinked targets, locks, unavailable worktrees, mismatched repository identities, and branches reserved by another worktree or Git operation. Worktrees containing submodules, hidden index flags (`assume-unchanged` or `skip-worktree`), or an in-progress Git operation require manual attention.

State is rechecked before removal. Local branch deletion uses an expected commit ID, so a detected branch advance is retained rather than silently discarded. Local configuration for the deleted branch is removed; remote branches are untouched.

Removal and ref/config updates are not one atomic transaction. **Do not concurrently modify the involved worktrees or branches.** Rechecks detect some races but cannot make filesystem deletion atomic with arbitrary external writers. On partial failure, inspect the reported remaining state before deciding how to recover; no destructive rollback is attempted.

Prefer invoking cleanup from a retained directory. The CLI can emit its result when invoked inside the removed worktree, but it cannot repair the parent shell's working directory afterward. Internal module operations should be called from a retained directory.

## Result and exit contract

Operation outcomes emit one compact JSON record on stdout, without raw Git output mixed into the stream:

- `operation`: `inspect`, `create`, or `cleanup`.
- `status`: `ok`, `blocked`, `error`, or `partial`.
- `target`: repository, local branch, and worktree path when known.
- `data`: operation-specific state, including observed state after failures when available.
- `issues`: records containing stable `code` values and explanatory `message` strings.
- `completed_steps`: confirmed completed steps; this is not an approval record.

| Status | Exit | Meaning |
| --- | --- | --- |
| `ok` | 0 | The requested inspection or operation completed. |
| `error` | 1 | The operation failed; consult the reported issue and state. |
| `blocked` | 2 | A precondition failed before the requested mutation. |
| `partial` | 3 | Steps completed, state remains after a failed creation, or a removal failure may have already changed files. |

For example, `local_changes` means cleanup was refused before deletion; `unmerged_branch` requires an explicit abandonment decision; `state_changed` requires fresh inspection. A `branch_delete_failed` result can have `worktree_removed` in `completed_steps` while the local branch remains intact. A failed removal with an existing directory is still reported as `partial`, because some files may already have been removed.

Invocation/parse errors and `--help` use Nushell's normal diagnostics rather than the operation-result schema. Repository-routing Git environment variables are rejected instead of allowing them to redirect `--repo` to another repository or index.

## Development checks

Run the suite from any directory using an absolute script path, or from this worktree:

```sh
nu --no-config-file scripts/tests/git-worktree.nu
```

The suite uses Nushell's standard assertions, disposable repositories, local bare remotes, and controlled failure injection. Before creating fixtures or invoking Git, it rejects inherited repository-routing/config-injection variables with exit 2 and a `blocked` result reporting zero tests. Remaining inherited Git variables are cleared before isolated fixture configuration, templates, and author identities are applied; individual cases can still deliberately inject test variables. This prevents fixture commands from modifying the caller's repository or index. Successful fixtures are removed; failed fixtures are retained under `/tmp/git-worktree-tests.*`, with their location included in the failure result.

Explicit syntax checks are also available:

```sh
nu --no-config-file -c 'nu-check --debug scripts/git-worktree.nu'
nu --no-config-file -c 'nu-check --debug --as-module scripts/lib/git-worktree.nu'
```

Tests cover parser fidelity, creation, path and ref-name collisions, protected targets, normal cleanup, explicit abandonment, preservation of local files and remote branches, cached upstream state, partial-clone lazy-fetch prevention, underlying-history ancestry, test-runner environment isolation, Git-operation reservations, submodules, hidden index flags, hooks, current-directory removal, and partial/racing failures.
