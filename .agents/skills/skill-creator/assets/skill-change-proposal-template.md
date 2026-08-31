# Skill Change Proposal Template

Use this template before creating, modifying, moving, deleting, or reorganizing skill resources. Adapt it and omit sections that do not help.

When saving a proposal artifact, use `<artifact-role>-<concise-action>-<concise-subject>`, following the active project's filename style. Keep the role word once and put it first. Example: `proposal-add-readable-output-examples.md`.

Write proposals in direct, scannable style. Treat the proposal as an approval contract, not a complete implementation draft. Use short labeled lists for orientation and keep only approval-relevant evidence, wording, paths, and examples under the relevant action.

When the active workflow tracks saved proposals:

- follow its metadata syntax and storage rules;
- create the proposal with `status: proposed`;
- change it to `status: approved` only after the user accepts its exact scope;
- begin implementation only after that status update and in a separate implementation phase;
- change it to `status: implemented` only after validation;
- never create the proposal retrospectively or combine proposal preparation and implementation.

Do not require a saved proposal for unrelated trivial work unless the user, repository, or active project requires one.

````markdown
## Proposal Snapshot

Use no more than five orientation bullets.

- Decision requested: <exact approval decision>
- Files: <create/modify/move/delete counts>
- Behavior: <one-line effect>
- Main trade-off: <one-line trade-off>
- Status: Proposed

## Overview

**Change**

- <major change group>.
- <intended outcome>.

**Preserve**

- <important existing behavior>.
- <important boundary>.

## Reasoning

Use compact problem labels with one direct sentence each.

- **<Problem>:** <why the change is needed>.
- **<Impact>:** <what the selected change improves>.

## Recommended Approach

- <selected design or action>.
- <how it operates>.
- <important boundary>.

**Main trade-off:** <cost or limitation that affects approval>.

### Rejected Alternatives

Use only when rejected options affect the decision. Keep one short list.

- **<Alternative>:** <why it was not selected>.

## Actions

Link each action group and keep its description concise.

1. [<Action>](#action-anchor) — <concise purpose>.
2. [Confirm the exact file boundary](#exact-files) — <counts>.

### Exact Files

State that this list is the complete approval boundary and that additional targets require renewed approval.

**Create**

| Path     | Artifact role | Naming rule or exception         |
| -------- | ------------- | -------------------------------- |
| `<path>` | `<role>`      | `<why this filename is correct>` |

**Modify**

| Path     | Change      |
| -------- | ----------- |
| `<path>` | `<summary>` |

**Move, rename, or delete:** None.

Omit empty labels. For a rename or move, show old values before new values, compare changed components separately, and end with the resulting full path.

### <Detailed Action Group>

Describe the behavior, fields, boundaries, migration, validation, and trade-offs needed for informed approval. Link accepted Audit or research evidence instead of restating it. Do not draft an entire future resource unless its exact content is fragile or decision-relevant.

For concrete wording changes, show the current wording before the replacement. Prefer vertical blocks over a grid.

Old wording:

```markdown
<current wording>
```

New wording:

```markdown
<proposed wording>
```

Add a compact positive example only when it improves reviewability. Add an avoid example only for a likely mistake.

## Source Material

List the full evidence inventory after Actions:

- User request or correction:
- Audit outcome:
- Usage reports:
- Existing skill or task artifacts:
- Agent Skills or upstream references:
- Execution traces or trial runs:

## Scope Boundaries

### In Scope

- <approved target>.

### Out of Scope

- <nearby but excluded target>.

## Validation Plan

- Frontmatter and name checks:
- Description and routing checks, including a matching and near-miss request when practical:
- Main `SKILL.md` line count under 500, or exception rationale:
- Reference and link checks:
- Markdown formatting:
- Script tests or non-execution reason:
- Repository status and exact diff scope:
- Runtime discovery tested or explicitly untested:
- Follow-up trial or execution-trace review:

## Decision Record

- Outcome: Recommended | Not recommended
- Path: `docs/decisions/NNNN-<decision-slug>.md` | None

**Reason**

- <Final reason based on the exact proposal scope>.

## Approval Request

Proceed with these exact file changes?

For a tracked proposal, keep `status: proposed` during review. Record `approved` only after exact acceptance. Implement in a separate phase and record `implemented` only after validation.
````

## Proposal Preflight

### Approval-Content Coverage

Before requesting review, account for every exact file and action. Give each material decision one primary review location and classify the content it needs:

- concise behavior contract;
- current and proposed wording when exact replacement text affects approval;
- exact template, schema, or reusable output structure when shape affects approval;
- defaults, precedence, naming, migration, compatibility, safety, or validation detail; or
- a link to accepted evidence when the proposal needs only its implementation consequence.

Do not add a mandatory coverage grid to the human-facing proposal.

### Exact-Block Removal

For every exact wording, schema, template, example, or structure block, name the approval decision it can change. Remove or summarize the block when no scope, behavior, compatibility, safety, validation, migration, authority, or wording decision depends on it.

Then:

- remove source evidence already available through links;
- keep exact paths, artifact roles, naming, boundaries, migrations, and required validation;
- preserve full proposed structures for new reusable templates when metadata, section ownership, optionality, navigation, or duplication affects approval;
- omit optional sections that do not help the decision; and
- do not use artifact length as a pass/fail limit.
