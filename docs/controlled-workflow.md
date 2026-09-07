# Controlled Configuration Workflow

This workflow governs meaningful changes to controlled configuration defined by the root `AGENTS.md`.

Repository `AGENTS.md` files own behavioral policy, approval requirements, protected-artifact rules, and decision boundaries.

This document defines the operational branch, worktree, synchronization, integration, and cleanup workflow for applying those policies.

If this workflow appears to conflict with applicable repository `AGENTS.md` instructions, follow the `AGENTS.md` instructions and surface the inconsistency.

## Branch Model

Use dedicated work branches for meaningful controlled changes.

### Branch Naming

```text
skill/new/<name>
skill/update/<name>/<topic>
skill/refactor/<name>/<topic>

chat/new/<name>
chat/update/<name>/<topic>
chat/refactor/<name>/<topic>

repo/update/<topic>
repo/refactor/<topic>
```

Use:

- `new` for a new skill or chat configuration;
- `update` for bounded changes that preserve the artifact's overall design and responsibilities;
- `refactor` for substantial redesign of structure, responsibilities, workflow, behavior, or interactions.

Repository governance uses `update` and `refactor`; do not use `repo/new/`.

Classify work by intent and scope, not diff size.

A branch may cover several related controlled artifacts when they form one coherent unit of work.

## Stable Checkout and Worktrees

Keep the primary repository checkout on `main`.

Treat it as the stable deployment source.

Develop controlled configuration in separate Git worktrees so unapproved changes cannot affect the stable environment.

Keep development worktrees outside the primary checkout in a dedicated sibling directory.

Derive the worktree name from its branch by replacing `/` with `-`.

Example:

```text
skill/update/agent-authoring-coach/context-reread
→ ../agents-worktrees/skill-update-agent-authoring-coach-context-reread
```

Use one worktree per active work branch.

Do not point stable-environment symlinks at development worktrees.

## Branch State and Selection

An **active work branch** is an unmerged branch that still represents ongoing or unresolved work.

Determine branch state from repository history and current changes, not from branch name or existence alone.

Determine branch state against the current stable repository state, not a knowingly stale local view.

Reuse an existing branch or worktree only when its purpose and current changes clearly correspond to the work being resumed.

When resuming established work:

- use its existing worktree automatically when one clearly represents the work;
- if an appropriate active branch exists without a worktree, create one for it;
- do not create a replacement merely because the current shell or repository context points elsewhere.

When starting new controlled work:

1. classify it using the branch types available for that artifact;
2. reuse an appropriate existing active worktree when one clearly represents the work;
3. otherwise create the appropriate branch and worktree from the required base.

Do not automatically select or create a worktree when:

- the user explicitly requests another workspace or base;
- more than one active worktree could reasonably represent the work;
- doing so would interfere with unresolved or uncommitted work.

Do not infer that an ambiguous request belongs to earlier work merely because it concerns the same artifact.

## Base Selection

New independent work must start from the current stable `main`.

Do not base independent work on another development branch merely because its worktree is currently active.

When one active branch intentionally depends on another, establish the dependency and merge order with the user before integrating the branches.

## Active Development

A work branch represents the unit of development; its worktree is the workspace where that development occurs.

Within the appropriate worktree:

- the user and agent may iterate without approving every individual edit;
- consequential design decisions must still be surfaced to the user;
- related references, templates, documentation, tests, and supporting files may be changed when required by the same work.

Neither the branch nor its worktree authorizes unrelated changes or expands the agreed scope automatically.

## Branch Scope Changes

Keep branch type aligned with the actual scope of work.

If an active branch materially changes category:

1. stop before expanding the work further;
2. explain how and why the scope changed;
3. obtain the user's decision on the new scope;
4. if approved, rename or replace the branch and worktree as needed while preserving existing work safely.

Correcting a branch name does not itself approve the expanded work.

Minor discoveries that remain within the original category do not require reclassification.

## Cross-Branch Dependencies

A branch may modify more than one controlled artifact when the changes belong to the same coherent unit of work.

Before modifying another controlled artifact, check for relevant unmerged work on another branch.

If none exists, include the dependent change on the current branch when it belongs to the same unit of work.

If relevant active work exists elsewhere, do not silently modify the same artifact independently.

Determine whether the required change:

- belongs to the existing branch;
- belongs to the current work;
- or should be handled as a separate prerequisite.

Ask the user when that choice affects scope, behavior, ownership, or merge order.

When a dependency should enter stable configuration independently:

1. develop it on its appropriate branch and worktree;
2. validate and obtain approval;
3. integrate it into `main`;
4. synchronize the dependent branch with the new stable state;
5. continue development in its worktree.

Keep dependent active branches in separate worktrees unless integration is required.

Do not duplicate the same meaningful change across active branches merely to unblock them.

Do not merge, rebase, cherry-pick, or otherwise integrate another active branch merely because it contains related work. Establish the dependency and merge order first.

## Updating Active Work

Before continuing substantial work in an older worktree, check whether `main` has advanced in ways relevant to its branch.

Routine synchronization may be performed inside the development worktree when it does not change intended behavior, scope, or approved work.

Treat both textual Git conflicts and semantic conflicts as conflicts requiring investigation.

When synchronization produces or reveals a conflict:

- do not resolve it automatically;
- investigate the conflicting changes and their intent;
- determine whether the conflict is textual, structural, behavioral, or caused by overlapping work;
- explain relevant consequences and options;
- obtain the user's decision when resolution affects a meaningful design choice.

A clean Git merge does not guarantee semantic compatibility.

Do not prefer behavior merely because it is newer or merges mechanically.

After the user resolves a consequential conflict, apply that decision without requesting redundant approval for the same resolution.

Do not discard, overwrite, or reset conflicting work without explicit authorization.

Do not switch the primary stable checkout away from `main` to synchronize development work.

## Uncommitted Work

Do not discard, stash, commit, move, or overwrite unrelated uncommitted changes merely to make worktree management or integration convenient.

Before operating on a worktree with uncommitted changes:

- determine whether they belong to that worktree's intended work;
- preserve changes belonging to another task without mixing them into the worktree;
- investigate and ask the user when ownership is unclear.

Do not create incidental commits solely to enable worktree management or integration unless they represent an established unit of work.

## Stable Checkout State

Before integration, inspect the primary checkout for uncommitted or unresolved work.

Do not overwrite, absorb, commit, stash, or otherwise manipulate unrelated stable-checkout changes merely to complete integration.

If unrelated changes can safely remain in place, preserve them.

If they overlap with controlled work or prevent safe integration, investigate and ask the user to decide.

Do not include unrelated stable-checkout changes in controlled-work approval or integration commits.

Preserve pre-existing unrelated stable-checkout work after integration.

## Repository `AGENTS.md` Workflow

Meaningful changes to repository-governance `AGENTS.md` files use a special workflow because those files govern repository behavior within their scopes.

Do not design those changes by editing the governing file directly.

Instead:

1. develop the complete exact change in chat or another non-governing draft surface;
2. obtain user approval for that complete proposal;
3. create the appropriate `repo/update/<topic>` or `repo/refactor/<topic>` branch and worktree;
4. apply the approved proposal exactly to the target repository-governance `AGENTS.md`;
5. validate that the applied state matches the proposal;
6. integrate it through the normal workflow.

Until integration into `main` completes, treat the changed worktree copy as authored content for validation rather than authoritative repository governance.

Continue following the approved applicable repository governance from the primary `main` checkout.

The changed governance becomes authoritative only after integration into `main`.

Apply the approval rule defined by the governing repository `AGENTS.md`; no additional approval is required when the applied state matches the approved exact proposal and introduces no other meaningful changes.

## Integration

After the complete controlled state has been approved:

1. commit the approved changes in the development worktree;
2. perform safe synchronization there when required;
3. verify that the branch still matches the approved state;
4. check whether `main` changed since approval;
5. investigate textual or semantic conflicts;
6. perform applicable validation;
7. confirm the primary stable checkout is on the current `main`;
8. integrate the approved branch into `main` from the primary checkout;
9. push the resulting `main` state to the configured remote;
10. clean up the completed work.

Do not require separate confirmation for these steps when they do not alter the approved state.

If synchronization or integration meaningfully changes files, behavior, scope, dependencies, or interpretation, stop and obtain approval for the complete changed state.

Do not expose a development worktree as the stable deployment source during integration.

## Merged Work

Treat successfully integrated work as completed and dead.

After successful integration:

- remove the development worktree when no needed work remains;
- delete the merged local branch;
- delete the corresponding remote branch when one exists;
- do not reuse or archive the branch.

Later work starts from the current `main` on a new appropriately named branch and worktree.

Before cleanup, verify that it will not discard uncommitted or otherwise needed work.

## Abandoned Work

When the user explicitly abandons unmerged work, treat it as closed and disposable.

After confirming that no needed work must be preserved:

- remove its worktree;
- delete the local branch;
- delete the corresponding remote branch when present;
- do not reuse or archive the branch.

Do not infer abandonment merely because work is inactive or stale.

Before cleanup, check for uncommitted or unique committed work that may still need preservation.

If cleanup could lose work whose disposition is unclear, ask the user before proceeding.

Do not require another confirmation when the abandonment decision already clearly includes discarding that work.
