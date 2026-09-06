# Skill Decision Record Workflow

Status: Accepted (partially superseded)
Date: 2026-08-26
Partially superseded by: [Conditional Skill Creator Record Assessment](0027-skill-creator-conditional-record-assessment.md) for Skill Creator's every-task assessment and outcome-reporting obligation only.

## Context

Git history records what changed in a skill but often does not preserve why a routing, safety, architecture, or shared-convention decision was made. Optional decision-record prompts can also leave significant reasoning undocumented, while recording every small edit would duplicate Git history and create maintenance noise.

A consistent workflow is needed to assess decision value without weakening exact-file approval requirements for global agent resources.

## Decision

Every skill creation, review, update, refactor, rename, or decision-record task will assess whether a decision record is warranted.

- Always report the decision-record outcome and its reason.
- When a record is recommended, include its exact path in the approval scope and create it with the approved skill changes. Do not make it an optional follow-up after approval.
- When the user directly requests a record, treat it as mandatory and proceed through the creation workflow.
- When a record is not recommended, explain why Git history is sufficient.
- Preserve repository approval, exact-file scope, path-safety, validation, and commit boundaries.
- When no repository convention exists, use `docs/decisions/NNNN-<decision-slug>.md` as the proposed fallback.
- Keep records selective: durable behavior, routing, safety, architecture, migration, shared contracts, and recurring trade-offs warrant records; routine wording and formatting changes normally do not.
- Use repository-defined status meanings when available. Otherwise distinguish `Proposed`, `Accepted`, selective `Rejected`, `Superseded`, and `Deprecated` records.
- Create a new record when a material decision changes. Link superseding and superseded records to each other and update their statuses.
- Preserve links to source tasks, proposals, reviews, reports, research, issues, related decisions, affected paths, and commits when they materially informed the decision.
- Omit irrelevant traceability fields rather than leaving empty placeholders.

## Reasons

Mandatory assessment makes the decision explicit on every skill task. Automatic creation for recommended records prevents important reasoning from being deferred or forgotten, while the not-recommended reason keeps routine work lightweight and auditable.

## Consequences

- Every skill task gains one concise decision-record outcome.
- Significant skill changes create an additional documentation artifact.
- Recommended records must be identified before approval when possible.
- If the need emerges after approval, work pauses for expanded exact-file approval.
- Routine edits do not create records, but the reason for omitting one remains visible.
- Decision records require formatting, path checks, lifecycle checks, reciprocal supersession links, and source validation alongside the skill changes.
- Selective `Rejected` records preserve recurring rationale without requiring a record for every declined proposal.
- Material decision changes create a new record instead of silently rewriting accepted history.

## Alternatives

- Rely only on Git commits. Rejected because diffs and short commit messages may not preserve alternatives and long-term reasoning.
- Ask whether to create every recommended record. Rejected because significant records can be postponed or skipped despite an established need.
- Record every skill edit. Rejected because it would duplicate Git history and produce low-value maintenance overhead.
- Allow recommended records to bypass approval. Rejected because a decision record is still a global repository change.

## Related Changes

- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/decision-records.md`
- `.agents/skills/skill-creator/assets/decision-record-template.md`
- `docs/decisions/0001-editorial-marker-workflow.md`
- `docs/decisions/0002-skill-review-report-format.md`
- `docs/decisions/0003-separate-document-and-agent-approvals.md`
