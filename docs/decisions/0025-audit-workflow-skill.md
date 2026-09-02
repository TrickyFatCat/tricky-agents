# Audit Workflow Skill

Status: Accepted
Date: 2026-09-01

## Context

Usage reports showed recurring drift in Review, Audit, proposal, metadata, table-of-contents, lifecycle, and section-ownership guidance across several skills. Fixing a shared artifact pattern required parallel changes in Skill Creator, Agents Maintainer, Tech Docs Reviewer, Tech Docs Writer, and potentially other domain skills.

Earlier decisions rejected a universal Audit or proposal template because domain contracts differ. The new requirement is narrower: centralize generic artifact workflow mechanics while preserving domain-specific evidence, criteria, and authority in domain skills.

## Decision

Create `audit-workflow`, a shared global skill for reusable Review, formal Audit, and proposal mechanics. Keep Review and Audit guidance in separate references because they have different strictness, persistence, and output structure.

The skill owns:

- conversational Review structure and boundaries;
- formal Audit structure, section ownership, limitations, and judgment patterns;
- proposal lifecycle, exact-scope approval contracts, action structure, and file-change boundaries;
- adaptable Audit and proposal templates; and
- cross-skill artifact workflow handoffs.

The skill does not own:

- domain-specific evidence, criteria, or recommendations;
- skill architecture or skill-validation judgment;
- global repository approval, path safety, commits, or pushes;
- persistent task planning or task status;
- decision-record workflow; or
- implementation after approval.

Create these resources:

- `.agents/skills/audit-workflow/SKILL.md`
- `.agents/skills/audit-workflow/references/review.md`
- `.agents/skills/audit-workflow/references/audit.md`
- `.agents/skills/audit-workflow/references/proposals.md`
- `.agents/skills/audit-workflow/assets/artifact-audit-template.md`
- `.agents/skills/audit-workflow/assets/artifact-proposal-template.md`

## Reasons

- Central ownership reduces repeated edits when shared artifact mechanics change.
- A skill can carry behavioral instructions that template-only reuse cannot express.
- Keeping domain criteria outside the shared skill prevents flattened code, documentation, research, skill, and maintenance Audits.
- Explicit handoffs preserve the boundaries between Review, Audit, proposal, approval, implementation, validation, and commits.
- Deferring migrations lets the new shared skill be reviewed before dependent skills reference it.

## Consequences

- Future migrations can replace duplicated artifact mechanics with references to `audit-workflow`.
- Domain skills gain a shared dependency and must preserve their own evidence contracts explicitly.
- The shared skill changes the practical consequence of earlier anti-universal-template decisions without replacing their domain-boundary rationale.
- Runtime discovery must be verified in a fresh session or skill scan before claiming the new skill is available to future agents.
- Existing historical artifacts and decisions remain valid; migration requires separate approved tasks.

## Alternatives

- Keep artifact workflow guidance duplicated in each domain skill. Rejected because usage reports show recurring drift and maintenance cost.
- Move domain Audit criteria into the shared skill. Rejected because domain Audits need different evidence contracts and authority boundaries.
- Create only shared templates. Rejected because lifecycle, routing, handoff, persistence, and approval boundaries require behavior instructions.
- Migrate existing skills in the same change. Rejected because dependent migrations should wait for the shared skill to be approved and validated.

## Related Changes

- Proposal: [Create Audit Workflow Skill](../proposals/proposal-create-audit-workflow-skill.md)
- Task: `tasks/001-create-audit-workflow-skill.md`
- Usage report: `.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-03.md`
- Usage report: `.agents/skill-usage-reports/skill-creator/report-20260829-skill-creator-01.md`
- Usage report: `.agents/skill-usage-reports/agents-maintainer/report-20260830-agents-maintainer-01.md`
- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)
- [Skill Proposal Reviewability Preflight](0020-skill-proposal-reviewability-preflight.md)
- [Domain Audit Section Ownership](0022-domain-audit-section-ownership.md)
- [Skill Usage Report System and Interaction Rules](0023-skill-usage-report-system-and-interaction-rules.md)
