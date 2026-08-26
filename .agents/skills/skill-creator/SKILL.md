---
name: skill-creator
description: Use when creating, reviewing, updating, refactoring, or renaming agent skills and their references, scripts, or assets. Provides skill architecture, routing, progressive-disclosure, migration, and validation guidance.
---

# Skill Creator

Use this skill to design and maintain focused, discoverable, portable agent skills.

The goal is not to put every useful instruction into one file. The goal is to give the agent the right workflow at the right time while keeping optional detail available through progressive disclosure.

## Reference Files

Read only the references needed for the task:

| Reference                                                        | Read when                                                                                                |
| ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [references/skill-design.md](references/skill-design.md)         | Defining scope, frontmatter, routing, core structure, optional references, scripts, assets, or handoffs. |
| [references/skill-validation.md](references/skill-validation.md) | Reviewing, validating, migrating, or renaming a skill and its dependencies.                              |
| [references/review-format.md](references/review-format.md)       | Producing a normal or follow-up review of a skill and its supporting resources.                          |

Read both design and validation references for a new skill or substantial refactor. Read the review-format reference when operating in Review mode.

## When to Use

Use this skill when the user asks to:

- Create a global or project-local skill.
- Review a skill's scope, routing, structure, or maintainability.
- Update or refactor a skill and its references.
- Split an overloaded core into optional references.
- Rename or migrate a skill and update its dependencies.
- Add or review scripts, assets, templates, or validation guidance inside a skill.
- Diagnose skill discovery, frontmatter, naming, or reference problems.

Do not create a new skill merely because guidance could be written down. Prefer a skill when the method is reusable, domain-specific, and likely to improve future behavior.

## Skill Routing

Use complementary skills and preserve responsibility boundaries:

- Use `agents-maintainer` for approval, path safety, Git operations, and commits involving the global agents repository.
- Use `rubber-duck` when the skill's purpose, audience, or responsibility boundary is still uncertain.
- Use `researcher` when current external standards, upstream documentation, or competing implementations determine the design.
- Use `code-reviewer` for executable helper scripts, program logic, or configuration-as-code bundled with a skill.
- Use `tech-docs-reviewer` for a documentation-focused review of long human-facing references.
- Use `tech-docs-writer` when writing or formatting Markdown skill documentation.
- Use `task-manager` when an approved skill change needs persistent planning or tracked migration work.

`skill-creator` owns skill artifact quality. It does not replace repository approval, safety, or commit workflows.

## Operating Modes

Choose the mode that matches the request:

### Create

Define the skill's trigger, boundary, workflow, references, and validation before writing files.

### Review

Inspect the existing skill and dependencies. Report prioritized findings without editing unless the user asks for changes.

### Update

Improve an existing skill while preserving useful behavior and limiting scope to approved files.

### Rename

Treat the rename as a migration. Update the directory, frontmatter, routing dependencies, documentation references, and validation targets together.

A task can combine modes, but do not silently turn a review into an edit or a design discussion into implementation.

## Approval Gate

Before creating, modifying, moving, deleting, or reorganizing skill resources:

1. Explain the proposed change.
2. Explain the reasoning and trade-offs.
3. List every exact file to create, modify, move, or delete.
4. Identify external records or routing dependencies that may also need changes.
5. Wait for explicit user approval.

Approval applies only to the described scope. Pause if inspection reveals additional files or materially different behavior.

Use `agents-maintainer` for this gate when global repository resources are involved.

## Workflow

1. Identify whether the task is creation, review, update, rename, or a combination.
2. Read active project and global instructions.
3. Inspect the target skill, optional resources, repository state, and direct dependencies.
4. Read current harness documentation when discovery or frontmatter behavior matters.
5. Define the skill's responsibility boundary and routing relationships.
6. Decide what belongs in the always-loaded core and what should load from references.
7. Present the exact proposal and wait for approval before changing files.
8. Apply only approved changes, using targeted edits when practical.
9. Format Markdown and validate frontmatter, references, routing, migrations, and repository state.
10. Report changed files, validation, limitations, and anything not tested.
11. Commit only when the user explicitly asks and the responsible repository workflow permits it.

## Core Design Principles

- Make the frontmatter description specific enough to route correctly.
- Keep one clear primary responsibility per skill.
- Prefer the smallest workflow that reliably changes behavior.
- Keep safety-critical rules in the core even when they repeat higher-level policy deliberately.
- Put optional methods, long checklists, templates, and domain detail in references.
- Link references explicitly and state when to read them.
- Use relative paths within the skill directory.
- Keep scripts and assets inside the skill unless an intentional shared dependency is documented.
- Make response structures conditional rather than forcing unnecessary headings.
- Define handoffs so exploration, research, review, planning, and implementation do not blur together.
- Avoid duplicating active project or global instructions unless the duplication protects an important boundary.

Read [references/skill-design.md](references/skill-design.md) for detailed design guidance.

## Review Output

Read [references/review-format.md](references/review-format.md) before producing a normal or follow-up skill review.

Use concise numbered findings, scale the structure down for small reviews, and report no more than five highest-value findings unless the user requests an exhaustive review. Do not rewrite the skill during review mode.

## Validation

Read [references/skill-validation.md](references/skill-validation.md) before declaring a skill creation, substantial update, or rename complete.

At minimum, confirm:

- Frontmatter is valid and routing is specific.
- The portable skill name matches its directory.
- Referenced files exist and relative paths resolve.
- No stale name or routing references remain after a rename.
- Markdown is formatted.
- Only approved files changed.
- Runtime discovery limitations are reported when not tested.

## Default Response Shape

Use only the parts that help:

1. Overview, recommendation, or current state.
2. Main design decisions or findings.
3. Exact proposed or completed file changes.
4. Validation, limitations, and next decision.

Do not force headings onto a small answer.

## Tone

Be a practical skill-design partner:

- Prefer clear boundaries over clever abstractions.
- Explain trade-offs without over-engineering.
- Preserve useful existing behavior.
- Make migration impact visible.
- Keep reusable methodology in the skill rather than rediscovering it in every review.
