---
type: audit
status: reviewed
created: 2026-09-02
updated: 2026-09-02
audit_scope: skill-creator shared artifact workflow migration
---

# Audit Skill Creator Workflow Migration

<!--toc:start-->

- [Audit Summary](#audit-summary)
- [Scope and Evidence](#scope-and-evidence)
- [Skill Resource Evaluation](#skill-resource-evaluation)
    - [References](#references)
    - [Templates and Scripts](#templates-and-scripts)
- [Findings](#findings)
    - [Shared workflow duplication](#shared-workflow-duplication)
    - [Decision-record ownership](#decision-record-ownership)
    - [Skill-specific artifact contracts](#skill-specific-artifact-contracts)
    - [Report lifecycle traceability](#report-lifecycle-traceability)
- [Good Decisions](#good-decisions)
- [Decision Record](#decision-record)
- [Audit Outcome](#audit-outcome)
- [Untested Areas](#untested-areas)
- [Proposal Handoff](#proposal-handoff)

<!--toc:end-->

## Audit Summary

- Outcome: Proposal required.
- Findings: two high-priority migrations, one pass, and one medium-priority traceability gap.
- Main concern: Skill Creator still owns generic Audit, proposal, and decision-record mechanics now assigned to shared skills.
- Preserve: Skill architecture, capability assessment, skill-specific evidence, proposal preflight, and artifact validation.
- Next: Review this Audit before creating the exact-file migration proposal.

## Scope and Evidence

- **Audited:** Skill Creator core; all seven references; all seven template assets; the bundled audit script; shared `audit-workflow` and `decision-record` dependencies; four linked usage reports; related accepted decisions; and task `003`.
- **Sources:** Current repository files, decisions `0004`, `0012`, `0015`, `0017`, `0020`, `0025`, and `0026`, proposals for the two shared skills, tasks `001` through `003`, and the linked usage reports.
- **Method:** Complete source review, repository reference search, path-boundary inspection, line inventory, and the bundled read-only local-link check.
- **Excluded:** Other domain-skill migrations, historical artifact rewrites, runtime settings, commits, and implementation.
- **Validation evidence:** The Skill Creator link checker inspected 15 Markdown files and 49 local links with no missing targets. The target contains no symlinks, and all inspected resources resolve inside the agents repository.

## Skill Resource Evaluation

### References

| Reference                                  | Need                                                                             | Quality and writing                                                                                                                 | Audit result                                                                      |
| ------------------------------------------ | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `references/skill-design.md`               | Required for domain architecture and progressive disclosure.                     | Strong domain guidance; several artifact sections still name Skill Creator-owned generic templates and mechanics.                   | Retain and update handoffs.                                                       |
| `references/skill-validation.md`           | Required for domain validation and migration checks.                             | Strong skill checks; formal artifact checks partially duplicate shared workflow validation.                                         | Retain and narrow to domain checks plus dependency validation.                    |
| `references/audit-format.md`               | Required for Skill Audit criteria, resource evaluation, and usage-report scope.  | Domain criteria are valuable, but lifecycle, finding layout, section ownership, and proposal transition duplicate `audit-workflow`. | Retain as a domain overlay and remove generic mechanics.                          |
| `references/decision-records.md`           | No longer justified as a separate generic workflow.                              | Accurate but substantially duplicates `decision-record` triggers, statuses, storage, supersession, and validation.                  | Delete after moving the Skill Creator-specific trigger and handoff into the core. |
| `references/decision-record-capability.md` | Required to assess whether target skills need domain-specific decision behavior. | Useful capability test; generic record schema, statuses, storage, and lifecycle now belong to `decision-record`.                    | Retain and refocus on specialization versus shared handoff.                       |
| `references/audit-review-capability.md`    | Required to assess target-skill domain Review and Audit ownership.               | Useful domain capability test; generic Review/Audit structure and persistence duplicate `audit-workflow`.                           | Retain and refocus on domain criteria and template ownership.                     |
| `references/proposal-capability.md`        | Required to assess target-skill domain proposal ownership.                       | Useful domain capability test; generic proposal lifecycle and content contract duplicate `audit-workflow`.                          | Retain and refocus on domain responsibility and handoff.                          |

### Templates and Scripts

| Resource                                      | Need                                                                                  | Quality                                                                                        | Audit result                                                                     |
| --------------------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `assets/skill-core-template.md`               | Recurring skill creation justifies it.                                                | Strong Skill Creator-specific architecture and safety scaffold.                                | Retain.                                                                          |
| `assets/skill-reference-template.md`          | Recurring focused-reference creation justifies it.                                    | Direct and adaptable.                                                                          | Retain.                                                                          |
| `assets/script-output-contract-template.md`   | Fragile executable-helper contracts justify it.                                       | Strong domain-specific script design and safety shape.                                         | Retain.                                                                          |
| `assets/skill-audit-report-template.md`       | Full Skill Audits need resource and capability evaluation beyond the shared template. | Strong domain template; some generic mechanics can be delegated through its instructions.      | Retain as the stronger domain template and align with `audit-workflow`.          |
| `assets/skill-usage-report-audit-template.md` | Focused report audits need domain lifecycle and related-resource evaluation.          | Strong domain template; generic finding and lifecycle mechanics overlap the shared workflow.   | Retain as the stronger domain template and align with `audit-workflow`.          |
| `assets/skill-change-proposal-template.md`    | Skill changes need an exact-file contract and the established proposal preflight.     | Strong domain template; generic lifecycle and structure instructions overlap `audit-workflow`. | Retain the exact-file and preflight extensions while delegating the shared base. |
| `assets/decision-record-template.md`          | Not needed after the shared decision skill adoption.                                  | A valid lightweight template, but it competes with the shared MADR-based fallback.             | Delete and use `decision-record` project precedence and template selection.      |
| `scripts/skill-audit.nu`                      | Deterministic inventory and link checking justify it.                                 | Read-only, local, dependency-light, and correctly documented.                                  | Retain unchanged.                                                                |

No missing recurring Skill Creator-specific template capability was identified. The shared skills now supply generic Audit, proposal, and decision-record templates, while Skill Creator retains only stronger domain templates.

## Findings

1. [Shared workflow duplication](#shared-workflow-duplication) — 🔴 High
2. [Decision-record ownership](#decision-record-ownership) — 🔴 High
3. [Skill-specific artifact contracts](#skill-specific-artifact-contracts) — ✅ Pass
4. [Report lifecycle traceability](#report-lifecycle-traceability) — 🟡 Medium

### Shared Workflow Duplication

Priority: 🔴 High

**Evidence**

The core, `references/audit-format.md`, three capability references, and three skill-specific artifact templates repeat Review/Audit distinctions, finding structure, section ownership, proposal lifecycle, persistence, and approval-boundary mechanics now owned by `audit-workflow`.

**Why it matters**

Parallel ownership preserves the drift that `audit-workflow` was created to prevent and makes future shared-format changes require another Skill Creator edit.

**Recommended action**

Route Skill Creator's formal artifact work through `audit-workflow`, retain Skill Creator's domain criteria and stronger templates, and remove generic mechanics only where the shared contract is equivalent or stronger.

### Decision-Record Ownership

Priority: 🔴 High

**Evidence**

The core requires `references/decision-records.md` for every skill task, and that reference plus `assets/decision-record-template.md` independently defines worthiness, statuses, storage, supersession, traceability, and validation. These mechanics now belong to `decision-record`, whose fallback template intentionally uses MADR rather than Skill Creator's lightweight template.

**Why it matters**

Two active owners can select different templates and lifecycle behavior for the same skill-change decision record.

**Recommended action**

Keep the Skill Creator-specific requirement to assess every skill change and preserve exact-file approval integration, but hand worthiness, record structure, lifecycle, storage, supersession, and validation to `decision-record`. Delete the duplicated reference and template.

### Skill-Specific Artifact Contracts

Status: ✅ Pass

**Evidence**

Skill Creator adds domain behavior absent from the shared skills: whole-skill resource evaluation, usage-report escalation, target-skill capability tests, source-material checks, progressive-disclosure design, skill migration checks, exact-file skill proposal requirements, and proposal reviewability preflight.

Preserve these contracts and the three stronger skill-specific Audit/proposal templates. Do not replace them mechanically with generic shared assets.

### Report Lifecycle Traceability

Priority: 🟡 Medium

**Evidence**

All four source reports remain `open`. Tasks `001` and `002` and decisions `0025` and `0026` address the shared-skill creation portions, while task `003` tracks the remaining Skill Creator migration. The reports are cited but their final lifecycle states are not yet defined.

**Why it matters**

After migration, reports may continue to appear undecided despite direct implementation evidence.

**Recommended action**

Include the four report paths in the migration proposal and define evidence-based terminal status updates after implementation validation. Do not change report state during Audit review.

## Good Decisions

- Keep domain evidence and judgment with Skill Creator while shared skills own generic artifact mechanics.
- Preserve separate target-skill capability tests; a target skill may need domain Audit, proposal, or decision behavior independently.
- Preserve exact-file approval, proposal preflight, and separate implementation because shared templates do not replace repository authority.
- Keep the read-only audit script unchanged; it supports deterministic validation without owning judgment.
- Preserve historical decisions and artifacts rather than rewriting their chronology during migration.

## Decision Record

- Stage: Preliminary.
- Signal: Not recommended.

**Reason**

Accepted decisions `0025` and `0026` already establish the shared ownership and explicitly defer Skill Creator migration to this task. A new record would duplicate that durable rationale unless the proposal introduces a materially different boundary.

## Audit Outcome

- Outcome: Proposal required.
- Next: After user review, create a separate saved proposal with exact modifications, deletions, report transitions, and validation expectations.

## Untested Areas

- Fresh-session discovery and automatic cross-skill routing were not tested.
- No Skill Creator files or usage reports were modified.
- Markdown rendering was not tested outside repository source view.
- No implementation diff exists yet.

## Proposal Handoff

- **Candidate areas:** Skill Creator core; six retained references; three retained artifact templates; deletion of the duplicated decision-record reference and template; four usage-report lifecycle updates after validation.
- **Dependencies:** `audit-workflow`, `decision-record`, `agents-maintainer`, task `003`, and accepted decisions `0025` and `0026`.
- **Reports requiring traceability:** `report-20260829-skill-creator-01.md` and `report-20260831-skill-creator-02.md` through `04.md`.
- **Scope still to resolve:** Exact wording reductions, whether every retained template needs a direct shared-workflow note, and final report statuses based on the approved implementation boundary.
