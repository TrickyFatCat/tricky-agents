---
type: skill-change-proposal
title: "Create decision skill"
status: implemented
task: "002"
created: 2026-09-02
updated: 2026-09-02
---

# Proposal: Create Decision Skill

## Proposal Snapshot

- Decision requested: create a new shared global skill named `decision-record`.
- Files in implementation scope: create 5 files; modify no existing skills in this task.
- Behavior: centralize reusable decision-record and ADR mechanics without deciding on behalf of domain workflows.
- Main trade-off: decisions become more consistent, but domain skills must hand over enough context instead of recording decisions ad hoc.

## Overview

Create `decision-record`, a shared, non-domain skill for durable decision-record mechanics. The skill will provide decision-worthiness checks, lifecycle/status guidance, storage and naming precedence, supersession rules, validation checks, and one adaptable decision-record template.

Preserve domain ownership: originating skills and users decide the actual domain outcome; this skill records confirmed decisions and manages record mechanics.

## Reasoning

- **Cross-domain decisions:** Decisions can originate from research, design, review, task management, implementation planning, or ordinary conversation.
- **Duplication risk:** Implementing ADR/status/storage/supersession rules in every skill creates drift and conflicting behavior.
- **Approval boundary:** Recommendations, exploration, accepted decisions, persistence, and implementation need separate handling.
- **Project-local authority:** Repositories and vaults already have decision conventions; the shared skill should follow those before fallback defaults.

## Recommended Approach

Create `decision-record` with a compact core, one detailed reference, one adaptable template asset, and one decision record. Defer migrating Skill Creator or other skills to later tasks.

**Main trade-off:** A shared record owner reduces duplication, but origin workflows must provide decision context clearly enough for the record to remain accurate.

### Rejected Alternatives

- **Keep decision rules inside every domain skill:** likely to duplicate status, storage, naming, and supersession behavior.
- **Let the skill decide domain outcomes:** rejected because the user or domain workflow owns decisions; this skill records and validates them.
- **Use `docs/adr/` as the universal fallback:** rejected because ADR implies architecture-only records in some projects.
- **Migrate existing skill guidance now:** dependent migrations should wait until the shared skill is approved and validated.

## Actions

1. [Create the skill core](#create-the-skill-core) — routing, boundaries, operating modes, persistence, and validation.
2. [Create decision-record reference](#create-decision-record-reference) — triggers, content contract, status, storage, supersession, and validation.
3. [Create template asset](#create-template-asset) — adaptable decision-record structure.
4. [Create decision record](#create-decision-record) — record the durable cross-skill workflow decision.
5. [Confirm exact file boundary](#exact-files) — complete implementation scope.

### Exact Files

This list is the complete implementation approval boundary. Additional targets require renewed approval.

**Create**

| Path                                                                | Artifact role                      | Naming rule                                                                 |
| ------------------------------------------------------------------- | ---------------------------------- | --------------------------------------------------------------------------- |
| `.agents/skills/decision-record/SKILL.md`                           | Skill core                         | Directory and frontmatter use the approved lowercase kebab-case skill name. |
| `.agents/skills/decision-record/references/decision-records.md`     | Decision-record workflow reference | Semantic reference name describes the record mechanics it owns.             |
| `.agents/skills/decision-record/assets/decision-record-template.md` | Reusable decision-record template  | Asset name starts with artifact subject and role.                           |
| `.agents/skills/decision-record/assets/LICENSE.md`                  | Third-party template license note  | Conventional license filename scoped to the copied template asset.          |
| `docs/decisions/0026-decision-record-skill.md`                      | Decision record                    | Next numbered decision with semantic kebab-case slug.                       |

**Modify, move, rename, or delete:** None.

### Create the Skill Core

The proposed core should define these responsibilities.

#### Purpose

Own reusable decision-record and ADR mechanics for confirmed durable decisions.

#### Triggers

Activate for user requests to create, review, update, link, supersede, or validate a decision record, ADR, decision log entry, or durable decision artifact.

#### Boundaries

Do not decide on the user's behalf, turn recommendations into accepted decisions, implement decisions, approve changes, commit files, or replace project-local decision conventions.

#### Modes

Support decision-worthiness check, draft record, review record, update record, supersede record, and validate record modes.

#### Context Handoff

Origin workflows must provide the chosen decision or unresolved decision question, alternatives considered, reasons, consequences, authority, source evidence, and relevant project conventions.

#### Persistence and Approval

Creating or changing a persistent decision record requires user or project approval. Project-local storage, naming, status vocabulary, metadata, linking, and validation rules take precedence.

Proposed routing description:

```yaml
description: Use when evaluating, drafting, reviewing, updating, linking, superseding, or validating durable decision records, ADRs, decision logs, statuses, storage conventions, or decision traceability. Provides shared record mechanics while users and domain workflows own the actual decision and implementation authority.
```

### Create Decision-Record Reference

The reference should own shared mechanics for:

- deciding whether a choice is record-worthy;
- separating exploration, recommendation, confirmed decision, persistence, and implementation;
- required record concepts: title, status, date, context and problem statement, decision outcome, reasons, and consequences;
- optional concepts: type, decision drivers, considered options, assumptions, constraints, deciders, sources, related decisions, supersession links, review date, and related changes;
- status behavior, including `Proposed`, `Accepted`, `Rejected`, `Superseded`, and `Deprecated` as fallback states;
- storage precedence and fallback layout;
- superseding an existing record with reciprocal links and status updates; and
- record validation.

Storage precedence:

1. User-provided destination.
2. Project-local rules or established repository/vault convention.
3. `<project>/docs/decisions/`.
4. If no project context exists, ask the user where to save the record.

Fallback naming:

- Use `NNNN-<decision-slug>.md` when the repository has numbered decisions or no stronger convention exists.
- Use `decision-<concise-subject>-<yymmdd-hhmm>.md` only when the project does not use numbered records and chronology-in-filename is clearer.
- Use `docs/adr/` only for architecture-specific ADR conventions.
- Keep filenames stable after acceptance unless a supersession or approved rename changes them.

It should not define domain-specific decision criteria or force one repository metadata syntax.

### Create Template Asset

Use the full MADR decision-record template as the default fallback when no stronger project convention exists. Do not create a separate light template now; MADR's optional sections already provide enough flexibility. Future specialized templates, such as Design Decision Record templates with `Unknowns`, require separate evidence and proposal work.

Template shape:

```markdown
# [short title of solved problem and solution]

- Status: [proposed | rejected | accepted | deprecated | … | superseded by [ADR-0005](0005-example.md)] <!-- optional -->
- Deciders: [list everyone involved in the decision] <!-- optional -->
- Date: [YYYY-MM-DD when the decision was last updated] <!-- optional -->

Technical Story: [description | ticket/issue URL] <!-- optional -->

## Context and Problem Statement

[Describe the context and problem statement, e.g., in free form using two to three sentences. You may want to articulate the problem in form of a question.]

## Decision Drivers <!-- optional -->

- [driver 1, e.g., a force, facing concern, …]
- [driver 2, e.g., a force, facing concern, …]
- … <!-- numbers of drivers can vary -->

## Considered Options

- [option 1]
- [option 2]
- [option 3]
- … <!-- numbers of options can vary -->

## Decision Outcome

Chosen option: "[option 1]", because [justification. e.g., only option, which meets k.o. criterion decision driver | which resolves force force | … | comes out best (see below)].

### Positive Consequences <!-- optional -->

- [e.g., improvement of quality attribute satisfaction, follow-up decisions required, …]
- …

### Negative Consequences <!-- optional -->

- [e.g., compromising quality attribute, follow-up decisions required, …]
- …

## Pros and Cons of the Options <!-- optional -->

### [option 1]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

### [option 2]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

### [option 3]

[example | description | pointer to more information | …] <!-- optional -->

- Good, because [argument a]
- Good, because [argument b]
- Bad, because [argument c]
- … <!-- numbers of pros and cons can vary -->

## Links <!-- optional -->

- [Link type] [Link to ADR] <!-- example: Refined by [ADR-0005](0005-example.md) -->
- … <!-- numbers of links can vary -->
```

The template asset should preserve the MADR structure, cite the source, link to the scoped template license note, and add only wrapper guidance required for this skill: follow project-local formats first, omit optional sections when empty, do not mark an agent recommendation accepted without confirmation, and avoid migrating metadata solely to normalize style.

### Create Decision Record

Create `docs/decisions/0026-decision-record-skill.md` with status `Accepted` only after this proposal is approved and implementation completes the chosen behavior.

The record should explain:

- why a separate decision-record skill is warranted;
- which responsibilities move into `decision-record`;
- which responsibilities stay with users, domain workflows, Skill Creator, Agents Maintainer, and Task Manager;
- fallback storage/status choices; and
- consequences for later migration tasks.

## Source Material

- Usage report: [`skill-creator/report-20260831-skill-creator-04.md`](../../.agents/skill-usage-reports/skill-creator/report-20260831-skill-creator-04.md)
- Decision: [Skill Decision Record Workflow](../decisions/0004-skill-decision-record-workflow.md)
- Decision: [Skill Decision Record Capability Boundary](../decisions/0011-skill-decision-record-capability-boundary.md)
- Decision: [Skill Artifact Assessment and Proposal Guidance](../decisions/0015-skill-artifact-assessment-and-proposal-guidance.md)
- Decision: [Audit Workflow Skill](../decisions/0025-audit-workflow-skill.md)
- Current Skill Creator capability guidance: `.agents/skills/skill-creator/references/decision-record-capability.md`
- Current Skill Creator record guidance: `.agents/skills/skill-creator/references/decision-records.md`
- External template reference: [MADR decision record template](https://github.com/architecture-decision-record/architecture-decision-record/blob/main/locales/en/templates/decision-record-template-of-the-madr-project)

## Scope Boundaries

### In Scope

- Create the new `decision-record` global skill and its directly owned reference and asset.
- Create the decision record documenting this new cross-skill decision-record workflow.
- Keep this proposal as the approval contract for Task 002.

### Out of Scope

- Migrating Skill Creator, Agents Maintainer, Audit Workflow, or other domain skills.
- Creating, superseding, or rewriting existing historical decision records beyond `0026`.
- Changing global instructions, prompt templates, taskmd configuration, or usage report statuses.
- Implementing decisions recorded by the new skill.
- Committing, pushing, archiving, deleting, or moving existing resources.

## Validation Plan

- Frontmatter and name checks: confirm `name: decision-record`, directory match, valid YAML, and description length under Pi's 1024-character limit.
- Routing checks: test or reason through one matching request and one near-miss boundary request.
- Core size: keep `SKILL.md` under 500 lines or document the exception.
- Reference and link checks: confirm every linked reference and asset resolves from the skill directory.
- Markdown formatting: format changed Markdown with the approved formatter when available.
- Decision record checks: confirm path, title, status, date, source links, consequences, and related changes.
- Repository checks: run `git diff --check` and inspect exact diffs for approved paths.
- Runtime discovery: report untested unless a fresh Pi session or equivalent skill scan is used.

## Decision Record

- Outcome: Recommended
- Path: `docs/decisions/0026-decision-record-skill.md`

**Reason**

- This creates a new global skill.
- It changes cross-skill routing and decision-record ownership.
- It establishes a shared contract that later migration tasks will depend on.
- It preserves project-local decision conventions while providing fallback mechanics.

## Approval Request

Proceed with these exact file changes?

Approved on 2026-09-02. Implemented on 2026-09-02 within the approved file scope, including the later approved scoped template license note.
