# Conditional Skill Creator Record Assessment

Status: Accepted
Date: 2026-09-06

## Context

[Decision 0004](0004-skill-decision-record-workflow.md) requires assessment and a decision-record outcome on every skill task. Skill Creator implements this in its core, Audit guidance, and validation guidance. Routine wording corrections already avoid loading the full Decision Record workflow, but still produce a `not recommended` announcement.

The user approved the simplification proposal's direction and limited current implementation to Skill Creator. The proposal seeks less routine reporting without losing consequential decisions or their rationale. The user accepted the supplemental Audit and this record before implementation, authorizing the limited policy exception below.

[Decision 0026](0026-decision-record-skill.md) gives the shared Decision Record skill ownership of worthiness and record mechanics. That ownership does not itself remove Decision 0004's every-task obligation.

## Decision

For Skill Creator work, retain a lightweight decision-trigger check but make substantive assessment and routine outcome reporting conditional on the work's impact.

- Use `decision-record` for substantive assessment when the work creates or changes durable architecture, responsibility, workflow, compatibility, migration, safety, or a similarly consequential decision.
- Activate the shared workflow for a direct record request or a stronger active requirement. Assess uncertain impact instead of assuming it is routine.
- Routine wording, formatting, or validation-only work with no broader decision needs neither a separate worthiness assessment nor a routine `not recommended` announcement. Reversibility alone does not exempt consequential work.
- When assessment is required, report its outcome and reason. Preserve preliminary Audit signals, final proposal outcomes, exact record scope, and approved persistence when applicable.
- Keep the core as the trigger owner and align Audit and validation references with it. Validation must still expose missing, contradictory, unsafe, or outdated design assumptions rather than silently conforming to them or redesigning the skill.

Skill Creator continues to supply domain evidence and authority context. Decision Record continues to own substantive worthiness, record format, lifecycle, storage, supersession, traceability, and record validation. No ownership moves to templates or generated skills.

## Supersession Scope

This record partially supersedes [Decision 0004](0004-skill-decision-record-workflow.md) only for Skill Creator's unconditional every-task assessment and outcome-reporting obligation, including its routine `not recommended` explanation. It does not retire Decision 0004's remaining requirements or change other workflows' instructions.

Preserve selective record creation for durable choices, direct-request handling, exact-file approval, repository containment, historical rationale, validation, and explicit commit authority. Recommended records remain part of the approved change scope rather than an optional retrospective follow-up.

Decision 0004 retains its original date, decision text, rationale, alternatives, and consequences. Only a partial-supersession status qualifier and reciprocal link identify this exception.

A stronger active project/global requirement prevails. This record does not authorize removing every-task checks elsewhere or changing the shared Decision Record skill.

## Reasons

- Separate a quick impact check from a full worthiness workflow and a repeated user-facing announcement.
- Preserve deliberate assessment where future maintainers need rationale or where uncertainty could hide a consequential change.
- Make the exception traceable rather than silently changing accepted policy through wording edits.
- Keep shared mechanics centralized and retain validation's ability to challenge unsafe assumptions.

## Consequences

- Routine Skill Creator work can be quieter after implementation; no efficiency improvement has been measured.
- Correct impact classification becomes more important. Uncertain safety, ownership, migration, or compatibility effects must trigger assessment.
- The core, Audit signal, validation handoff, and final-response guidance need coordinated updates so contradictory universal reporting clauses do not survive.
- Completion checks must distinguish routine corrections from consequential and uncertain scenarios, preserve exact-scope approval, and report untested runtime behavior.
- Other skills and tasks 022–026 remain outside current execution scope. The Skill Creator portions of both proposals remain additive, not competing replacements.

## Alternatives

| Option                                                         | Assessment                                                                                                                                           |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Keep every-task assessment and reporting                       | Simple and auditable, but retains routine announcements even where no consequential decision exists.                                                 |
| Keep the impact trigger; assess and report conditionally       | Selected direction. Reduces routine reporting while preserving direct requests, stronger rules, consequential decisions, and uncertainty escalation. |
| Remove the trigger and report only on explicit record requests | Rejected direction. Risks losing durable rationale merely because the user did not request a record by name.                                         |

These assessments state the rationale for the accepted decision, not measured runtime results. Implementation authority comes from the user's separate exact-scope approval, not this record.

## Related Changes

- [Supplemental Skill Creator Audit](../audit/audit-skill-creator-simplification-260906-1546.md) — evidence, preserved safeguards, and limitations.
- [Improve Skill Creator](../proposals/proposal-skill-creator-simplification.md#narrow-record-reporting) — proposed behavior and affected skill-resource scope.
- [Improve Skill Workflows](../proposals/proposal-improve-skill-structure-and-wording.md#clarify-skill-creator) — companion stages and transition guidance retained by the supplement.
- [Skill Creator](../../.agents/skills/skill-creator/SKILL.md), [Audit signal](../../.agents/skills/skill-creator/references/audit-format.md#decision-record-signal), and [validation handoff](../../.agents/skills/skill-creator/references/skill-validation.md#decision-record-handoff) — current policy owners to reconcile after acceptance.
- Tasks [020](../../tasks/020-audit-and-propose-skill-structure-improvements.md) and [021](../../tasks/021-improve-skill-creator-structure-and-wording.md) — review and implementation tracking; neither is completed by creating this record.
