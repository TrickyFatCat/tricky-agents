# Skill Audit and Proposal Workflow

Status: Accepted
Date: 2026-08-29
Supersedes: [Skill Review Report Format](0002-skill-review-report-format.md)
Amended By:

- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)
- [Skill Assessment and Usage Report Guidance](0017-skill-assessment-and-usage-report-guidance.md)

## Context

Skill Creator used Review for both a formal pre-change assessment and informal critique. Its substantial review format described individual findings well but did not orient the reader to the whole artifact, require an explicit assessment outcome, or preserve a saved proposal approval checkpoint before implementation.

Two usage reports identified retrospective proposal creation, combined proposal and implementation phases, overloaded Audit and Review terminology, weak whole-artifact summaries, and duplicated decision-record judgments.

## Decision

Adopt this workflow for tracked skill changes that require persistent Audit and proposal artifacts:

1. Save a bounded Audit.
2. Let the user review and correct the Audit.
3. Record `no change`, `research`, `defer`, or `proposal required`.
4. For `proposal required`, create a separate exact-file proposal with `status: proposed`.
5. Revise the saved proposal during user review.
6. Record `status: approved` only after exact acceptance and before editing.
7. Implement in a separate phase, validate, then record `status: implemented`.

Use Audit for the formal bounded assessment. Use Review for informal critique and for user review of audits, proposals, and implementation results. Keep lightweight Review proportional and normally conversational rather than creating a second persistent template.

Begin substantial Audits and proposals with compact whole-artifact summaries. Keep detailed finding formatting and Findings Overview for local navigation.

Use one `Decision Record` heading in each artifact:

- the Audit records a preliminary signal and reason;
- the proposal records the final outcome, reason, and exact path.

Rename the formal resources:

- `references/review-format.md` to `references/audit-format.md`;
- `assets/skill-review-report-template.md` to `assets/skill-audit-report-template.md`.

Do not keep compatibility copies. Update active links together and preserve historical artifacts without rewriting their chronology or terminology.

## Reasons

- Distinct artifact roles make the workflow easier to understand and resume.
- A persistent approved proposal proves that exact scope was reviewed before edits.
- Explicit Audit outcomes prevent findings from drifting into ambiguous follow-up.
- Compact summaries improve whole-artifact scanability without duplicating detailed evidence.
- Preliminary and final decision-record stages preserve judgment development without repeating competing final sections.
- Renaming the active resources removes semantic mismatch while Git preserves file history.

## Consequences

- Tracked skill changes gain an additional visible lifecycle checkpoint.
- Agents must update proposal status as the workflow advances.
- Formal Audits use one renamed reference and template; lightweight Review remains available without its own template.
- Existing direct links to the old active resource names stop resolving, but active repository links migrate together.
- Historical task artifacts and accepted decision `0008` retain their original paths and terminology as historical context.
- Trivial untracked corrections do not require persistent Audit and proposal artifacts unless another active rule requires them.

## Alternatives

- Keep the old filenames and change only visible terminology. Rejected because formal Audit resources would retain misleading Review names.
- Maintain separate persistent Audit and Review templates. Rejected because informal Review does not have a distinct durable artifact contract.
- Require the lifecycle for every correction. Rejected because it would add unnecessary process to trivial untracked work.
- Rewrite historical artifacts. Rejected because it would imply terminology and sequencing that did not exist at the time.

## Related Changes

- [Decision 0002](0002-skill-review-report-format.md) — superseded formal review-format contract.
- [Decision 0008](0008-skill-creator-template-foundation.md) — preserved template-foundation context.
- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/audit-format.md`
- `.agents/skills/skill-creator/references/skill-design.md`
- `.agents/skills/skill-creator/references/decision-records.md`
- `.agents/skills/skill-creator/assets/skill-audit-report-template.md`
- `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- `.agents/skills/agents-maintainer/SKILL.md`
