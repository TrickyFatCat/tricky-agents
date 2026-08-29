# Skill Change Proposal Template

Use this template before creating, modifying, moving, deleting, or reorganizing skill resources.

When saving a proposal artifact, use `<artifact-role>-<concise-action>-<concise-subject>`, following the active project's filename style. Keep the role word once and put it first. Example: `proposal-add-readable-output-examples.md`.

Write proposals in direct style: recommendation first, bullets over prose, rationale only when it changes the approval decision.

When the active workflow tracks saved proposals:

- follow its metadata syntax and storage rules;
- create the proposal with `status: proposed`;
- change it to `status: approved` only after the user accepts its exact scope;
- begin implementation only after that status update and in a separate implementation phase;
- change it to `status: implemented` only after validation;
- never create the proposal retrospectively or combine proposal preparation and implementation.

Do not require a saved proposal for unrelated trivial work unless the user, repository, or active project requires one.

````markdown
## Proposal Summary

- Decision requested: <exact approval decision>
- Files: <create/modify/move/delete counts>
- Behavior: <one-line effect>
- Main trade-off: <one-line trade-off>
- Status: Proposed

## Proposal

<One-sentence recommended change.>

## Source Material

Ground the proposal in concrete evidence:

- User request or correction:
- Audit outcome:
- Usage reports:
- Existing skill/task artifacts:
- Agent Skills or upstream references:
- Execution traces or trial runs:

## Reasoning

- Why this change is needed:
- What it improves:
- Main trade-off:
- Default approach chosen:
- Alternatives considered briefly:

## Examples

Use this section only when the proposal changes a reusable output pattern, command shape, audit format, or other concrete artifact pattern.

Good example:

```markdown
<small example that shows the preferred pattern>
```

Avoid this pattern, when a likely mistake needs contrast:

```markdown
<small counterexample or pattern to avoid>
```

Omit this section for routine wording edits, simple file moves, or conceptual recommendations where an example would add ceremony.

## Exact Files

### Create

| Path     | Artifact role | Naming rule or exception         |
| -------- | ------------- | -------------------------------- |
| `<path>` | `<role>`      | `<why this filename is correct>` |

### Modify

| Path     | Change      |
| -------- | ----------- |
| `<path>` | `<summary>` |

### Wording Changes

Use this section only for concrete wording edits where exact replacement text matters. Show old wording before new wording. Prefer vertical blocks, not a grid or table, because replacement text is often too long for horizontal scanning.

#### `<location>`

Old wording:

```markdown
<current wording>
```

New wording:

```markdown
<proposed wording>
```

### Move/Rename/Delete

| From     | To              | Reason and history impact |
| -------- | --------------- | ------------------------- |
| `<path>` | `<path or n/a>` | `<reason>`                |

Omit empty subsections.

## Scope Boundaries

In scope:

- <approved target>.

Out of scope:

- <nearby but excluded target>.

## Validation Plan

- Frontmatter/name checks:
- Description/routing checks, including matching and near-miss boundary prompts when practical:
- Main `SKILL.md` line count under 500, or exception rationale:
- Reference/link checks:
- Markdown formatting:
- Script tests or non-execution reason:
- Repository status/diff scope:
- Runtime discovery not tested/tested by:
- Follow-up trial or execution-trace review:

## Decision Record

- Outcome: Recommended | Not recommended
- Path: `docs/decisions/NNNN-<decision-slug>.md` | None

**Reason**

- <Final reason based on the exact proposal scope>.

## Approval Request

Proceed with these exact file changes?

For a tracked proposal, keep the status `proposed` during review. Record `approved` only after exact acceptance, and record `implemented` only after validation.
````
