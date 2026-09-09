# Repository Agent Instructions

## Scope

This repository contains shared agent and chat configuration, supporting skills, documentation, and repository tooling.

This `AGENTS.md` governs development and maintenance of the whole repository.

Repository layout:

- `agents/global/` — protected global agent configuration.
- `agents/skills/` — shared agent skills and supporting files.
- `chats/` — ChatGPT chat and project configuration.
- `docs/` — user-facing repository documentation.
- `scripts/` — user-invoked setup, deployment, and maintenance tooling.

Keep repository-development tooling separate from the configuration artifacts it supports.

Do not introduce new top-level responsibilities or source-of-truth conventions without user approval.

## Change Discipline

Prefer small, reviewable, and reversible changes.

Preserve established structure, terminology, responsibilities, and decisions unless the requested work requires changing them.

A change is **meaningful** when it can reasonably affect behavior, scope, applicability, responsibilities, decision boundaries, precedence, safety, dependencies, outputs, compatibility, or interpretation.

Proceed directly with clearly requested low-risk non-behavioral changes.

Do not hide meaningful changes inside cleanup, editorial work, refactoring, consistency fixes, or maintenance.

When reasonable interpretations of a request would produce materially different results, ask the user to decide.

Do not assume a repeated ambiguous request has the same intended meaning as a similar earlier request.

## Controlled Configuration

Controlled configuration includes:

- **repository governance** — the root `AGENTS.md` and repository-scoped nested `AGENTS.md` files;
- **skills** — skill artifacts under `agents/skills/`, excluding repository-scoped `AGENTS.md` files;
- **chat configuration** — configuration under `chats/`, excluding repository-scoped `AGENTS.md` files.

`agents/global/AGENTS.md` is separately protected under **Protected Global Configuration** and is not part of the normal controlled-change workflow.

Meaningful changes to controlled configuration must follow `docs/controlled-workflow.md`.

Do not implement or integrate a meaningful controlled change merely because the user requested a review, recommendation, improvement, cleanup, or refactor.

Consequential design decisions must be surfaced to the user rather than silently resolved.

## Protected Global Configuration

`agents/global/AGENTS.md` is protected.

Do not modify it under any circumstances.

If a change appears necessary, explain the issue and propose the change to the user instead.

## Repository `AGENTS.md` Development

Do not modify a repository-governance `AGENTS.md` while its changes are still being designed or reviewed.

Develop meaningful repository-governance changes as an exact non-governing proposal first.

After the user approves the complete proposal, apply and integrate it through the repository-governance workflow in `docs/controlled-workflow.md`.

Until integration into `main` is complete, treat the changed worktree copy as authored content for validation rather than authoritative repository governance.

Continue following the approved repository governance from the primary `main` checkout.

The changed instructions become authoritative only after integration into `main`.

## Stable Environment

Treat `main` and the primary repository checkout as the stable, approved environment.

Keep the primary checkout on `main`.

Develop meaningful controlled changes on dedicated branches in separate Git worktrees as defined in `docs/controlled-workflow.md`.

Do not expose development worktrees as the stable deployment source.

Other clearly requested repository work may occur directly on `main`.

Consequential non-controlled work still requires the user's decision before implementation, but does not require an isolated worktree unless the user requests one or the work forms part of an active controlled change.

## Approval

Approval of controlled work is all-or-nothing for the complete concrete state presented to the user.

A review, partial diff, design direction, or unresolved proposal is not integration approval.

An exact complete proposal requires only one approval when the resulting implementation matches it exactly and introduces no other meaningful change.

After approval, normal commit, integration, push, and cleanup steps may proceed automatically as defined in `docs/controlled-workflow.md`.

If the resulting state changes meaningfully after approval, obtain approval for the complete changed state before integration.

## Validation

Validate meaningful controlled changes before requesting final approval.

Check structural validity and references, cross-file consistency and dependencies, behavioral interactions, and source-of-truth drift as applicable.

Use available automated checks when relevant, but do not treat them as proof of semantic correctness.

Do not present work as ready for integration while consequential conflicts or uncertainties remain unresolved.

## Git Safety

Do not automatically force-push, rewrite published history, discard unrelated work, or perform other destructive Git operations.

Textual and semantic conflicts require investigation. Do not resolve consequential conflicts silently.

Preserve unrelated uncommitted work.

## Git Worktree Helper

When managing this repository's worktrees, use
`scripts/git-worktree.nu` from the primary `main` checkout for
supported inspection, creation, and cleanup operations. Follow
the operational procedure in `docs/controlled-workflow.md`.

If the helper is unavailable or refuses an operation, stop the
affected operation and report the reason. Do not bypass that
boundary with native Git.

Helper results do not replace existing authorization, approval,
or preservation requirements.

## Commit Messages

Use Conventional Commits:

```text
<type>(<scope>): <description>
```

Allowed types:

- `feat`
- `fix`
- `refactor`
- `docs`
- `test`
- `chore`

Use the affected artifact or subsystem as the scope when useful. The scope may be omitted for genuinely repository-wide changes.

Keep commits coherent and use concise imperative descriptions.

Commit type does not affect approval requirements.

## Source of Truth

Prefer one authoritative location for each meaningful behavioral rule.

Do not duplicate normative behavior merely to make every artifact self-contained.

Deliberate duplication is acceptable when needed for discoverability, reliability, or independent use, but duplicated rules must remain consistent.

Keep policy, decision boundaries, and behavioral authority in governing `AGENTS.md` files or skills.

Operational procedures may live in `docs/` when a governing instruction explicitly requires them, as with `docs/controlled-workflow.md`.

Use other documentation for explanation, rationale, setup, and maintenance guidance rather than as an independent source of behavioral policy.

## Setup and Deployment

Setup and deployment tooling is user-invoked.

Do not run setup or deployment tooling automatically unless the user explicitly requests it.
