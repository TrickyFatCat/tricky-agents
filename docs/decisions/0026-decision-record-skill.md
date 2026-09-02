# Decision Record Skill

Status: Accepted
Date: 2026-09-02

## Context

Decision records can originate from research, design, review, task management, implementation planning, or ordinary conversation. Keeping decision-record triggers, templates, statuses, storage, supersession, and validation rules inside every origin skill creates drift and conflicting behavior.

A usage report requested a separate shared decision-record capability. The accepted proposal selected a global skill that records confirmed decisions and manages record mechanics without deciding on the user's behalf.

## Decision

Create `decision-record`, a shared global skill for durable decision-record and ADR mechanics.

The skill owns:

- decision-worthiness checks;
- record structure and required concepts;
- fallback statuses and metadata guidance;
- storage and naming precedence;
- supersession mechanics;
- traceability and link validation; and
- an adaptable MADR-based decision-record template.

The skill does not own:

- the user's or domain owner's actual decision;
- domain-specific decision criteria;
- implementation of recorded decisions;
- global repository approval, commits, or pushes;
- task planning or task status; or
- migration of existing skills and historical decisions.

Create these resources:

- `.agents/skills/decision-record/SKILL.md`
- `.agents/skills/decision-record/references/decision-records.md`
- `.agents/skills/decision-record/assets/decision-record-template.md`

Use project-local decision conventions first. When no stronger convention exists, use `docs/decisions/NNNN-<decision-slug>.md` for numbered decision sets. Use `docs/adr/` only for architecture-specific ADR conventions.

Use the full MADR structure as the fallback template. Do not create a separate light template now; MADR's optional sections provide enough flexibility. Future specialized templates, such as Design Decision Record templates with `Unknowns`, require separate evidence and proposal work.

## Reasons

- Central ownership prevents each domain skill from developing partial ADR mechanics.
- Separating decision recording from decision authority prevents agent recommendations from becoming accepted decisions by accident.
- Project-local precedence preserves existing repository and vault conventions.
- MADR provides a flexible established fallback without inventing a parallel structure.
- Deferring migrations lets the new skill be reviewed and validated before dependent skills reference it.

## Consequences

- Future migrations can replace duplicated decision-record mechanics with references to `decision-record`.
- Origin workflows must provide enough context: decision question, chosen outcome, drivers, considered options, consequences, authority, and evidence.
- Specialized record types can be proposed later when evidence shows they need different sections.
- Existing historical decisions remain valid; migration or supersession requires separate approval.
- Runtime discovery must be verified in a fresh session or skill scan before claiming the new skill is available to future agents.

## Alternatives

- Keep decision-record rules inside every domain skill. Rejected because it duplicates status, storage, naming, validation, and supersession behavior.
- Let the skill decide domain outcomes. Rejected because the user or domain workflow owns decisions.
- Use `docs/adr/` as the universal fallback. Rejected because ADR can imply architecture-only scope.
- Create a light decision template now. Rejected because it adds template-selection complexity and MADR optional sections already cover lighter records.
- Migrate existing skills in the same change. Rejected because dependent migrations should wait for the shared skill to be approved and validated.

## Related Changes

- Proposal: [Create Decision Skill](../proposals/proposal-create-decision-skill.md)
- Task: `tasks/002-create-decision-skill.md`
- Usage report: `.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-04.md`
- [Skill Decision Record Workflow](0004-skill-decision-record-workflow.md)
- [Skill Decision Record Capability Boundary](0011-skill-decision-record-capability-boundary.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)
- [Audit Workflow Skill](0025-audit-workflow-skill.md)
- MADR template: [MADR decision record template](https://github.com/adr/madr/blob/develop/template/template.md)
