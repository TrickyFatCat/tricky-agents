# Audit and Review Capability Design

Read this reference when deciding whether a target skill should own domain-specific Audit or Review behavior during normal use.

Use `audit-workflow` for generic Review, Quick Review, formal Audit, finding, lifecycle, persistence, section-ownership, and template mechanics. This reference covers only target-skill domain responsibility and the additions it must supply.

Do not read it merely because Skill Creator is assessing the target skill.

## Capability Test

Add domain Audit or Review capability only when all applicable conditions are met:

- recurring domain assessment belongs to the target skill's primary or clear supporting responsibility;
- the domain has evidence, criteria, risks, priorities, or judgments generic critique would miss;
- a handoff without the domain skill would lose material context or actionability;
- the skill can keep assessment separate from proposal and implementation; and
- the capability remains inactive during unrelated requests.

Do not add capability merely because Skill Creator audited the skill, the skill validates its own output, one task needed a report, or a template could be copied.

## Responsibility Boundary

The target skill may own:

- domain triggers for conversational Review or formal Audit;
- domain scope and exclusions;
- evidence standards and source hierarchy;
- assessment criteria, risk model, priorities, and terminology;
- domain findings, strengths, judgment, and recommendations;
- domain escalation conditions; and
- approved persistence additions required by project-local rules.

Delegate to `audit-workflow`:

- generic Review, Quick Review, and Audit structures;
- finding layout and navigation;
- metadata, TOC, lifecycle, persistence, and section ownership;
- generic Review-versus-Audit mechanics; and
- base Audit and proposal templates.

Keep research, task management, repository approval, implementation, commits, and unrelated review domains with their responsible workflows.

## Domain Contract

Define only what shared mechanics cannot supply:

1. Requests that activate domain Review or Audit.
2. Evidence the domain requires and how sources are weighed.
3. Criteria and risks generic assessment would miss.
4. Priority or status meanings when shared labels need domain interpretation.
5. Domain sections or fields that must be added to the shared template.
6. Escalation and stopping conditions.
7. Behavior worth preserving.
8. Adjacent-skill handoffs.
9. Validation specific to the assessed artifact.

Do not repeat the shared template or generic lifecycle in the target skill.

## Quick Review

Use the shared Review workflow for proportional conversational output. Add target-specific terminology, criteria, evidence, and impact only when they improve the domain judgment.

Do not create a universal or target-owned Quick Review template by default. A short reference addition is usually sufficient.

## Persistence and Project Authority

Follow active project storage, naming, metadata, lifecycle, approval, and validation rules before shared defaults.

Saving, source annotation, proposal creation, approval, and implementation remain separate effects. A domain Audit may recommend a proposal but cannot authorize it.

## Template Ownership

Use `audit-workflow/assets/artifact-audit-template.md` directly by default. Express domain additions in the target skill's reference.

Propose a target-owned template only when recurring evidence shows that:

- the shared template plus domain guidance is insufficient;
- a distinct output shape is fragile or repeatedly misapplied;
- the template remains adaptable and project-overridable; and
- maintaining another template provides more value than the duplication cost.

Do not copy Skill Creator's historical Audit templates or create a generic Quick Review asset.

## Per-Skill Proposal Requirements

When proposing domain Audit or Review capability, include:

1. Exact runtime triggers and responsibility.
2. Why domain ownership is better than a shared-only handoff.
3. Domain evidence, criteria, risk model, priorities, and terminology.
4. Domain additions to the shared Review or Audit workflow.
5. Review-versus-Audit mode triggers when the domain needs stricter rules.
6. Escalation, stopping, and assessment-versus-implementation boundaries.
7. Project-local persistence and lifecycle behavior.
8. Template justification, if any.
9. Adjacent-skill handoffs.
10. Domain validation and untested runtime behavior.

Use old-before-new wording when exact instructions affect approval. Include exact paths, artifact roles, naming rules, and reserved-name exceptions for created or reorganized resources.

## Validation

Confirm:

- recurring domain assessment genuinely belongs to the target skill;
- the target contributes criteria and judgment absent from generic Review;
- unrelated requests do not activate the capability;
- shared mechanics are referenced rather than copied;
- Review and Audit remain proportional and distinct;
- assessment cannot silently become proposal or implementation;
- project-local conventions remain authoritative;
- any target-owned template has recurring evidence and a distinct contract;
- relative links resolve and only approved files changed; and
- runtime routing or trial behavior is reported as untested when not exercised.
