# Proposal Capability Design

Read this reference when designing or reviewing a target skill that may propose domain changes during normal use.

Do not read this reference merely because the current skill change needs Skill Creator's own exact-file proposal. Use [../assets/skill-change-proposal-template.md](../assets/skill-change-proposal-template.md) for proposals that change skills.

## Capability Test

Add Proposal capability to a target skill only when all applicable conditions are met:

- Proposing domain changes belongs to the skill's primary responsibility or a clear supporting responsibility.
- The behavior recurs across real tasks.
- The skill holds context that a handoff would lose.
- The skill can define exact scope, approval, lifecycle, and validation without weakening project rules.
- The capability remains inactive during requests that need only advice, review, or implementation.

Do not add the capability merely because:

- Skill Creator proposed changes to the skill;
- the skill makes recommendations;
- one task needed approval;
- another workflow already owns planning or change control;
- a generic proposal template could be copied into the skill.

## Responsibility Boundary

Define which operations the target skill owns:

- decide when a durable proposal is justified;
- explain the recommended domain change and trade-off;
- identify exact affected artifacts or systems;
- distinguish the selected approach from rejected alternatives;
- record approval and lifecycle state when the project requires it;
- hand approved scope to the responsible implementation workflow;
- validate proposal traceability and state relationships.

Do not assign implementation, repository operations, deployment, publication, or destructive effects automatically. Keep those actions with their responsible workflows and approval gates.

## Proposal versus Implementation

A proposal requests a decision. It does not grant its own approval and does not prove implementation.

Keep these phases distinct when the workflow tracks them:

1. Prepare the proposal.
2. Let the user review and revise it.
3. Record exact approval.
4. Implement in a separate phase.
5. Validate before recording completion.

Do not create a proposal retrospectively to justify changes already made.

## Proposal Content Contract

A substantial proposal should provide:

- compact orientation and current lifecycle state;
- concise overview of the change and preserved behavior;
- reasoning and selected approach;
- lightweight rejected alternatives when they affect the decision;
- linked action groups;
- exact approval boundary;
- source material;
- scope boundaries;
- validation plan;
- decision-record outcome when the domain uses one;
- explicit approval request or approval record.

Use short human-facing sections. Keep exact wording, examples, paths, migrations, and technical detail under the relevant action.

Small proposals may omit or merge sections when the decision and approval boundary remain unambiguous.

## Approval and Lifecycle

Follow the active project lifecycle first.

When a tracked workflow needs fallback states, use:

- `proposed`: under review;
- `approved`: exact scope accepted before implementation;
- `implemented`: approved work completed and validated.

Do not infer approval from silence, an approved Audit, or a request to discuss the proposal. Approval applies only to the named scope. Pause when implementation needs additional targets or materially different behavior.

## Project Storage

Follow project-local storage, naming, metadata, linking, and validation rules.

Do not require a saved proposal for unrelated trivial work unless the user, repository, or active project requires one. Do not impose one task-vault, repository, or filename convention globally.

When saved proposals are required, link them from the owning workflow and preserve review chronology.

## Template Ownership

Keep concrete proposal templates with the skill that repeatedly produces domain proposals.

Create a target-skill template only when recurring or fragile output justifies one. Use a semantic filename, mark sections as conditional, support project-local overrides, and avoid empty scaffolding.

Do not reuse `skill-creator/assets/skill-change-proposal-template.md` as a universal target-skill output asset. It is reserved for proposals that change skills.

A skill that only advises or hands proposals to another workflow usually does not need a template.

## Per-Skill Proposal Requirements

When proposing Proposal capability for a target skill, include:

1. Exact runtime trigger and responsibility.
2. Why the capability belongs in this skill instead of a handoff.
3. Proposal versus implementation boundary.
4. Required proposal concepts and exact-scope behavior.
5. Approval and lifecycle rules.
6. Storage, linking, and project-local authority.
7. Template need and ownership.
8. Adjacent-skill handoffs.
9. Validation and untested runtime behavior.

Use old-before-new wording blocks for modified instructions. Include exact paths, artifact roles, naming rules, and reserved-name exceptions for new or reorganized files.

## Validation

Confirm that:

- recurring domain proposals genuinely belong to the target skill;
- advice, Review, Proposal, approval, and implementation remain distinct;
- proposals cannot approve themselves or broaden implementation scope;
- unrelated requests do not load or apply the capability;
- project-local storage and approval rules remain authoritative;
- lifecycle states, exact boundaries, and links are internally consistent;
- any template is justified, semantically named, and owned by the target skill;
- relative links resolve and the change includes only approved files;
- runtime routing or trial behavior is reported as untested when not exercised.
