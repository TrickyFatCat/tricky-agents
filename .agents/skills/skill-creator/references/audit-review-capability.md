# Audit and Review Capability Design

Read this reference when designing or reviewing a target skill that may perform domain-specific Audits or Reviews during normal use.

Do not read this reference merely because Skill Creator is auditing the target skill. Use [audit-format.md](audit-format.md) for Skill Creator's own formal Audit workflow.

## Capability Test

Add Audit or Review capability to a target skill only when all applicable conditions are met:

- Recurring domain assessment belongs to the skill's primary responsibility or a clear supporting responsibility.
- The skill has domain criteria that generic critique would miss.
- A handoff would lose important context or make the result less actionable.
- The skill can separate assessment from implementation.
- The capability can remain inactive during unrelated requests.

Do not add the capability merely because:

- Skill Creator audited the skill;
- the skill sometimes checks its own output;
- another skill already owns the relevant assessment domain;
- one task needed a formal report;
- a generic template could be copied into the skill.

## Responsibility Boundary

Define which operations the target skill owns:

- choose a formal Audit or informal Review;
- establish domain-specific scope and evidence;
- assess behavior against named criteria;
- report findings, strengths, limitations, and unknowns;
- recommend a next action without silently implementing it;
- persist and update an approved assessment artifact when the active project requires one.

Do not assign every operation automatically. Keep research, approval, task management, implementation, repository maintenance, and unrelated review domains with their responsible workflows.

## Formal Audit versus Informal Review

Use **Audit** for a bounded assessment with explicit scope, evidence, limitations, and an outcome. Persist it only when the user or active workflow requires a durable artifact.

Use **Review** for proportional critique, feedback on an artifact, or the user's review of prior work. Keep it conversational by default.

A target skill may use established domain terminology instead of Audit and Review when the distinction remains clear. Do not force Skill Creator's exact outcome vocabulary onto unrelated domains.

## Quick Review

Use `Quick Review` as an explicit target-skill mode only when the skill benefits from a visible contrast with formal Audit. Do not require the term across all review skills.

Use this adaptable baseline:

1. **Orientation:** For three or more findings, use no more than three bullets for count or distribution, the main concern, and the first action. Omit orientation when one or two findings are already clear.
2. **Findings:** Present the highest-value domain findings in source or application order. Use a numbered navigation list when useful and descriptive finding headings without numeric prefixes.
3. **Finding content:** Include only labels that help the domain, normally observation or evidence, user or system impact, and a focused direction. Keep priority or status separate from the heading when the target skill uses them.
4. **Strengths:** Preserve specific good decisions when they prevent regression; omit generic praise.
5. **Questions:** Ask only questions that can change a finding or next action.
6. **Next action:** End with one focused action or decision when useful.

Use domain implementations as evidence, not as universal schemas. Let target skills adapt labels, priorities, evidence, ordering, terminology, and handoffs. Scale the baseline down rather than filling every section mechanically.

Keep these boundaries:

- Quick Review is conversational and proportional by default.
- Response length alone does not make Review an Audit.
- Persist it only when the user or project requests saving.
- Saving, source annotation, proposal, approval, and implementation are separate operations.
- The target skill owns domain criteria and any justified concrete template.

This baseline speeds skill design without a generic asset. A copyable asset would encourage rigid cross-domain labels and sections, conflict with project-local output conventions, and blur target-template ownership.

## Output Content Contract

A substantial formal Audit should include these concepts when relevant:

- compact whole-artifact orientation;
- scope and exclusions;
- evidence and assessment criteria;
- prioritized findings;
- behavior worth preserving;
- limitations and untested areas;
- explicit outcome and next action.

Keep findings direct and traceable to evidence. Separate observed facts, interpretation, and recommendations when confusing them could change the decision.

Scale informal Review and Quick Review down. Do not require a fixed report shape for one or two clear comments.

## Persistence and Lifecycle

Follow the active project lifecycle first.

When no project lifecycle exists:

- keep informal Review and Quick Review in conversation by default;
- save Quick Review only when the user or project requests persistence;
- persist a formal Audit only when durable traceability helps;
- record an assessment state without implying proposal approval or implementation;
- update the same artifact when review corrections preserve its identity;
- preserve historical artifacts when a replacement would change chronology.

An approved Audit does not automatically create a proposal. Create one only when the user or active workflow requests the proposal phase.

## Project Storage and Approval

Follow project-local storage, naming, metadata, linking, approval, and validation rules.

Before writing or changing a persistent assessment:

1. Inspect the target and owning workflow.
2. Explain the state change and affected artifacts.
3. Obtain required approval.
4. Validate the saved artifact in its actual storage context.

Do not impose one repository, vault, filename, or metadata convention globally.

## Template Ownership

Keep concrete output templates with the target skill that repeatedly produces them.

Create a target-skill template only when recurring or fragile output justifies one. Use a semantic filename, mark optional sections, support project-local overrides, and tell agents to omit irrelevant scaffolding.

Do not reuse `skill-creator/assets/skill-audit-report-template.md` as a generic target-skill output asset. It is reserved for formal Skill Creator Audits.

Do not create a universal Quick Review asset. A target skill may own a semantically named Quick Review template only when recurring or fragile domain output justifies one.

A skill that only performs informal Review or hands assessment to another skill usually does not need a template.

## Per-Skill Proposal Requirements

When proposing Audit or Review capability for a target skill, include:

1. Exact runtime triggers and responsibility.
2. Why the capability belongs in the target skill instead of a handoff.
3. Formal Audit and informal Review boundaries.
4. Domain criteria and required output concepts.
5. Persistence, lifecycle, storage, and approval behavior.
6. Template need and ownership.
7. Adjacent-skill handoffs.
8. Quick Review trigger, adaptable baseline, and formal-versus-lightweight boundary when the target adopts that mode.
9. Validation and untested runtime behavior.

Use old-before-new wording blocks for modified instructions. Include exact paths, artifact roles, naming rules, and reserved-name exceptions for new or reorganized files.

## Validation

Confirm that:

- recurring domain assessment genuinely belongs to the target skill;
- Audit and Review remain distinguishable and proportional;
- an adopted Quick Review mode does not become Audit based on response length alone;
- Quick Review saving, source annotation, proposal, approval, and implementation remain separate;
- assessment does not silently become proposal or implementation;
- unrelated requests do not load or apply the capability;
- project-local storage and approval rules remain authoritative;
- output concepts and lifecycle states are internally consistent;
- any template is justified, semantically named, and owned by the target skill;
- no generic Quick Review asset is introduced as a substitute for target-skill design;
- relative links resolve and the proposal includes only approved files;
- runtime routing or trial behavior is reported as untested when not exercised.
