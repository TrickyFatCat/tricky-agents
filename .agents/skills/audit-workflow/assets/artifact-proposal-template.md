# Artifact Proposal Template

Use this adaptable template for a saved proposal when no stronger domain or project template exists. Omit irrelevant sections. Preserve project-local storage, approval, and lifecycle rules.

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

Do not duplicate lifecycle status, dates, task IDs, or scope labels when frontmatter already makes them clear.

## Actions

Use `Verb object — purpose or approval effect`. Keep file scope in `File Changes` rather than presenting it as an action.

1. [Update target workflow](#update-target-workflow) — change the approved behavior.
2. [Create supporting artifacts](#create-supporting-artifacts) — add templates, references, or other approved resources.
3. [Create decision record](#create-decision-record) — record durable rationale when a decision record is in scope.

### Update Target Workflow

<Describe the behavior, boundaries, and trade-offs that affect approval. Show old wording before new wording when exact text changes approval.>

### Create Supporting Artifacts

<Describe created references, templates, scripts, or docs. Include naming examples, directory outlines, structured-data examples, or reusable-output shapes when they affect approval.>

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

**Move, rename, or delete:** None.

## Project Evidence

- <Report, audit, decision, existing source file, project documentation, or saved implementation evidence.>

## Scope Boundaries

### In Scope

- <Included work.>

### Out of Scope

- <Excluded nearby work, such as implementation, validation, commits, pushes, report status changes, or runtime state.>
```

## Final Pass

Before requesting review:

- confirm the proposal asks for a decision rather than reporting implementation;
- confirm lifecycle state is accurate for the proposal artifact;
- confirm file changes are complete and exact;
- remove source material that does not affect approval;
- remove exact wording, schema, or examples that cannot change approval;
- preserve project-local approval and storage rules;
- confirm implementation and validation are handed off to the owning workflow; and
- confirm links and TOC entries resolve in the target context.
