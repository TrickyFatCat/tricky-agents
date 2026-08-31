# Skill Assessment and Usage Report Guidance

Status: Accepted
Date: 2026-08-30
Amends:

- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)

Amended By:

- [Skill Usage Report System and Interaction Rules](0023-skill-usage-report-system-and-interaction-rules.md)

Related: [Tech Docs Reviewer Review and Audit Workflow](0016-tech-docs-reviewer-review-and-audit-workflow.md)

## Context

Skill Creator applied one formal Audit resource contract to both whole-skill assessment and focused usage-report work. Full resource evaluation was disproportionate when report findings implicated only a bounded resource set. Formal Audit output also separated Findings Overview from Findings, adding navigation noise.

Tech Docs Reviewer provided implementation evidence for an explicit Quick Review mode without a Quick Review asset. A later interaction showed that substantial reusable feedback could be deferred correctly but still miss the usage-report prompt because it was not phrased as a direct complaint.

## Decision

Refine skill assessment and report guidance:

- Keep Review conversational and allow lightweight report triage when only lifecycle metadata or traceability needs correction and no behavior change is proposed.
- Add Usage Report Audit for selected usage reports and materially related resources.
- Keep full Skill Audit for explicit whole-skill requests and broad or uncertain effects.
- Escalate focused report work when routing, safety, responsibility, architecture, resource-wide migration, or interactions outside the focused set can change the outcome.
- Add a Skill Creator-owned `skill-usage-report-audit-template.md`; keep the existing full Skill Audit template separate.
- Put numbered linked navigation inside one parent `Findings` section and keep detailed finding headings descriptive and unnumbered.
- Add an adaptable Quick Review baseline to target-skill capability guidance without creating a universal asset or requiring the term across skills.
- Ask whether to create a usage report when substantial reusable feedback must be deferred or handed off and is not already reported.
- Keep report creation user-controlled and exempt routine current-task corrections, minor preferences, illustrative examples, active-task requirements, and already-reported issues.
- Preserve project-local storage, metadata, naming, approval, renderer, formatting, and validation authority.

## Reasons

- Proportional assessment scope keeps report findings visible without weakening evidence quality.
- Explicit escalation prevents focused Audits from hiding broad dependencies.
- A target-owned template stabilizes report lifecycle and related-resource evaluation without imposing one project convention.
- Numbered navigation preserves sequence while unnumbered headings remain cleaner and easier to reuse.
- A minimal Quick Review baseline speeds target-skill design while domain-specific labels and templates remain local.
- Prompting before report creation preserves user control and improves traceability for deferred reusable feedback.

## Consequences

- **Benefits:** Report-driven work can use a smaller formal scope, while full Skill Audit retains whole-resource coverage.
- **Costs:** Agents must choose between Review, Usage Report Audit, and full Skill Audit and maintain one additional template.
- **Risks:** Focused scope may omit a material dependency; explicit exclusions and escalation checks mitigate this.
- **Compatibility:** Existing full Audit lifecycle and outcomes remain valid. Historical Audits and superseded decision `0002` remain unchanged.
- **Template boundary:** Skill Creator owns both formal Audit templates; target skills still own justified domain templates.
- **Report boundary:** Deferred notes do not replace a report prompt when the substantial reusable-feedback threshold applies.
- **Runtime evidence:** Fresh-session mode selection and live ambiguous-feedback prompting require later trials.

## Alternatives

- Require full Skill Audit for every usage report — rejected because it adds disproportionate resource evaluation.
- Use only informal triage — rejected because actionable reports need formal evidence, outcomes, and proposal boundaries.
- Create a separate Usage Report Audit reference — rejected because existing Audit format guidance owns assessment modes.
- Add a universal Quick Review asset — rejected because domain contracts and project conventions differ.
- Create reports automatically from reusable feedback — rejected because report persistence requires user confirmation.
- Rewrite superseded decision `0002` — rejected to preserve historical chronology.

## Traceability

- Source: approved `Update Skill Creator` Audit and proposal in the external task vault.
- Usage reports: Findings hierarchy duplication; ambiguous skill feedback report prompt.
- Related implementation evidence: [Decision 0016](0016-tech-docs-reviewer-review-and-audit-workflow.md).
- Amended decisions: [Decision 0012](0012-skill-audit-and-proposal-workflow.md) and [Decision 0015](0015-skill-artifact-assessment-and-proposal-guidance.md).

## Related Changes

- `.agents/AGENTS.md`
- `.agents/references/skill-usage-reports.md`
- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/audit-format.md`
- `.agents/skills/skill-creator/references/skill-validation.md`
- `.agents/skills/skill-creator/references/audit-review-capability.md`
- `.agents/skills/skill-creator/assets/skill-audit-report-template.md`
- `.agents/skills/skill-creator/assets/skill-usage-report-audit-template.md`
- `docs/decisions/0012-skill-audit-and-proposal-workflow.md`
- `docs/decisions/0015-skill-artifact-assessment-and-proposal-guidance.md`
