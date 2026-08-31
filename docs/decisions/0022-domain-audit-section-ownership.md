# Domain Audit Section Ownership

Status: Accepted
Date: 2026-08-31
Amends:

- [Tech Docs Reviewer Review and Audit Workflow](0016-tech-docs-reviewer-review-and-audit-workflow.md)
- [Code Reviewer Review and Audit Workflow](0018-code-reviewer-review-and-audit-workflow.md)

Related:

- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)
- [Researcher Evidence and Artifact Workflow](0019-researcher-evidence-and-artifact-workflow.md)
- [Skill Proposal Reviewability Preflight](0020-skill-proposal-reviewability-preflight.md)

## Context

An accepted four-owner Usage Report Audit found that Skill Creator and Researcher already assign major concepts to primary sections and run final non-duplication checks. Code Reviewer and Tech Docs Reviewer preserve strong domain evidence and reader contracts, but their formal Audit guidance lacked complete whole-artifact ownership and final-pass rules.

Local completeness could therefore produce repeated scope, evidence, rationale, outcomes, or next actions while satisfying every individual field. The approved proposal called for focused domain-owned changes rather than a shared universal template.

## Decision

Add a local section-ownership map and final non-duplication pass to Code Audit and Documentation Audit guidance and templates.

Code Audit keeps its own section names and evidence contract, including provenance, source locations, confidence, safety, unavailable evidence, untested behavior, and assurance boundaries.

Documentation Audit keeps its own section names and reader contract, including documentation mode, reader goal, reader impact, source accuracy, examples, evidence confidence, and authority boundaries.

In both domains:

- summaries orient without owning detailed evidence;
- scope and evidence establish coverage, provenance, exclusions, and limits;
- findings own material evidence, impact, and direction;
- good decisions preserve behavior not already recorded as accepted findings;
- questions and untested areas own only their specific gaps;
- outcomes record final state, boundary, and next action without repeating findings; and
- a final pass removes repeated context while preserving short local detail required for safety, correctness, evidence, confidence, scope, reader impact, or authority.

Do not use line, heading, sentence, paragraph, or artifact-length thresholds as pass/fail rules.

## Boundary

This decision changes only the Code Reviewer and Tech Docs Reviewer formal Audit format references and templates. It does not change reviewer cores, routing, conversational Review, persistence, priorities, outcomes, evidence-and-safety ownership, source-accuracy ownership, Annotation Handoff, or implementation authority.

The shared principle does not create a global Audit template or flatten domain-specific section names and evidence contracts. It relates to but does not amend Researcher decision `0019` or Skill Creator artifact decisions.

## Reasons

- One primary location per concept reduces repeated review content without weakening necessary evidence.
- A final whole-artifact pass catches duplication that local field rules cannot detect.
- Domain ownership preserves code assurance limits and documentation reader impact.
- Contextual decision density is more reliable than mechanical size limits.
- Existing reviewer routing already reaches the affected references and templates, so core changes are unnecessary.

## Consequences

- **Benefits:** Formal Audits should be easier to scan and should repeat less scope, evidence, rationale, outcomes, and next actions.
- **Costs:** Authors perform one additional final drafting pass and must distinguish unavailable evidence from untested behavior.
- **Risks:** Over-aggressive concision could remove needed evidence or reader context; explicit preservation exceptions mitigate this.
- **Compatibility:** Existing modes, templates, outcomes, persistence, routing, and historical artifacts remain valid.
- **Maintenance:** Each reviewer owns its local wording and must keep its format reference and template aligned.

## Alternatives

- Copy Skill Creator wording unchanged — rejected because code and documentation Audits have different evidence and reader contracts.
- Change reviewer cores — rejected because formal modes already route to the correct resources.
- Add one shared global template — rejected because it would flatten domain ownership.
- Change Skill Creator or Researcher again — rejected because both passed the accepted Audit.
- Use line, heading, sentence, paragraph, or artifact-length thresholds — rejected because necessary evidence and decision density are contextual.

## Traceability

- Source: approved `Audit Formal Artifact Concision Across Skills` in the external task vault.
- Proposal: approved `Proposal Add Domain Audit Section Ownership` in the external task vault.
- Amends: [Decision 0016](0016-tech-docs-reviewer-review-and-audit-workflow.md) and [Decision 0018](0018-code-reviewer-review-and-audit-workflow.md).
- Related without amendment: [Decision 0015](0015-skill-artifact-assessment-and-proposal-guidance.md), [Decision 0019](0019-researcher-evidence-and-artifact-workflow.md), and [Decision 0020](0020-skill-proposal-reviewability-preflight.md).

## Related Changes

- `.agents/skills/code-reviewer/references/review-format.md`
- `.agents/skills/code-reviewer/assets/code-audit-template.md`
- `.agents/skills/tech-docs-reviewer/references/review-format.md`
- `.agents/skills/tech-docs-reviewer/assets/documentation-audit-template.md`
- `docs/decisions/0016-tech-docs-reviewer-review-and-audit-workflow.md`
- `docs/decisions/0018-code-reviewer-review-and-audit-workflow.md`
