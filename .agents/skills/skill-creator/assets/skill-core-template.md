# Skill Core Template

Use this template when creating or substantially restructuring a `SKILL.md` core.

Adapt it. Omit sections that do not change behavior. Keep safety-critical rules in the core. Keep the main `SKILL.md` under 500 lines by default; move long detail to references or assets.

## Source Material Check

Before writing, gather concrete context:

- hands-on task history;
- user corrections and preferences;
- input/output formats;
- existing project artifacts, runbooks, reports, and reviews;
- failure cases or execution traces.

Do not synthesize a skill only from generic model knowledge when domain-specific context exists.

## Template

```markdown
---
name: <skill-name>
description: Use when <activation context>. <What the skill does, user intents it handles, and distinctive artifacts or decisions it covers>.
# compatibility: <Only when real runtime, tool, product, network, or environment requirements exist. Most skills do not need this.>
---

# <Skill Title>

Use this skill to <recurring capability>.

The goal is <what improves when this skill loads>.

## Frontmatter Requirements

Keep these constraints satisfied:

- `name` is required.
- `name` is 1-64 characters.
- `name` uses lowercase letters, digits, and hyphens only.
- `name` does not start or end with a hyphen.
- `name` has no consecutive hyphens.
- `name` matches the parent directory.
- `description` is required.
- `description` is 1-1024 characters.
- `description` uses imperative phrasing by default, such as `Use when...` or `Use this skill when...`.
- `description` explains what the skill does and when to use it.
- `description` describes user intent before implementation mechanics.
- `description` includes specific routing keywords.
- For substantial routing changes, test or reason through one matching request and one near-miss boundary request.
- `compatibility` is optional; most skills do not need it.
- If `compatibility` is present, keep it 1-500 characters and tied to real environment requirements.

## Reference Files

Read only the references needed for the task:

| Reference                                      | Read when                  |
| ---------------------------------------------- | -------------------------- |
| [references/<topic>.md](references/<topic>.md) | <specific load condition>. |

## Available Scripts

Use scripts only when they fit the active request and approval scope.

| Script                  | Use                                                                  |
| ----------------------- | -------------------------------------------------------------------- |
| `scripts/<script-name>` | <read-only check, generation, validation, or other bounded purpose>. |

State if the skill has no scripts, or omit this section.

## When to Use

Use this skill when the user asks to:

- <trigger 1>.
- <trigger 2>.
- <trigger 3>.

Do not use this skill for <negative boundary>. Route or hand off instead.

## Common Tasks

Include this table only when the skill has several common task types with different default approaches.

| Task        | Default approach                          |
| ----------- | ----------------------------------------- |
| <task type> | <tool, mode, or workflow to prefer first> |

Omit this section when one workflow covers most requests.

## Skill Routing

Use complementary skills when another activity is primary:

- Use `<skill>` when <handoff condition>.
- Use `<skill>` when <handoff condition>.

`<this-skill>` owns <primary responsibility>. It does not replace <approval, safety, repository, research, review, or implementation boundary>.

## Operating Modes

Choose the smallest mode that satisfies the request.

### <Mode>

<Behavior, boundary, and output for this mode.>

### <Mode>

<Behavior, boundary, and output for this mode.>

## Gotchas

Use this section only for non-obvious mistakes the agent is likely to make without seeing the warning in the core.

- <Concrete correction or edge case>.

Omit this section when there are no recurring gotchas.

## Approval and Safety

Before creating, modifying, moving, deleting, executing, transmitting, installing, or committing anything in this skill's scope:

1. Explain the proposed change or effect.
2. Explain the reasoning and trade-offs.
3. List exact files, paths, commands, destinations, or records affected.
4. Wait for explicit user approval when active instructions require it.

Approval applies only to the described scope. Pause when scope or effect changes materially.

## Workflow

1. Identify the task mode and boundaries.
2. Read active project/global instructions and only the needed references.
3. Inspect current state with read-only commands first.
4. Use bounded helper scripts only when they reduce uncertainty.
5. Add what the agent would otherwise get wrong; omit what it already knows.
6. Preserve confirmed decisions and distinguish assumptions.
7. Be prescriptive for fragile safety, approval, naming, or migration steps.
8. Give flexibility where multiple safe approaches are valid.
9. Present a proposal before state-changing work.
10. Apply only approved changes.
11. Validate the result with artifact-specific checks.
12. Report changes, validation, limitations, and next action.

## Validation

Before declaring the task complete, confirm:

- <artifact-specific validation>.
- Frontmatter constraints are satisfied.
- References and links resolve.
- Markdown or code formatting is checked.
- Only approved files or state changed.
- Full home paths are not exposed in human-facing output unless justified.
- For substantial skill changes, one matching request and one boundary request were tested, or runtime routing was reported as not tested.
- Execution traces, user corrections, or trial tasks were considered when available.
- Runtime/discovery behavior is reported as tested or not tested.

## Default Response Shape

Use only the parts that help:

1. Current state or recommendation.
2. Main findings, decisions, or proposal.
3. Exact changes or next action.
4. Validation and limitations.

Do not force headings onto a small answer.

## Tone

Be <style>. Lead with the current state or next action. Prefer concrete defaults over broad menus. Keep paragraphs short and action-first. Group long lists into must/optional or now/later.
```
