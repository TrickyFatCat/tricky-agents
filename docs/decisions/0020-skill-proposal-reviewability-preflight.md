# Skill Proposal Reviewability Preflight

Status: Accepted
Date: 2026-08-31
Amends:

- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)

## Context

Three Skill Creator proposal-guidance reports recurred after earlier guidance had added vertical old-before-new wording, readable proposal patterns, and formal-artifact concision checks. The initial Researcher proposal still omitted approval-relevant template structures and exact wording. Later revisions added mechanical detail, including an unjustified schema field and an old/new block that could not change approval.

A focused Usage Report Audit found an application gap rather than missing principles: proposal preparation did not require one explicit per-action accounting pass before user review.

## Decision

Before requesting review of a tracked Skill Creator change proposal, run one proportional proposal preflight with two checks:

1. **Approval-content coverage:** Account for every exact file and action. Give each material decision one primary review location and include the behavior contract, current and proposed wording, exact reusable output shape, operational detail, or accepted-evidence link that the decision needs.
2. **Exact-block removal:** For every exact wording, schema, template, example, or structure block, identify the approval decision it can change. Remove or summarize the block when no scope, behavior, compatibility, safety, validation, migration, authority, or wording decision depends on it.

Keep exact paths, artifact roles, naming, boundaries, migrations, and required validation. Preserve full proposed structures for new reusable templates when their shape affects approval. Do not require a human-facing coverage grid, draft complete future resources by default, or use artifact length as a pass/fail rule.

This preflight refines Skill Creator's own proposal workflow. It does not establish universal Proposal capability for target skills or combine proposal, approval, and implementation authority.

## Reasons

- Per-action accounting detects omitted approval content before the user must reconstruct it.
- A decision-relevance test removes mechanical exact detail without weakening fragile contracts.
- One proportional preflight is more actionable than adding more generic concision prose.
- Agent-facing checks preserve readable human-facing proposals without mandatory grids.

## Consequences

- **Benefits:** First-draft proposals should expose material choices more reliably and require fewer structural review corrections.
- **Costs:** Proposal authors must classify each action and justify exact blocks before requesting review.
- **Risks:** The preflight could become mechanical; proportional application and the ban on mandatory grids or size limits reduce that risk.
- **Compatibility:** Existing proposals and historical artifacts remain unchanged. Current lifecycle, wording, naming, and exact-file rules continue to apply.
- **Maintenance:** Skill Creator owns the trigger, reusable template pattern, and validation checks.

## Alternatives

- Add more generic concision prose — rejected because existing principles did not prevent recurrence.
- Require complete future files — rejected because most implementation detail cannot change approval.
- Require old/new blocks for every modification — rejected because conceptual changes and simple status updates may not need exact replacement text.
- Add line or heading thresholds — rejected because decision density and fragility are contextual.
- Change target-skill Proposal capability — rejected because the reports concern Skill Creator's own change workflow.

## Traceability

- Source: accepted `Audit Skill Creator Proposal Guidance Regressions` and approved `Proposal Add Skill Creator Proposal Preflight` in the external task vault.
- Reports: `formal-proposal-prose-remains-too-wordy`, `wording-proposals-need-old-before-new`, and `proposal-examples-need-readable-patterns`.
- Prior implementation: commit `e01d57e1f9691719f314504471bed30f660ea049`.
- Amends: [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md) and [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md).

## Related Changes

- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- `.agents/skills/skill-creator/references/skill-validation.md`
- `docs/decisions/0012-skill-audit-and-proposal-workflow.md`
- `docs/decisions/0015-skill-artifact-assessment-and-proposal-guidance.md`
