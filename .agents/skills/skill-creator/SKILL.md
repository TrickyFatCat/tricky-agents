---
name: skill-creator
description: Use when creating, auditing, reviewing, updating, refactoring, or renaming agent skills and their references, scripts, assets, or decision records. Provides skill architecture, routing, progressive-disclosure, migration, decision-record, and validation guidance.
---

# Skill Creator

Use this skill to design and maintain focused, discoverable, portable agent skills.

The goal is not to put every useful instruction into one file. The goal is to give the agent the right workflow at the right time while keeping optional detail available through progressive disclosure.

## Reference Files

Read only the references needed for the task:

| Reference                                                                            | Read when                                                                                                                                                                    |
| ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [references/skill-design.md](references/skill-design.md)                             | Defining scope, frontmatter, routing, core structure, optional references, scripts, assets, or handoffs.                                                                     |
| [references/skill-validation.md](references/skill-validation.md)                     | Reviewing, validating, migrating, or renaming a skill and its dependencies.                                                                                                  |
| [references/audit-format.md](references/audit-format.md)                             | Producing a formal skill audit or an informal review of a skill and its supporting resources.                                                                                |
| [references/decision-records.md](references/decision-records.md)                     | Assessing, creating, or backfilling repository decision records that document skill changes.                                                                                 |
| [references/decision-record-capability.md](references/decision-record-capability.md) | Designing or reviewing a target skill that may create or manage decision records during normal use.                                                                          |
| [../../references/safety-inspection.md](../../references/safety-inspection.md)       | Creating, reviewing, or substantially changing a skill that can execute code, access sensitive or external data, use networks or credentials, or create high-impact effects. |

Read both design and validation references for a new skill or substantial refactor. Read the audit-format reference for a formal Audit or substantial informal Review. Read [references/decision-records.md](references/decision-records.md) for every skill task. Read [references/decision-record-capability.md](references/decision-record-capability.md) only when the target skill may create or manage decision records during normal use.

## Available Scripts

Use bundled scripts only when they fit the active request and approval scope. Prefer read-only checks before proposing changes.

| Script                   | Use                                                            |
| ------------------------ | -------------------------------------------------------------- |
| `scripts/skill-audit.nu` | Read-only inventory and local Markdown-link checks for skills. |

Run from the skill directory with Nushell and no user config:

```bash
nu -n scripts/skill-audit.nu inventory ~/.agents/skills --exclude nushell --format json
nu -n scripts/skill-audit.nu links ~/.agents/skills/skill-creator --format json
```

The script performs no writes, network access, installs, or fixes. Inventory output includes name, description, main-file line-count, reference, script, and asset checks. It emits JSON by default and supports `--format table` for quick inspection. Treat results as evidence for review, not as permission to edit.

Known limitation: the link checker ignores fenced code blocks but is still a lightweight Markdown regex check, not a full Markdown parser.

## Template Assets

Use assets as copyable or pattern-matching templates. Adapt them and omit irrelevant sections.

| Asset                                                                                  | Use                                          |
| -------------------------------------------------------------------------------------- | -------------------------------------------- |
| [assets/skill-core-template.md](assets/skill-core-template.md)                         | Drafting or restructuring a `SKILL.md` core. |
| [assets/skill-reference-template.md](assets/skill-reference-template.md)               | Drafting focused optional references.        |
| [assets/skill-change-proposal-template.md](assets/skill-change-proposal-template.md)   | Preparing exact-file approval proposals.     |
| [assets/skill-audit-report-template.md](assets/skill-audit-report-template.md)         | Producing substantial formal skill audits.   |
| [assets/script-output-contract-template.md](assets/script-output-contract-template.md) | Proposing or documenting bundled scripts.    |
| [assets/decision-record-template.md](assets/decision-record-template.md)               | Drafting skill decision records.             |

## When to Use

Use this skill when the user asks to:

- Create a global or project-local skill.
- Audit or review a skill's scope, routing, structure, or maintainability.
- Update or refactor a skill and its references.
- Split an overloaded core into optional references.
- Rename or migrate a skill and update its dependencies.
- Add or review scripts, assets, templates, or validation guidance inside a skill.
- Create or backfill a decision record that documents a skill change.
- Design or review decision-record capability for a target skill.
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

### Audit

For a tracked pre-change assessment, inspect the skill and dependencies, save a bounded audit, and record one outcome: `no change`, `research`, `defer`, or `proposal required`. Do not create the proposal until the user reviews the audit.

### Review

Use Review for informal critique or for user feedback on an audit, proposal, or implementation result. Do not create a persistent Audit artifact unless the request or tracked workflow requires one.

### Update

Improve an existing skill while preserving useful behavior and limiting scope to approved files.

### Rename

Treat the rename as a migration. Update the directory, frontmatter, routing dependencies, documentation references, and validation targets together.

### Decision Record

Assess, create, or backfill a concise record for a durable skill decision. A direct request makes the record mandatory, but repository approval and exact-file scope still apply.

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

## Safety Inspection

Read [../../references/safety-inspection.md](../../references/safety-inspection.md) when a skill can execute commands or scripts, access sensitive or externally controlled data, modify or delete state, use credentials or networks, or publish, deploy, install, or commit.

Use the inspection to identify trust boundaries, allowed effects, tool scope, approval, data handling, network destinations, stop conditions, validation, and supply-chain assumptions. Keep every safety rule needed during normal skill use in the skill's always-loaded `SKILL.md`; the shared reference guides design and review rather than replacing skill-specific boundaries.

Skip an irrelevant optional capability when the skill remains complete without it. Stop the design or review when a required unsafe effect, unresolved provenance, or missing authorization boundary prevents a safe artifact.

## Workflow

1. Identify whether the task is creation, audit, review, update, rename, decision record, or a combination.
2. Read active project and global instructions.
3. Inspect the target skill, optional resources, repository state, and direct dependencies.
4. Use `scripts/skill-audit.nu` for a bounded read-only inventory or local-link check when it can reduce manual inspection.
5. Read current harness documentation when discovery or frontmatter behavior matters.
6. Define the skill's responsibility boundary and routing relationships.
7. Ground the design in source material: user corrections, real tasks, reports, project artifacts, execution traces, or external standards when available.
8. Decide what belongs in the always-loaded core and what should load from references or assets. Read [references/decision-record-capability.md](references/decision-record-capability.md) when the target skill may create or manage decision records during normal use.
9. Perform the shared safety inspection when the skill has sensitive, executable, networked, state-changing, or high-impact capabilities.
10. Assess whether the current skill change needs its own repository decision record using [references/decision-records.md](references/decision-records.md). Always state why a record is or is not recommended.
11. If a record is recommended or directly requested, choose its exact path, include it in the approval scope, and create it with the approved skill changes. Do not make it an optional follow-up after approval.
12. For a tracked skill change, save and link the audit, let the user review it, and record its outcome before creating a proposal.
13. When the outcome is `proposal required`, create and link a separate proposal with `status: proposed` using [assets/skill-change-proposal-template.md](assets/skill-change-proposal-template.md).
14. Revise the saved proposal during user review. Record `status: approved` only after the user accepts its exact scope.
15. Before editing, confirm the tracked proposal exists, is linked, and is approved. Never create it retrospectively or combine proposal preparation and implementation in one step.
16. Apply only approved changes in a separate implementation step, using targeted edits when practical.
17. Format Markdown and validate frontmatter, references, routing, safety boundaries, migrations, decision records, and repository state. Then update the same proposal to `status: implemented`.
18. Report changed files, validation, limitations, anything not tested, and the decision-record outcome with its reason.
19. Commit only when the user explicitly asks and the responsible repository workflow permits it.

## Core Design Principles

- Make the frontmatter description specific enough to route correctly.
- Write skill and reference text as direct instructions: action first, imperative verbs, no motivational prose.
- Keep one clear primary responsibility per skill.
- Ground changes in real source material rather than generic model knowledge.
- Prefer the smallest workflow that reliably changes behavior.
- Keep safety-critical rules in the core even when they repeat higher-level policy deliberately.
- Put optional methods, long checklists, and domain detail in references.
- Put copyable or pattern-matching templates in assets.
- Link references and assets explicitly and state when to read or use them.
- Use relative paths within the skill directory.
- Keep scripts and assets inside the skill unless an intentional shared dependency is documented.
- Make response structures conditional rather than forcing unnecessary headings.
- Define handoffs so exploration, research, review, planning, and implementation do not blur together.
- Avoid duplicating active project or global instructions unless the duplication protects an important boundary.

Read [references/skill-design.md](references/skill-design.md) for detailed design guidance.

## Audit and Review Output

Read [references/audit-format.md](references/audit-format.md) before producing a formal skill audit or substantial informal review. Use [assets/skill-audit-report-template.md](assets/skill-audit-report-template.md) for substantial saved audits.

For a substantial audit, begin with an `Audit Summary` of no more than five short bullets and end with an explicit `Audit Outcome`. Use concise numbered findings and report no more than five highest-value findings unless the user requests an exhaustive audit.

For an informal Review, scale the response down and normally keep it conversational. Do not save a formal Audit artifact unless the request or tracked workflow requires one. Do not rewrite the skill during Audit or Review mode.

## Validation

Read [references/skill-validation.md](references/skill-validation.md) before declaring a skill creation, substantial update, or rename complete.

At minimum, confirm:

- Frontmatter is valid and routing is specific.
- The portable skill name matches its directory.
- Referenced files exist and relative paths resolve.
- No stale name or routing references remain after a rename.
- Markdown is formatted.
- Only approved files changed.
- High-capability skills expose their trust, authorization, data, network, stop, and validation boundaries in the always-loaded core.
- Runtime discovery limitations are reported when not tested.

## Default Response Shape

Use only the parts that help:

1. Overview, recommendation, or current state.
2. Main design decisions or findings.
3. Exact proposed or completed file changes.
4. Validation, limitations, and next decision.
5. Decision-record outcome and reason.

Do not force headings onto a small answer. The decision-record outcome may be one concise line rather than a separate section.

## Tone

Be a practical skill-design partner:

- Lead with the instruction, decision, or next action.
- Prefer clear boundaries over clever abstractions.
- Explain trade-offs only when they affect the decision.
- Preserve useful existing behavior.
- Make migration impact visible.
- Keep reusable methodology in the skill rather than rediscovering it in every review.
