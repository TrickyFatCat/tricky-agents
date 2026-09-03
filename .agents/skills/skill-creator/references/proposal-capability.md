# Proposal Capability Design

Read this reference when deciding whether a target skill should own domain-specific proposal behavior during normal use.

Use [`audit-workflow/references/proposals.md`](../../audit-workflow/references/proposals.md) for generic proposal structure, lifecycle, exact-scope contracts, persistence, and template mechanics. This reference covers only target-skill domain responsibility and additions.

Do not read it merely because the current skill change needs a proposal.

## Capability Test

Add domain proposal capability only when all applicable conditions are met:

- proposing domain changes belongs to the target skill's primary or clear supporting responsibility;
- the behavior recurs across real tasks;
- the domain skill holds evidence, constraints, trade-offs, or validation context a shared-only handoff would lose;
- the skill can keep advice, proposal, approval, and implementation separate; and
- the capability remains inactive during requests that need only advice, assessment, or implementation.

Do not add capability merely because Skill Creator proposed changes to the skill, the skill makes recommendations, one task needed approval, or a generic template could be copied.

## Responsibility Boundary

The target skill may own:

- domain triggers for a durable proposal;
- domain evidence, decision criteria, constraints, and trade-offs;
- the selected domain approach and meaningful rejected alternatives;
- domain-specific actions, systems, or artifacts affected;
- domain validation and rollback expectations; and
- context handed to the responsible implementation workflow.

Delegate to `audit-workflow`:

- proposal-versus-implementation boundaries;
- generic lifecycle and approval semantics;
- exact file or system scope mechanics;
- shared section ownership and proposal structure;
- persistence and naming fallbacks; and
- the base proposal template and generic preflight.

Keep repository operations, deployment, publication, destructive effects, and implementation with their responsible workflows.

## Domain Contract

Define only what shared proposal mechanics cannot supply:

1. Requests that justify a durable domain proposal.
2. Evidence and criteria used to choose the approach.
3. Domain actions and exact affected systems or artifact types.
4. Trade-offs, compatibility, migration, safety, or rollback specific to the domain.
5. Domain validation and completion evidence.
6. Context the implementation owner needs.
7. Adjacent-skill handoffs and stopping conditions.

Do not repeat generic proposal lifecycle or approval mechanics in the target skill.

## Project Authority

Follow project-local storage, naming, metadata, lifecycle, approval, and validation rules before shared defaults.

A proposal requests a decision. It cannot approve itself, broaden its own scope, or prove implementation. Record approval only through the active project or repository workflow.

## Template Ownership

Use `audit-workflow/assets/artifact-proposal-template.md` directly by default. Express domain additions in the target skill's reference.

Propose a target-owned template only when recurring evidence shows the shared template plus domain guidance is insufficient and a distinct reusable structure is fragile enough to justify duplicate maintenance.

Do not copy historical Skill Creator proposal templates into target skills.

## Per-Skill Proposal Requirements

When proposing domain proposal capability, include:

1. Exact runtime trigger and domain responsibility.
2. Why the target skill must remain active alongside `audit-workflow`.
3. Domain evidence, criteria, constraints, and trade-offs.
4. Domain additions to shared proposal actions and scope.
5. Advice, assessment, proposal, approval, and implementation boundaries.
6. Storage, linking, and project-local authority.
7. Template justification, if any.
8. Adjacent-skill and implementation handoffs.
9. Domain validation, rollback, and untested runtime behavior.

Use old-before-new wording when exact instructions affect approval. Include exact paths, artifact roles, naming rules, and reserved-name exceptions for created or reorganized resources.

## Validation

Confirm:

- recurring domain proposals genuinely belong to the target skill;
- domain context would be materially weaker with only the shared workflow;
- unrelated requests do not activate proposal behavior;
- shared mechanics are referenced rather than copied;
- advice, Review, proposal, approval, and implementation remain distinct;
- project-local conventions remain authoritative;
- any target-owned template has recurring evidence and a distinct contract;
- relative links resolve and only approved files changed; and
- runtime routing or trial behavior is reported as untested when not exercised.
