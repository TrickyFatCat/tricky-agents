# Skill Design

Read this reference when creating or substantially restructuring a skill.

A skill is a reusable capability package. Its core should establish when it applies and how behavior changes; optional resources should provide detail only when needed.

Use [../assets/skill-core-template.md](../assets/skill-core-template.md) when creating or substantially restructuring a core. Use [../assets/skill-reference-template.md](../assets/skill-reference-template.md) for focused optional references.

## Source Material

Ground skill work in concrete evidence when available:

- Hands-on task history.
- User corrections and preferences.
- Input/output formats.
- Existing project artifacts, runbooks, reports, and reviews.
- Failure cases and execution traces.
- External standards, such as Agent Skills, when relevant.

Do not synthesize a skill only from generic model knowledge when domain-specific context exists. Ask what source material is available when the answer can change the design.

## Define the Responsibility

Before naming or writing the skill, identify:

- The recurring task or decision it supports.
- The user requests that should activate it.
- The requests that belong to a different skill.
- The behavior that should change after the skill loads.
- Whether the workflow is advisory, state-changing, or both.
- Whether the skill is global, project-local, or package-provided.

Do not create a skill for one-off facts, project instructions already expressed clearly elsewhere, or a workflow too vague to route reliably.

## Frontmatter

A portable `SKILL.md` starts with YAML frontmatter:

```yaml
---
name: example-skill
description: Use when the user asks to perform the recurring task. Explain what the skill does and when it applies.
---
```

For a full starting shape, use [../assets/skill-core-template.md](../assets/skill-core-template.md).

### Name

Use a name that:

- Contains 1-64 lowercase letters, digits, or hyphens.
- Has no leading, trailing, or consecutive hyphens.
- Matches the parent directory for portability across Agent Skills implementations.
- Describes the capability rather than one narrow output format.

Some harnesses permit a directory mismatch, but matching is the safer shared convention.

### Description

The description is always visible during skill discovery, so treat it as routing logic.

A useful description:

- Uses imperative phrasing by default, such as `Use when...` or `Use this skill when...`.
- Says what the skill does.
- Says when to use it.
- Names distinctive triggers or artifacts.
- Describes user intent before implementation mechanics.
- Distinguishes adjacent skills when overlap is likely.
- Remains under the harness limit; Pi permits at most 1024 characters.

Do not put the full workflow, rationale, user benefits, implementation history, or motivational prose in the description. Make it a routing instruction, not a summary.

For substantial routing changes, sanity-check the description with at least one matching request and one near-miss boundary request when practical. Do not overfit the wording to a single test set.

### Optional Fields

Use optional frontmatter only when it serves a real requirement:

- `license`: license name or bundled license reference.
- `compatibility`: environment or runtime requirements.
- `metadata`: implementation-specific key-value information.
- `allowed-tools`: experimental pre-approved tool declaration when supported.
- `disable-model-invocation: true`: hide an explicit-only skill from automatic discovery.

Unknown fields may be ignored by the harness. Do not rely on them for critical behavior without verifying support.

## Scope and Routing

Give the skill one clear primary responsibility.

Document:

- Positive triggers: when to use the skill.
- Negative boundaries: what it should not do.
- Adjacent skills: when to combine, hand off, or stop.
- State boundaries: when review, research, or exploration may become implementation.

Prefer explicit handoffs over overlapping claims of ownership.

Examples:

- Exploration hands confirmed decisions to task management.
- Research provides evidence but does not silently implement.
- Artifact design hands repository operations to a maintainer.
- Script review hands documentation edits to a documentation writer when needed.

## Progressive Disclosure

The full `SKILL.md` loads when the skill activates. Keep always-needed routing, safety, and workflow there.

Move optional material into `references/` when it is:

- A detailed checklist.
- A specialized analysis lens.
- A long template or example.
- Relevant only to one operating mode.
- A protocol, command reference, or domain-specific method.

Use a reference table near the beginning of the core:

```markdown
## Reference Files

| Reference                                      | Read when                           |
| ---------------------------------------------- | ----------------------------------- |
| [references/example.md](references/example.md) | The task needs the optional method. |
```

State when to load a reference. Do not create references that the core never routes to.

Keep the main `SKILL.md` under 500 lines by default. Move detailed reference material, long templates, examples, and optional methods to `references/` or `assets/`. If exceeding 500 lines is justified, state why in the proposal or review.

Use the line count as a practical ceiling, not a substitute for judgment. Split a core when optional detail obscures routing, safety, or the default workflow.

## Core Structure

Use only sections that affect behavior. A practical structure is:

1. Purpose and goal.
2. Reference routing.
3. When to use and boundaries.
4. Skill routing or handoffs.
5. Operating modes or workflow.
6. Safety or approval requirements.
7. Default response guidance.
8. Validation and final reporting.

Do not copy this structure mechanically. A small skill may need only purpose, workflow, and validation.

## Instruction Design

Use this context-economy test for each instruction:

> Would the agent likely get this wrong, miss it, or waste time rediscovering it without this instruction?

If no, cut it or move it to an optional reference or asset. If yes and the agent needs it before recognizing the situation, keep it in the core.

Prefer instructions that are:

- Observable: the result can be inspected or verified.
- Conditional: detail appears only when relevant.
- Prioritized: safety and routing precede optional polish.
- Reversible: exploratory work does not become persistent state automatically.
- Specific: vague verbs are paired with criteria or expected evidence.

Useful patterns include:

- Lead with the instruction, answer, or current state.
- Use imperative verbs for required behavior.
- Keep paragraphs short and action-first.
- Keep rationale only when it changes a design, approval, or validation decision.
- Restate a request only when it resolves ambiguity.
- Ask only questions that can change the outcome.
- Use no more sections or metadata than the task needs.
- Preserve confirmed decisions without presenting recommendations as decisions.
- Stop when additional work is unlikely to change the result.

Avoid mandatory preambles, motivational prose, repeated rationale, fixed report structures for trivial tasks, exhaustive checklists applied mechanically, and instructions that duplicate the entire global policy.

## Calibrated Control

Match instruction strictness to task fragility:

- Be prescriptive for discovery, routing, approval, safety, naming, migration, path boundaries, scripts, and validation gates.
- Give the agent flexibility when several safe approaches can satisfy the goal.
- Provide a clear default path and mention alternatives briefly instead of presenting broad menus.
- Explain why a rule exists when context-dependent judgment matters.

## Task-to-Approach Tables

Use a task-to-approach table near the top of the core when the skill supports several common task types with different default methods. Keep it short and concrete.

```markdown
| Task        | Default approach                          |
| ----------- | ----------------------------------------- |
| <task type> | <tool, mode, or workflow to prefer first> |
```

Do not add a table when one workflow covers most requests.

## Gotchas

Use a `Gotchas` section only when non-obvious mistakes are likely and the agent may not recognize the trigger before reading an optional reference.

Good gotchas are concrete corrections from user feedback, failures, or project facts. Avoid generic reminders such as “handle errors carefully.”

## Safety and Approval

Keep safety-critical boundaries in the core.

For skills that can change files or state, define:

- What requires explicit approval.
- Which paths or systems are in scope.
- Which state is protected by default.
- What inspection happens before a change.
- How scope expansion is handled.
- Whether commits, deployments, or destructive operations need separate approval.

Project and global instructions remain authoritative. A skill can strengthen those boundaries but should not weaken them.

## Scripts

Add a script only when deterministic automation provides more value than instructions alone.

Before adding one:

- Explain why a script is preferable.
- Keep it inside the skill's `scripts/` directory.
- Use relative paths from the skill directory.
- Document inputs, outputs, dependencies, side effects, and failure behavior.
- Provide a non-destructive help, check, or dry-run path when practical.
- Review executable code with `code-reviewer`.

Do not add installers, daemons, hooks, or broad automation by default.

## Assets and Templates

Use `assets/` for files consumed or copied by the workflow rather than read as instructions.

Use semantic filenames that identify the artifact role, such as `skill-core-template.md` or `script-output-contract-template.md`. Reserve `README.md` for a real directory, package, or collection overview unless an external format requires it and the user approves the exception.

For saved proposal artifacts, use `<artifact-role>-<concise-subject>-<concise-action>`. Follow project filename style. Keep the role word once and first. Examples: `proposal-readable-output-examples-add.md`, `Proposal Artifact Naming Define.md`.

Keep templates minimal and adaptable. Tell the agent to omit irrelevant sections so templates do not become rigid checklists. Do not make one project's storage conventions the global default unless the skill is project-specific.

Current templates:

| Asset                                                                                        | Use                                          |
| -------------------------------------------------------------------------------------------- | -------------------------------------------- |
| [../assets/skill-core-template.md](../assets/skill-core-template.md)                         | Drafting or restructuring a `SKILL.md` core. |
| [../assets/skill-reference-template.md](../assets/skill-reference-template.md)               | Drafting focused optional references.        |
| [../assets/skill-change-proposal-template.md](../assets/skill-change-proposal-template.md)   | Preparing exact-file approval proposals.     |
| [../assets/skill-review-report-template.md](../assets/skill-review-report-template.md)       | Producing substantial skill reviews.         |
| [../assets/script-output-contract-template.md](../assets/script-output-contract-template.md) | Proposing or documenting bundled scripts.    |
| [../assets/decision-record-template.md](../assets/decision-record-template.md)               | Drafting skill decision records.             |

## Response Design

Define a small default response shape only when it improves consistency.

Make headings optional for small answers. Common useful elements are:

- Recommendation or current state.
- Main findings or decisions.
- Unknowns, risks, or blockers.
- Proposed or completed changes.
- Validation and next action.

When a skill produces three or more detailed findings, begin with a concise `Overview` of no more than three bullets. Include the finding count, highest-priority concern, and first recommended action when applicable. Reference numbered findings instead of repeating their evidence. For one or two findings, avoid a separate Overview when it would add visual noise without improving orientation.

Response design should help the user decide or act, not display every step the agent performed.

## Design Check

Before implementation, confirm:

1. The name and description route to the intended recurring task.
2. The skill has one primary responsibility.
3. Adjacent-skill handoffs are explicit.
4. Safety and approval boundaries remain in the core.
5. Optional details have clear reference-loading conditions.
6. Scripts or assets are justified and documented.
7. The response pattern scales down for small requests.
8. The proposed file list includes dependencies and migration records.
9. The proposal explains source material, artifact roles, semantic filenames, and `README.md` exceptions.
10. Substantial changes include a refinement plan: trial task, routing check, execution trace review, or a clear reason this was not tested.
