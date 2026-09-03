---
type: skill-change-proposal
title: "Simplify skill routing guidance"
status: implemented
task: "003"
created: 2026-09-02
updated: 2026-09-02
---

# Proposal: Simplify Skill Routing Guidance

<!--toc:start-->

- [Proposal Summary](#proposal-summary)
- [Actions](#actions)
    - [Exact Files](#exact-files)
    - [Make Template Handoffs Optional](#make-template-handoffs-optional)
    - [Define Material Handoffs](#define-material-handoffs)
    - [Validate Routing Proportionality](#validate-routing-proportionality)
- [Project Evidence](#project-evidence)
- [Scope Boundaries](#scope-boundaries)
    - [In Scope](#in-scope)
    - [Out of Scope](#out-of-scope)
- [Validation Plan](#validation-plan)
- [Decision Record](#decision-record)
- [Approval Request](#approval-request)

<!--toc:end-->

## Proposal Summary

- Change Skill Creator guidance so handoffs appear only when they alter ownership, required workflow, approval, safety, or stopping behavior.
- Remove the core template's implication that every skill needs a dedicated routing catalog.
- Preserve explicit shared-workflow and repository handoffs when they materially affect correct behavior.
- Main trade-off: shorter cores rely more on global skill discovery, while necessary local boundaries must still remain explicit.

## Actions

1. [Make template handoffs optional](#make-template-handoffs-optional) — stop generated cores from listing generic helper skills.
2. [Define material handoffs](#define-material-handoffs) — distinguish ownership boundaries from optional collaboration.
3. [Validate routing proportionality](#validate-routing-proportionality) — catch repeated or unnecessary routing lists.
4. [Confirm the exact file boundary](#exact-files) — define the complete implementation scope.

### Exact Files

This list is the complete implementation approval boundary. Additional targets require renewed approval.

**Modify**

| Path                                                          | Change                                                                                                                   |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `.agents/skills/skill-creator/assets/skill-core-template.md`  | Replace the default `Skill Routing` catalog with an optional `Required Handoffs` section and explicit omission criteria. |
| `.agents/skills/skill-creator/references/skill-design.md`     | Define material handoffs and prohibit duplication of global skill-selection rules or nearby dedicated handoff sections.  |
| `.agents/skills/skill-creator/references/skill-validation.md` | Add proportionality checks for every named handoff and flag generic skill catalogs.                                      |

**Create, move, rename, or delete:** None.

### Make Template Handoffs Optional

The core template currently encourages a dedicated routing section even when global discovery or another core section already covers the relationship.

Current wording:

```markdown
## Skill Routing

Use complementary skills when another activity is primary:

- Use `<skill>` when <handoff condition>.
- Use `<skill>` when <handoff condition>.

`<this-skill>` owns <primary responsibility>. It does not replace <approval, safety, repository, research, review, or implementation boundary>.
```

Proposed wording:

```markdown
## Required Handoffs

Include this section only when another skill or workflow must participate to preserve ownership, approval, safety, or a required capability.

- Use `<skill-or-workflow>` when <material handoff condition>.

Do not list generic complementary skills merely because they could help. Omit this section when the reference table, approval section, shared-workflow section, or global rules already make every required handoff clear.
```

Also add one instruction near the template opening: omit routing and handoff sections that do not change behavior.

This keeps explicit handoffs available without treating a skill core as a catalog of the full skill registry.

### Define Material Handoffs

Update `skill-design.md` so a handoff belongs in a target skill only when it changes at least one of these:

- responsibility or implementation owner;
- required shared workflow or specialist capability;
- approval, safety, persistence, or repository authority;
- information that must cross the boundary; or
- a stopping or escalation condition.

Replace broad guidance that asks for adjacent skills by default.

Current pattern:

```markdown
- adjacent skills that own related work;
```

Proposed pattern:

```markdown
- material ownership overlaps or required handoffs that change execution;
```

Add these design rules:

- Do not list generic helper skills merely because they may be useful.
- Do not repeat handoffs already clear in global instructions, reference loading, approval sections, or a dedicated shared-workflow section.
- Prefer one local statement at the point where the handoff becomes necessary.
- Omit a routing section entirely when no material boundary remains unresolved.
- Keep a handoff explicit when removing it would blur ownership, approval, safety, required context transfer, or stop behavior.

Update the final design check to require material handoffs rather than an exhaustive adjacent-skill inventory.

### Validate Routing Proportionality

Extend the routing checks in `skill-validation.md`.

A named handoff passes only when it changes one or more of:

- ownership;
- required workflow;
- approval or safety behavior;
- necessary context transfer; or
- stopping and escalation behavior.

Add validation questions:

- Is each handoff required for correct behavior rather than merely helpful?
- Does the core duplicate a global skill-selection rule or another local section?
- Can a generic skill catalog be removed without losing an ownership or safety boundary?
- Is the handoff stated once, where the agent needs it?

Change the core validation language so it requires clear routing boundaries, not a dedicated routing section.

Routing examples:

- **Keep:** `agents-maintainer` for global skill approval because it changes repository authority.
- **Keep:** `audit-workflow` when entering formal Audit or proposal mode because it supplies a required shared contract.
- **Omit:** `task-manager` merely because a skill change might later be tracked.
- **Omit:** documentation or research skills merely because they could assist a task.
- **Keep conditionally:** a specialist when executable, external, or domain-specific work requires its distinct criteria.

## Project Evidence

- User review identified the newly migrated Skill Creator routing list as too complex and specifically questioned the value of its `task-manager` entry.
- The corrected [`SKILL.md`](../../.agents/skills/skill-creator/SKILL.md) remained complete after the entire generic routing section was removed.
- The current [`skill-core-template.md`](../../.agents/skills/skill-creator/assets/skill-core-template.md) still provides a default `Skill Routing` section with generic complementary-skill prompts.
- The current [`skill-design.md`](../../.agents/skills/skill-creator/references/skill-design.md) and [`skill-validation.md`](../../.agents/skills/skill-creator/references/skill-validation.md) require adjacent handoffs without testing their materiality.
- Reviewed migration Audit: [Audit Skill Creator Workflow Migration](../audit/audit-skill-creator-workflow-migration-260902-2051.md).
- Implemented migration proposal: [Migrate Skill Creator Workflows](proposal-migrate-skill-creator-workflows.md).

## Scope Boundaries

### In Scope

- Core-template guidance for required handoffs.
- Skill-design criteria for material routing boundaries.
- Validation checks that reject generic or repeated routing catalogs.
- Formatting and exact-path validation of the three approved files.

### Out of Scope

- Reintroducing a routing section to Skill Creator's own core.
- Changing global `AGENTS.md`, other skills, shared workflow skills, task-management behavior, or runtime settings.
- Renaming files or changing frontmatter.
- Rewriting historical decisions, Audits, proposals, or usage reports.
- Creating a decision record.
- Task completion, commits, or pushes.

## Validation Plan

- Format the three approved Markdown files with dprint and run `dprint check`.
- Run the Skill Creator local-link checker and require zero missing links.
- Confirm the core template marks `Required Handoffs` as optional and contains no generic complementary-skill instruction.
- Confirm design and validation guidance use the same materiality criteria.
- Reason through the five routing examples above.
- Search the changed files for stale `Skill Routing`, generic-catalog, and editorial-marker text.
- Run `git diff --check` and inspect exact diffs for the three approved paths.
- Run `taskmd validate`; do not run task-defined verification without separate approval.
- Report fresh-session routing as untested unless it is actually exercised.

## Decision Record

- Outcome: Not recommended.
- Path: None.

**Reason**

The change applies existing context-economy and responsibility-boundary principles to routing guidance. It does not establish a new skill responsibility, shared workflow, or compatibility contract.

## Approval Request

Proceed with these exact three file modifications?

Keep this proposal at `status: proposed` during review. Record `approved` only after exact acceptance, implement separately, and record `implemented` only after validation.
