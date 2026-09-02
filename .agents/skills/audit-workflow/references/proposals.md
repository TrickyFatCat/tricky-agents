# Proposal Workflow

Use this reference for shared proposal mechanics. A proposal is an approval contract: it requests a decision about scope, behavior, trade-offs, and expected completion evidence. It does not approve itself and does not prove implementation.

## Proposal Boundary

Use a proposal when a change needs reviewable approval before implementation, especially when it creates, modifies, moves, deletes, or reorganizes durable resources.

Do not require a saved proposal for small conversational advice or trivial corrections unless the user, project, repository, or active workflow requires one.

This skill must not:

- implement a proposal;
- validate an implemented proposal;
- create unrelated records outside the proposal workflow; or
- bypass the domain, project, or repository workflow that owns the actual change.

Keep these proposal operations separate:

1. Prepare the proposal.
2. Let the user review and revise it.
3. Record approval only for exact accepted scope when the active workflow assigns that recording to the proposal artifact.
4. Hand approved scope to the responsible domain, project, or repository workflow.

Implementation, validation, commits, pushes, deployment, and final completion records belong to the responsible workflow, not to this reference.

## Lifecycle

Follow project-local lifecycle states first. When no stronger vocabulary exists, use:

- `proposed`: drafted for review, not approved.
- `approved`: exact scope accepted before implementation.
- `implemented`: owning workflow reports that approved work was completed under its validation rules.
- `rejected`: considered and not selected.
- `obsolete`: no longer applicable because context changed.
- `superseded`: replaced by another proposal or decision.

These states describe proposal artifact meaning. This skill may draft and revise proposal content; it does not implement the proposal or validate implementation evidence.

Do not infer approval from silence, discussion, or an approved Audit. Approval applies only to the named scope. Pause when implementation would need additional files, different behavior, or broader effects.

## Proposal Structure

Use [../assets/artifact-proposal-template.md](../assets/artifact-proposal-template.md) when no stronger domain or project template exists.

The template is adaptable, not rigid. Keep structure rules in this reference because agents still need to decide:

- when the template is justified;
- which optional sections to omit;
- which exact examples affect approval;
- how to preserve domain and project conventions; and
- when proposal work must hand off instead of continuing into implementation.

A substantial proposal should include these concepts when relevant:

- frontmatter with type, status, dates, and scope;
- TOC markers when the artifact is substantial and the renderer supports them;
- concise summary for the reviewer;
- action groups with approval-relevant behavior and trade-offs;
- `File Changes` after the action section;
- project evidence; and
- scope boundaries.

Omit sections that do not change the decision.

Do not duplicate information in prose when it is already clear in frontmatter, unless the prose adds interpretation, reasoning, or a decision that metadata cannot express.

### Proposal Summary

Summarize only what the reviewer needs before reading actions:

- what will change;
- why the change is needed;
- what important behavior is preserved; and
- material trade-offs, if any.

Do not restate lifecycle status, dates, task IDs, or scope labels when frontmatter already makes them clear.

### Actions

Use this action-line format:

```markdown
1. [Verb object](#verb-object) — purpose or approval effect.
```

Good action headings name work, not abstract process:

- `Create shared template assets`.
- `Update routing guidance`.
- `Create decision record`.

Keep `File Changes` out of the action list. Put file scope in its own section after the action details.

Include exact approval content where it changes the user's decision:

- Text changes show old wording before new wording.
- Naming changes include examples or the selected naming rule.
- Directory-structure changes include a compact tree or outline.
- Structured data changes, such as frontmatter, JSON, YAML, TOML, or config schemas, include a representative structure.
- Template or reusable-output changes include enough shape to review metadata, section ownership, optionality, navigation, and duplication risk.

### File Changes

`File Changes` is the complete approval boundary. Additional targets require renewed approval.

Use action labels that match the real effect:

- `Create` for new files or resources.
- `Modify` for in-place changes.
- `Move` or `Rename` for path changes.
- `Delete` for removals.

For created, moved, renamed, or reorganized artifacts, include artifact role, naming rule, and any reserved-name exception. For human-facing rename or move proposals, show old values before new values and compare the changed basename or parent directory separately.

### Project Evidence

List project artifacts that materially support the proposal, such as:

- usage reports;
- audits or reviews;
- decision records;
- existing source files;
- project documentation; and
- saved implementation or validation evidence when it already exists as a project artifact.

Use tasks only as tracking context unless task content contains the accepted decision or source material needed to reconstruct the proposal. Do not treat unsaved chat, issue labels, or task titles as source evidence by themselves.

### Scope Boundaries

State in-scope and out-of-scope work when nearby work could be confused with the proposal. Name excluded migrations, commits, pushes, report status changes, runtime state, destructive effects, implementation, and validation when relevant.

## Persistence and Naming

Follow this storage precedence for saved proposals:

1. User-provided destination.
2. Project-local rules.
3. `<project>/docs/proposals/`.
4. If no project context exists, ask the user where to save the proposal.

Assess directory and file naming before saving:

- Use the user's explicit directory when provided.
- Use local conventions such as `docs/proposals/`, `docs/proposal/`, or task-owned proposal directories when already established.
- Prefer `docs/proposals/` as the fallback for proposal artifacts when no stronger convention exists.
- Use `proposal-<concise-subject>-<yymmdd-hhmm>.md` as the fallback filename when no stronger convention exists.
- Keep filenames stable after review unless the user approves a rename.
- Do not create a new storage convention silently.

## Proposal Preflight

Before requesting review, run two checks.

### Approval-Content Coverage

Account for every exact file and action. Give each material decision one primary review location and include the content it needs:

- behavior contract;
- current and proposed wording when exact replacement text affects approval;
- exact reusable output shape when metadata, section ownership, optionality, navigation, or duplication affects approval;
- defaults, precedence, naming, migration, compatibility, or safety details;
- expected completion evidence when it affects approval; or
- a link to accepted evidence when the proposal needs only its implementation consequence.

Do not add a mandatory coverage grid to the human-facing proposal.

### Exact-Block Removal

For every exact wording, schema, template, example, or structure block, identify the approval decision it can change. Remove or summarize blocks that cannot affect scope, behavior, compatibility, safety, completion evidence, migration, authority, or wording approval.

Keep exact paths, artifact roles, naming, boundaries, migrations, and approval-relevant completion expectations.

## Approval and Handoff

When a saved proposal is required:

1. Save it with `status: proposed`.
2. Revise it during review without treating comments as approval.
3. Change it to `status: approved` only after exact acceptance and only when the active workflow assigns approval recording to the proposal artifact.
4. Hand the approved scope to the responsible workflow.

Do not create a proposal retrospectively to justify changes already made.

## Final Checks

Before presenting or saving a proposal:

- confirm the proposal requests a decision rather than reporting implementation;
- confirm lifecycle state is accurate for the proposal artifact;
- confirm file changes are complete and exact;
- confirm project-local approval and storage rules are preserved;
- confirm project evidence links resolve when local;
- confirm exact blocks are approval-relevant;
- confirm implementation and validation are handed off to the owning workflow; and
- state runtime or integration checks that were not performed when they affect the proposal decision.
