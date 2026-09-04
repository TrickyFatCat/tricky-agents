# Maintenance Proposals

Use this reference for durable proposals that change global agent resources or agents-repository behavior, and for read-only proposals concerning project-specific `AGENTS.md` files.

## Shared Workflow

Read [`audit-workflow/references/proposals.md`](../../audit-workflow/references/proposals.md) for generic proposal structure, lifecycle, persistence, exact-scope mechanics, and preflight. Use its [artifact proposal template](../../audit-workflow/assets/artifact-proposal-template.md) when no stronger project convention exists.

Agents Maintainer supplies the repository evidence, authority boundaries, exact effects, compatibility, rollback, validation, and implementation handoff below. The core Agents Maintainer Approval Gate remains authoritative.

## When a Saved Proposal Is Required

Use a saved proposal when:

- the user or project requires one;
- the user requests proposed changes to project-specific `AGENTS.md` files;
- a reviewed Audit records `proposal required`;
- the change is a substantive multi-file migration or reorganization;
- files or directories will be moved, renamed, deleted, or replaced;
- safety, compatibility, routing, or repository effects need durable review; or
- the implementation owner must resume from an exact approval contract.

Use a concise conversational exact-file proposal for proportional changes when no saved artifact is required. Do not create a proposal retrospectively or add durable ceremony to a trivial approved correction.

## Repository Approval Content

Include the content that can change approval:

- the owning repository and exact repository-relative create, modify, move, rename, or delete paths;
- the target project and exact `AGENTS.md` paths for read-only project-specific proposals;
- user-facing paths when symlinks or runtime exposure make them useful;
- each created or reorganized artifact's role, semantic naming rule, and reserved-name exception;
- old wording before new wording when exact text affects the decision;
- old basename before new basename for renames and old parent before new parent for moves;
- relevant repository evidence, active instructions, decisions, Audits, reports, tasks, and dependencies;
- symlink, executable, third-party, network, credential, permission, persistence, runtime, portability, and compatibility effects;
- migration, fallback, rollback, or recovery behavior when failure would leave durable or ambiguous state;
- expected formatting, link, schema, runtime, test, diff, and repository-state evidence; and
- separate effects for task state, report state, decisions, commits, pushes, deployment, or publication when any are in scope.

Cite usage reports as evidence by default. Include a report lifecycle change only when it is an explicit approved outcome and completed work can establish the requested terminal state.

Keep exact blocks only when they can affect scope, behavior, compatibility, safety, completion evidence, migration, authority, or wording approval.

## Authority and Lifecycle

Keep the proposal at `proposed` during review. Record `approved` only after the user explicitly accepts the exact scope; preferences, partial choices, comments, and silence do not approve implementation.

Before editing global resources:

1. Confirm the approved proposal exists and still matches the intended effects.
2. Confirm the proposal is linked from its owning task when the active workflow requires that traceability.
3. Confirm every implementation target is inside the approved repository boundary.
4. Confirm unrelated repository changes will remain untouched.
5. Stop for renewed approval when a target, effect, safety property, or compatibility behavior changes materially.

A proposal cannot approve itself. Keep decision or approval-request prose out of the saved artifact when type, status, actions, and surrounding interaction already make its purpose clear; obtain the required direct confirmation in conversation.

Agents Maintainer must not implement, stage, commit, or push proposed changes to project-specific `AGENTS.md` files outside the agents repository. Name the project-local implementation owner or workflow and stop after the proposal handoff.

Return implementation, validation, task and report transitions, commits, pushes, deployment, and publication to their owning workflows. Record `implemented` only after the owning workflow reports that approved work and validation completed.
