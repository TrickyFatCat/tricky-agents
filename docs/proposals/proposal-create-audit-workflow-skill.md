---
type: skill-change-proposal
title: "Create audit workflow skill"
status: implemented
task: "001"
created: 2026-09-01
updated: 2026-09-01
---

# Proposal: Create Audit Workflow Skill

## Proposal Snapshot

- Decision requested: create a new shared global skill named `audit-workflow`.
- Files in implementation scope: create 7 files; modify no existing skills in this task.
- Behavior: centralize reusable Review, Audit, and proposal mechanics without owning domain judgment.
- Main trade-off: shared consistency improves, but participating skills gain a cross-skill dependency.

## Overview

Create `audit-workflow`, a shared, non-domain skill for artifact workflow mechanics. The skill will provide separate Review, Audit, and proposal references, adaptable templates, and a recorded cross-skill decision.

Preserve domain ownership: domain skills keep evidence and judgment; Skill Creator keeps skill design; Agents Maintainer keeps repository approval and commits; Task Manager keeps persistent task tracking.

## Reasoning

- **Recurring format drift:** Usage reports show duplicated Review, Audit, proposal, metadata, table-of-contents, lifecycle, and section-ownership guidance across several skills.
- **Maintenance cost:** One shared correction currently requires parallel edits across domain skills.
- **Boundary risk:** Copying whole artifact workflows into every skill can blur Review, Audit, proposal, approval, and implementation.
- **Decision change:** Earlier decisions rejected a universal template; this proposal keeps domain evidence local while centralizing generic mechanics.

## Recommended Approach

Create `audit-workflow` with a compact core, three references, two adaptable template assets, and one decision record. Defer all existing-skill migrations to later tasks.

**Main trade-off:** Consumers gain a shared dependency and must preserve domain-specific evidence, authority, and templates.

### Rejected Alternatives

- **Keep guidance duplicated:** report evidence shows recurring drift.
- **Move domain criteria into the shared skill:** domain Audits need different evidence contracts.
- **Create only templates:** lifecycle, routing, handoff, persistence, and approval boundaries require instructions.
- **Migrate existing skills now:** dependent migrations should wait until the shared skill is approved.

## Actions

1. [Create the skill core](#create-the-skill-core) — routing, responsibility, modes, handoffs, and validation.
2. [Create Review and Audit references](#create-review-and-audit-references) — shared assessment workflow mechanics.
3. [Create proposal reference](#create-proposal-reference) — shared proposal lifecycle and approval mechanics.
4. [Create reusable artifact assets](#create-reusable-artifact-assets) — adaptable formal Audit and proposal templates.
5. [Create decision record](#create-decision-record) — record the durable cross-skill workflow decision.
6. [Confirm exact file boundary](#exact-files) — complete approval scope.

### Exact Files

This list is the complete implementation approval boundary. Additional targets require renewed approval.

**Create**

| Path                                                                 | Artifact role                  | Naming rule                                                                    |
| -------------------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------------------------ |
| `.agents/skills/audit-workflow/SKILL.md`                             | Skill core                     | Directory and frontmatter use the approved lowercase kebab-case skill name.    |
| `.agents/skills/audit-workflow/references/review.md`                 | Shared Review reference        | Semantic reference name describes the conversational Review mechanics it owns. |
| `.agents/skills/audit-workflow/references/audit.md`                  | Shared Audit reference         | Semantic reference name describes the formal Audit mechanics it owns.          |
| `.agents/skills/audit-workflow/references/proposals.md`              | Shared proposal reference      | Semantic reference name describes the proposal mechanics it owns.              |
| `.agents/skills/audit-workflow/assets/artifact-audit-template.md`    | Reusable formal Audit template | Asset name starts with artifact role and subject.                              |
| `.agents/skills/audit-workflow/assets/artifact-proposal-template.md` | Reusable proposal template     | Asset name starts with artifact role and subject.                              |
| `docs/decisions/0025-audit-workflow-skill.md`                        | Decision record                | Next numbered decision with semantic kebab-case slug.                          |

**Modify, move, rename, or delete:** None.

### Create the Skill Core

The proposed core should define these responsibilities.

#### Purpose

Own reusable artifact workflow mechanics for Reviews, Audits, and proposals.

#### Triggers

Activate for user requests involving reusable review/audit/proposal workflows, formal artifact structure, shared artifact templates, or cross-skill artifact handoffs.

#### Boundaries

Do not own domain judgment, implementation, repository approval, commits, pushes, or decision-record workflow. The skill may describe where a decision-record action belongs in a proposal, but the future decision skill owns record creation rules.

#### Modes

Support Quick Review guidance, formal Audit workflow, proposal workflow, migration support, and validation support.

#### Handoffs

Domain skills supply domain criteria. Skill Creator handles skill design. Agents Maintainer handles global repository approval and commits. Task Manager tracks follow-up work.

#### Persistence and Approval

Saved artifacts, source edits, approval, implementation, commits, and report status changes remain separate operations governed by project-local and repository rules.

#### Validation

Check relative links, template ownership, lifecycle boundaries, formatting, exact file scope, and runtime discovery reporting.

Proposed routing description:

```yaml
description: Use when designing, reviewing, or applying reusable Review, Audit, or proposal workflows, formats, templates, lifecycle rules, or cross-skill artifact handoffs. Provides shared artifact mechanics while domain skills keep domain-specific evidence, judgment, and implementation authority.
```

### Create Review and Audit References

The references should keep Review and Audit in separate files.

#### Review

Review is conversational and proportional. Recommended structure:

1. Start with a short orientation only for three or more findings.
2. Use one `Findings` section with numbered, descriptive finding headings.
3. Keep priority or status on a separate line, not in the heading.
4. Include evidence, rationale, and direction only when they help the reader decide.
5. Add `Good Decisions` only for specific behavior worth preserving.
6. Ask only questions whose answers can change a finding or next action.
7. End with one focused next step when useful.

Review should normally stay in chat unless the user or project requests persistence.

#### Audit

Audit is formal and saved when required. Recommended structure:

1. Use frontmatter and TOC markers for saved substantial Audits.
2. State scope, evidence, exclusions, and limitations explicitly.
3. Record findings with traceable evidence, rationale, and recommended action.
4. Preserve domain-specific criteria supplied by the active domain skill.
5. Provide a final judgment and handoff without approving implementation.
6. Run a section-ownership pass so evidence, rationale, limitations, and next steps are not repeated across sections.

It should use Skill Creator's current Review/Audit split and Tech Docs Reviewer's conversational Review structure as implementation patterns, but it should not define code, documentation, research, or skill-specific evidence criteria.

### Create Proposal Reference

The reference should own shared mechanics for:

- proposal versus implementation boundaries;
- exact approval scope;
- lifecycle states such as `proposed`, `approved`, `implemented`, `rejected`, `obsolete`, and `superseded` when a project tracks them;
- approval-content coverage and exact-block removal checks;
- action description format: `Verb object — purpose or approval effect`;
- `File Changes` placement after the action section;
- artifact roles, semantic filenames, naming exceptions, and path presentation;
- project evidence, rejected alternatives, scope boundaries, and validation plans; and
- preserving project-local storage and approval conventions.

It should not approve its own changes or replace Agents Maintainer's global-resource approval gate.

### Create Reusable Artifact Assets

Create adaptable templates with frontmatter examples. The templates should tell agents to omit irrelevant sections and prefer stronger domain or project-local contracts.

Audit template shape:

```markdown
---
type: audit
status: draft # draft | reviewed | final
created: YYYY-MM-DD
updated: YYYY-MM-DD
audit_scope: <bounded artifact, workflow, or resource set>
---

# <Audit Title>

<!--toc:start-->

- [Audit Summary](#audit-summary)
- [Scope](#scope)
- [Evidence](#evidence)
- [Findings](#findings)
- [Limitations](#limitations)

<!--toc:end-->

## Audit Summary

<Concise judgment. If a proposal is needed, state that it must be separate and reviewed before implementation. If no material concerns were found, say so directly.>

## Scope

- Audited:
- Excluded:

## Evidence

- Sources:
- Method:

## Findings

1. [<Finding title>](#finding-title) — 🔴 High | 🟡 Medium | 🟢 Low | ✅ Pass

### <Finding title>

Priority: 🔴 High

<Observed issue and source.>

**Rationale**

<Impact, risk, or maintenance cost.>

**Recommended action**

<Smallest useful direction without approving implementation.>

## Limitations

- <Evidence, runtime, renderer, or scope limit.>
```

Proposal template shape:

```markdown
---
type: proposal
status: proposed # proposed | approved | implemented | rejected | obsolete | superseded
created: YYYY-MM-DD
updated: YYYY-MM-DD
proposal_scope: <short scope>
---

# <Proposal Title>

<!--toc:start-->

- [Proposal Summary](#proposal-summary)
- [Actions](#actions)
- [File Changes](#file-changes)
- [Project Evidence](#project-evidence)
- [Scope Boundaries](#scope-boundaries)

<!--toc:end-->

## Proposal Summary

Summarize only the information a reviewer needs before reading actions:

- What will change.
- Why it is needed.
- What important behavior is preserved.
- Material trade-offs, if any.

## Actions

Use `Verb object — purpose or approval effect`. Keep file scope in `File Changes` rather than presenting it as an action.

1. [Update target workflow](#update-target-workflow) — change the approved behavior.
2. [Create supporting artifacts](#create-supporting-artifacts) — add templates, references, or other approved resources.
3. [Create decision record](#create-decision-record) — record durable rationale when a decision record is in scope.

### Update Target Workflow

<Describe the behavior, boundaries, and trade-offs that affect approval.>

### Create Supporting Artifacts

<Describe created references, templates, scripts, or docs.>

### Create Decision Record

<Include only when a decision record is in scope.>

## File Changes

This list is the complete approval boundary. Additional targets require renewed approval.

**Create**

| Path     | Artifact role | Naming rule |
| -------- | ------------- | ----------- |
| `<path>` | `<role>`      | `<reason>`  |

**Modify**

| Path     | Change      |
| -------- | ----------- |
| `<path>` | `<summary>` |

## Project Evidence

- <Report, audit, decision, existing source file, or other project artifact.>

## Scope Boundaries

### In Scope

- <Included work.>

### Out of Scope

- <Excluded nearby work.>
```

### Create Decision Record

Create `docs/decisions/0025-audit-workflow-skill.md` with status `Accepted` only after this proposal is approved and implementation completes the chosen behavior.

The record should explain:

- why a shared skill is now warranted despite earlier rejection of a universal template;
- which responsibilities move into `audit-workflow`;
- which responsibilities stay with domain skills, Skill Creator, Agents Maintainer, and Task Manager;
- consequences for later migration tasks.

## Source Material

- Task: [`tasks/001-create-audit-workflow-skill.md`](../../tasks/001-create-audit-workflow-skill.md)
- Usage report: [`skill-creator/report-20260831-skill-creator-03.md`](../../.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-03.md)
- Usage report: [`skill-creator/report-20260829-skill-creator-01.md`](../../.agents/skill-usage-reports/skill-creator/report-20260829-skill-creator-01.md)
- Usage report: [`agents-maintainer/report-20260830-agents-maintainer-01.md`](../../.agents/skill-usage-reports/agents-maintainer/report-20260830-agents-maintainer-01.md)
- Decision: [Skill Audit and Proposal Workflow](../decisions/0012-skill-audit-and-proposal-workflow.md)
- Decision: [Skill Artifact Assessment and Proposal Guidance](../decisions/0015-skill-artifact-assessment-and-proposal-guidance.md)
- Decision: [Skill Proposal Reviewability Preflight](../decisions/0020-skill-proposal-reviewability-preflight.md)
- Decision: [Domain Audit Section Ownership](../decisions/0022-domain-audit-section-ownership.md)
- Decision: [Skill Usage Report System and Interaction Rules](../decisions/0023-skill-usage-report-system-and-interaction-rules.md)

## Scope Boundaries

### In Scope

- Create the new `audit-workflow` global skill and its directly owned references and assets.
- Create the decision record documenting this new cross-skill workflow.
- Keep this proposal as the approval contract for Task 001.

### Out of Scope

- Migrating Skill Creator, Agents Maintainer, Tech Docs Reviewer, or Tech Docs Writer.
- Creating the separate decision-record skill.
- Changing global instructions, prompt templates, taskmd configuration, or usage report statuses.
- Committing, pushing, archiving, deleting, or moving existing resources.

## Validation Plan

- Frontmatter and name checks: confirm `name: audit-workflow`, directory match, valid YAML, and description length under Pi's 1024-character limit.
- Routing checks: test or reason through one matching request and one near-miss boundary request.
- Core size: keep `SKILL.md` under 500 lines or document the exception.
- Reference and link checks: confirm every linked reference and asset resolves from the skill directory.
- Markdown formatting: format changed Markdown with the approved formatter when available.
- Decision record checks: confirm path, title, status, date, source links, consequences, and related changes.
- Repository checks: run `git diff --check` and inspect exact diffs for approved paths.
- Runtime discovery: report untested unless a fresh Pi session or equivalent skill scan is used.

## Decision Record

- Outcome: Recommended
- Path: `docs/decisions/0025-audit-workflow-skill.md`

**Reason**

- This creates a new global skill.
- It changes cross-skill routing and artifact-workflow ownership.
- It establishes a shared contract that later migration tasks will depend on.
- It changes the practical consequence of earlier decisions that avoided shared universal templates.

## Approval Request

Proceed with these exact file changes?

Implementation completed and validated on 2026-09-01.
