---
type: skill-change-proposal
title: "Migrate Skill Creator workflows"
status: implemented
task: "003"
created: 2026-09-02
updated: 2026-09-02
---

# Proposal: Migrate Skill Creator Workflows

<!--toc:start-->

- [Proposal Snapshot](#proposal-snapshot)
- [Overview](#overview)
- [Reasoning](#reasoning)
- [Recommended Approach](#recommended-approach)
    - [Rejected Alternatives](#rejected-alternatives)
- [Actions](#actions)
    - [Exact Files](#exact-files)
    - [Add Conditional Shared-Workflow Handoffs](#add-conditional-shared-workflow-handoffs)
    - [Keep Domain Artifact Guidance in References](#keep-domain-artifact-guidance-in-references)
    - [Centralize Decision-Record Mechanics](#centralize-decision-record-mechanics)
    - [Resolve Usage Reports](#resolve-usage-reports)
- [Source Material](#source-material)
- [Scope Boundaries](#scope-boundaries)
    - [In Scope](#in-scope)
    - [Out of Scope](#out-of-scope)
- [Validation Plan](#validation-plan)
- [Decision Record](#decision-record)
- [Approval Request](#approval-request)

<!--toc:end-->

## Proposal Snapshot

- Decision requested: approve the exact Skill Creator migration to `audit-workflow` and `decision-record`.
- Implementation files: modify 10 and delete 6; create, move, or rename none.
- Behavior: shared skills own generic artifact mechanics and templates while Skill Creator retains skill-domain judgment in focused references.
- Main trade-off: duplication decreases, but complete formal workflows require conditional cross-skill loading.
- Preserve: skill architecture, capability tests, resource evaluation, proposal preflight, validation, and the read-only audit script.

## Overview

Migrate Skill Creator away from independently maintaining generic Review, Audit, proposal, and decision-record mechanics. Add explicit conditional handoffs to the two shared skills and reduce retained guidance to skill-domain responsibilities.

Preserve Skill Creator's stronger domain contracts: whole-skill and usage-report assessment, target-skill capability design, exact-file skill proposals, proposal reviewability preflight, progressive disclosure, migration safety, and artifact-specific validation.

## Reasoning

- **Duplicate ownership:** Skill Creator still repeats mechanics assigned to `audit-workflow` and `decision-record` by decisions `0025` and `0026`.
- **Conflicting defaults:** Skill Creator's lightweight decision template competes with the shared MADR-based fallback.
- **Domain value:** Skill-specific assessment and proposal rules add criteria absent from the shared defaults and should remain in focused references.
- **Report closure:** Four open usage reports now have implementation paths through the shared skills and this migration.

## Recommended Approach

Use explicit, conditional cross-skill handoffs. Load shared artifact guidance only for formal Review, Audit, proposal, or decision-record work; do not add shared-workflow ceremony to routine skill edits.

Retain Skill Creator-owned references only where they contribute skill-domain criteria or extensions. Delete the three formal artifact templates and use the shared templates directly, with Skill Creator references supplying domain-specific adaptation.

**Main trade-off:** Skill Creator becomes dependent on shared templates and workflows for complete artifacts, but generic format changes no longer require duplicated maintenance.

### Rejected Alternatives

- **Keep duplicate guidance synchronized manually:** preserves the drift and maintenance cost identified by the usage reports.
- **Keep Skill Creator template overlays:** retains parallel reusable structures and weakens the shared templates as the source of truth.
- **Delete Skill Creator domain guidance with the templates:** loses resource evaluation, report triage, exact-file approval, and proposal preflight behavior.
- **Keep a Skill Creator-specific decision template or capability reference:** leaves competing defaults for decisions that can originate from many workflows.
- **Rewrite historical decisions:** would distort chronology; accepted decisions remain evidence for the migration.

## Actions

1. [Add conditional shared-workflow handoffs](#add-conditional-shared-workflow-handoffs) — establish runtime ownership and loading boundaries.
2. [Keep domain artifact guidance in references](#keep-domain-artifact-guidance-in-references) — preserve domain behavior without duplicating shared templates.
3. [Centralize decision-record mechanics](#centralize-decision-record-mechanics) — remove the duplicate workflow and template.
4. [Resolve usage reports](#resolve-usage-reports) — record implementation only after validation.
5. [Confirm the exact file boundary](#exact-files) — define the complete implementation scope.

### Exact Files

This list is the complete implementation approval boundary. Additional targets require renewed approval.

**Modify**

| Path                                                                            | Change                                                                                                                                                            |
| ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.agents/skills/skill-creator/SKILL.md`                                         | Add conditional shared-skill routing; narrow operating modes, workflow, Audit output, decision-record handling, and validation to Skill Creator responsibilities. |
| `.agents/skills/skill-creator/references/skill-design.md`                       | Replace generic artifact mechanics and obsolete template references with shared-skill handoffs and focused domain guidance.                                       |
| `.agents/skills/skill-creator/references/skill-validation.md`                   | Keep skill-specific validation while delegating generic artifact and decision-record validation to the shared owners.                                             |
| `.agents/skills/skill-creator/references/audit-format.md`                       | Retain Skill Audit modes, resource evaluation, report triage, priorities, and outcomes as a domain overlay on `audit-workflow`.                                   |
| `.agents/skills/skill-creator/references/audit-review-capability.md`            | Focus target-skill assessment on domain criteria, specialization need, and template ownership; delegate generic mechanics.                                        |
| `.agents/skills/skill-creator/references/proposal-capability.md`                | Focus target-skill assessment on domain proposal responsibility and extensions; delegate generic mechanics.                                                       |
| `.agents/skill-usage-reports/skill-creator/report-20260829-skill-creator-01.md` | After validation, change metadata from `open` to `implemented` and update the date; preserve the report body.                                                     |
| `.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-02.md` | After validation, change metadata from `open` to `implemented` and update the date; preserve the report body.                                                     |
| `.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-03.md` | After validation, change metadata from `open` to `implemented` and update the date; preserve the report body.                                                     |
| `.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-04.md` | After validation, change metadata from `open` to `implemented` and update the date; preserve the report body.                                                     |

**Delete**

| Path                                                                       | Reason and compatibility effect                                                                                                                                                              |
| -------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.agents/skills/skill-creator/references/decision-records.md`              | Generic decision-record workflow is now owned by `decision-record`; active links will be removed in the same change. Historical decision references remain as chronology, not runtime links. |
| `.agents/skills/skill-creator/references/decision-record-capability.md`    | Decisions can originate from many workflows; keep the recommendation and handoff in the core instead of a separate Skill Creator capability contract.                                        |
| `.agents/skills/skill-creator/assets/decision-record-template.md`          | The shared skill owns fallback template selection. No compatibility copy will remain because it would preserve competing defaults.                                                           |
| `.agents/skills/skill-creator/assets/skill-audit-report-template.md`       | Use the shared Audit template directly and keep Skill Creator-specific application guidance in references.                                                                                   |
| `.agents/skills/skill-creator/assets/skill-usage-report-audit-template.md` | Use the shared Audit template directly for report audits, with report-specific sections defined by `audit-format.md`.                                                                        |
| `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`    | Use the shared proposal template directly and keep exact-file and preflight requirements in the core and validation reference.                                                               |

**Create, move, or rename:** None.

The deleted filenames already describe their artifact roles semantically. No rename, replacement alias, or reserved-name exception is proposed.

### Add Conditional Shared-Workflow Handoffs

Update the core routing contract so ordinary skill design does not load unrelated artifact mechanics.

Current pattern:

```markdown
Read the audit-format reference for a formal Audit or substantial informal Review. Read references/decision-records.md for every skill task.
```

Proposed behavior:

```markdown
- Use `audit-workflow` for shared Review, Audit, and proposal mechanics only when the active task enters one of those modes; then apply Skill Creator's domain reference or overlay.
- For every skill task, report a decision-record outcome. Use `decision-record` for substantive worthiness checks and all record drafting, lifecycle, storage, supersession, and validation work. Routine wording or formatting corrections may record “not recommended” without loading the full workflow.
```

Keep these responsibilities in Skill Creator's always-loaded core:

- skill architecture, routing, progressive disclosure, capability assessment, safety, and artifact validation;
- exact-file global-resource approval through `agents-maintainer`;
- separation of Audit, proposal, implementation, and validation;
- the requirement to assess and report decision-record need for every skill task; and
- enough context for shared-skill handoffs.

Remove Skill Creator-owned generic definitions of:

- Review and Audit base structures;
- proposal lifecycle and generic section ownership;
- decision-record statuses, storage fallbacks, supersession, and generic record validation; and
- reusable artifact mechanics already supplied by the shared references.

Routing checks:

- **Matching:** “Audit Skill Creator and prepare a saved migration proposal” should combine `skill-creator`, `audit-workflow`, and `agents-maintainer`.
- **Near miss:** “Correct a typo in a skill example” should use `skill-creator` and `agents-maintainer` without loading formal Audit/proposal guidance or the full decision-record workflow.
- **Decision trigger:** A durable routing or responsibility change should add `decision-record`; routine formatting should report that no record is recommended.

### Keep Domain Artifact Guidance in References

Delete Skill Creator's three formal artifact templates and use the shared templates directly.

| Retained Skill Creator reference                                         | Shared resource                                                                     | Domain guidance retained                                                                                                                                                                   |
| ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `references/audit-format.md`                                             | `audit-workflow/references/audit.md` and `assets/artifact-audit-template.md`        | Full Skill Audit and Usage Report Audit selection, owned-resource evaluation, report triage, escalation, skill-specific priorities, outcomes, and proposal handoff context.                |
| `references/audit-review-capability.md`                                  | `audit-workflow/references/review.md` and `references/audit.md`                     | The test for whether a target skill owns domain assessment and the domain information it must add to shared mechanics.                                                                     |
| `references/proposal-capability.md` and `references/skill-validation.md` | `audit-workflow/references/proposals.md` and `assets/artifact-proposal-template.md` | Target-skill proposal responsibility, exact global-resource boundaries, old-before-new wording, artifact roles and naming, capability contracts, proposal preflight, and skill validation. |

Preserve the proposal preflight in the core and `skill-validation.md`:

1. Account for every exact file and action and include approval-relevant content.
2. Remove exact blocks that cannot affect scope, behavior, compatibility, safety, validation, migration, authority, or wording approval.

Keep `references/audit-format.md` as the Skill Creator domain method. It will retain:

- Review versus Usage Report Audit versus full Skill Audit selection criteria;
- full evaluation of every owned reference and template;
- report evidence and lifecycle judgments;
- escalation for broad routing, safety, responsibility, architecture, or migration effects;
- Skill Creator-specific finding priorities and preserved-behavior checks; and
- the `no change`, `research`, `defer`, or `proposal required` outcome vocabulary.

Refocus `references/audit-review-capability.md` on target-skill domain ownership.

**Retain**

- A capability test requiring recurring domain assessment, criteria that generic review would miss, and a clear reason not to rely only on a handoff.
- The target skill's responsibility for domain triggers, scope, evidence, criteria, priorities, terminology, judgment, recommendations, and assessment-versus-implementation boundaries.
- Proposal requirements that explain why domain assessment belongs to the target skill and what domain additions it makes to the shared workflow.
- Validation that unrelated requests do not activate assessment and that project-local conventions remain authoritative.

**Delegate to `audit-workflow`**

- Generic Review, Quick Review, and formal Audit structures.
- Finding layout, navigation, metadata, TOC, lifecycle, persistence, section ownership, and base templates.
- Generic distinctions between conversational Review and formal Audit.

Use the shared template by default. Propose a target-owned template only when recurring evidence proves that shared structure plus domain reference guidance is insufficient.

This resolves the metadata/TOC and duplicate-metadata reports without introducing another schema or template family.

### Centralize Decision-Record Mechanics

Delete Skill Creator's generic decision-record reference and template. Route record work to `decision-record` and pass the domain context it needs:

- decision question or confirmed outcome;
- skill-domain evidence and constraints;
- considered alternatives;
- consequences and compatibility effects;
- user or owner authority;
- source Audit, proposal, task, reports, and related decisions; and
- project-local conventions discovered by the repository workflow.

Delete `references/decision-record-capability.md`. Decisions can originate from many domains, and the shared skill already accepts domain context without requiring each origin skill to own a separate capability contract.

Keep one concise recommendation in the Skill Creator core: use `decision-record` when a target skill or skill change needs durable decision handling, and preserve domain evidence in the handoff. Do not add target-owned decision-record mechanics or templates by default.

No new decision record is proposed for this migration. Decisions `0025` and `0026` already establish the shared ownership, rejected alternatives, consequences, and deferred migration path.

### Resolve Usage Reports

After skill and link validation passes, update only `status` and `updated` in the four reports:

```yaml
status: implemented
updated: 2026-09-02
```

Preserve report bodies and filenames. The implementation evidence will be:

- reports `01` and `02`: shared metadata/TOC, lifecycle, section ownership, and non-duplication mechanics are loaded from `audit-workflow`, with Skill Creator references supplying domain guidance;
- report `03`: Review, Audit, and proposal base mechanics are owned by `audit-workflow` and conditionally referenced by Skill Creator; and
- report `04`: decision-record mechanics and fallback templates are owned by `decision-record`, with Skill Creator retaining domain context and a concise handoff recommendation.

If implementation validation cannot prove a report resolved, stop before changing that report's status and request narrower approval rather than recording partial completion as implemented.

## Source Material

- Approved Audit: [Audit Skill Creator Workflow Migration](../audit/audit-skill-creator-workflow-migration-260902-2051.md).
- Task: `tasks/003-migrate-skill-creator-workflows.md`.
- Usage reports:
    - [`report-20260829-skill-creator-01.md`](../../.agents/skill-usage-reports/skill-creator/report-20260829-skill-creator-01.md)
    - [`report-20260831-skill-creator-02.md`](../../.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-02.md)
    - [`report-20260831-skill-creator-03.md`](../../.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-03.md)
    - [`report-20260831-skill-creator-04.md`](../../.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-04.md)
- Shared-skill decisions:
    - [Audit Workflow Skill](../decisions/0025-audit-workflow-skill.md)
    - [Decision Record Skill](../decisions/0026-decision-record-skill.md)
- Existing Skill Creator decisions: `0004`, `0012`, `0015`, `0017`, and `0020` under `docs/decisions/`.
- Current Skill Creator core, references, templates, script, and shared-skill resources.
- Execution evidence: 15 Skill Creator Markdown files and 49 local links checked with no missing targets before proposal creation.

No external research is required. The migration is grounded in local accepted decisions, reports, tasks, and current implementations.

## Scope Boundaries

### In Scope

- Conditional routing to `audit-workflow` and `decision-record`.
- Skill Creator domain references and Audit/proposal capability tests.
- Removal of duplicated Skill Creator templates and decision-record resources.
- Metadata-only terminal transitions for the four reports after successful validation.
- Exact-path formatting and validation of approved files.

### Out of Scope

- Changes to `audit-workflow`, `decision-record`, `agents-maintainer`, global `AGENTS.md`, or other domain skills.
- New skills, templates, scripts, decisions, indexes, compatibility aliases, or runtime settings.
- Historical decision or proposal rewrites.
- Task `004` through `008` work.
- Commits or pushes.
- Runtime discovery claims without a fresh session.
- Proposal and task lifecycle updates beyond separately approved state transitions.

## Validation Plan

- Confirm every modified skill file remains inside the resolved agents repository and no symlink escapes exist.
- Validate Skill Creator frontmatter, name-directory agreement, description length, and explicit routing boundaries.
- Keep `SKILL.md` below 500 lines and report the final line count.
- Run the read-only Skill Creator link checker; require zero missing local links after both deletions.
- Search active resources for stale links to deleted Skill Creator decision-record files.
- Confirm deleted Skill Creator templates have no active links and retained references preserve domain-specific application and proposal preflight behavior.
- Reason through the matching, near-miss, and decision-trigger routing cases above; report fresh-session discovery as untested unless actually performed.
- Format only approved Markdown files with dprint, then run `dprint check`.
- Validate report metadata and confirm report bodies and filenames did not change.
- Run `git diff --check`, inspect exact diffs for every approved path, and confirm no unrelated Git-tracked paths changed.
- Run `taskmd validate`; do not run task-defined verification without separate command approval.
- Re-read the final proposal and task state before recording implementation completion.

## Decision Record

- Outcome: Not recommended.
- Path: None.

**Reason**

Decisions `0025` and `0026` already record the durable shared-workflow boundary, alternatives, consequences, and explicit deferral of Skill Creator migration. This proposal applies those accepted decisions without introducing a materially different policy.

## Approval Request

Proceed with these exact implementation file changes?

Keep this proposal at `status: proposed` during review. Record `approved` only after exact acceptance. Implement in a separate phase and record `implemented` only after validation.
