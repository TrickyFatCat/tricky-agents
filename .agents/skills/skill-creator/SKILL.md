---
name: skill-creator
description: Use when creating, auditing, reviewing, updating, refactoring, or renaming agent skills and their references, scripts, or assets. Provides skill architecture, routing, progressive disclosure, domain assessment, migration, and validation guidance.
---

# Skill Creator

Use this skill to design and maintain focused, discoverable, portable agent skills.

Give the agent the right workflow at the right time. Keep always-needed behavior in the core and load optional detail only when relevant.

## Reference Files

Read only the references needed for the request:

| Reference                                                                      | Read when                                                                                                               |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| [references/skill-design.md](references/skill-design.md)                       | Defining scope, frontmatter, routing, progressive disclosure, references, scripts, assets, or handoffs.                 |
| [references/skill-validation.md](references/skill-validation.md)               | Reviewing, validating, migrating, or renaming a skill and its dependencies.                                             |
| [references/audit-format.md](references/audit-format.md)                       | Applying skill-domain criteria to a formal Skill Audit, Usage Report Audit, or substantial informal Review.             |
| [references/audit-review-capability.md](references/audit-review-capability.md) | Deciding whether a target skill should own domain-specific Audit or Review behavior.                                    |
| [references/proposal-capability.md](references/proposal-capability.md)         | Deciding whether a target skill should own domain-specific proposal behavior.                                           |
| [../../references/safety-inspection.md](../../references/safety-inspection.md) | Creating or substantially changing a skill with executable, sensitive, networked, credentialed, or high-impact effects. |

Read both design and validation references for a new skill or substantial refactor. Read capability references only when the target skill may own that behavior during normal use; do not load them merely because Skill Creator is auditing or proposing changes to the target.

## Shared Workflow Handoffs

Load shared workflow mechanics only when relevant:

| Shared skill                                     | Use                                                                                                                                                                                                   |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`audit-workflow`](../audit-workflow/SKILL.md)   | Use for shared Review, formal Audit, and proposal structure, lifecycle, persistence, templates, and approval-contract mechanics. Apply Skill Creator's domain references afterward.                   |
| [`decision-record`](../decision-record/SKILL.md) | Use for substantive decision-worthiness checks and all record structure, status, storage, supersession, traceability, and validation work. Pass skill-domain evidence and authority into the handoff. |

Skill Creator owns skill architecture, domain assessment, migration completeness, and artifact quality. It does not own shared artifact mechanics, repository approval, commits, or the user's decision.

## Available Script

Use the bundled script only when it fits the active request and approval scope. Read it before execution.

| Script                   | Use                                                            |
| ------------------------ | -------------------------------------------------------------- |
| `scripts/skill-audit.nu` | Read-only inventory and local Markdown-link checks for skills. |

Run it from the skill directory with Nushell and no user config:

```bash
nu -n scripts/skill-audit.nu inventory ~/.agents/skills --exclude nushell --format json
nu -n scripts/skill-audit.nu links ~/.agents/skills/skill-creator --format json
```

The script performs no writes, network access, installs, or fixes. Treat results as evidence, not edit approval. Its link checker ignores fenced code blocks but remains a lightweight Markdown regex check rather than a full parser.

## Template Assets

Use Skill Creator assets only for skill-specific resources:

| Asset                                                                                  | Use                                        |
| -------------------------------------------------------------------------------------- | ------------------------------------------ |
| [assets/skill-core-template.md](assets/skill-core-template.md)                         | Drafting or restructuring a skill core.    |
| [assets/skill-reference-template.md](assets/skill-reference-template.md)               | Drafting a focused optional reference.     |
| [assets/script-output-contract-template.md](assets/script-output-contract-template.md) | Proposing or documenting a bundled script. |

Use `audit-workflow` assets directly for Audits and proposals. Use `decision-record` assets according to project-local precedence for decision records.

## When to Use

Use this skill when the user asks to:

- Create a global or project-local skill.
- Audit or review a skill's scope, routing, structure, or maintainability.
- Update or refactor a skill and its references.
- Split an overloaded core into optional references.
- Rename or migrate a skill and update dependencies.
- Add or review scripts, assets, templates, or validation guidance inside a skill.
- Design or review domain-specific Audit, Review, or proposal behavior for a target skill.
- Diagnose skill discovery, frontmatter, naming, or reference problems.

Do not create a skill merely because guidance could be written down. Prefer a skill when the method is reusable, domain-specific, and likely to improve future behavior.

## Operating Modes

Choose the smallest mode that satisfies the request.

### Create

Define the skill's trigger, boundary, workflow, references, and validation before writing files.

### Audit

Pair with `audit-workflow`. Use `references/audit-format.md` for Skill Creator's domain scope, evidence, resource evaluation, report triage, findings, and outcomes.

For tracked skill changes, save and review the Audit before preparing a separate proposal. Audit approval does not authorize implementation.

### Review

Pair with `audit-workflow` for substantial Review mechanics. Keep ordinary critique and follow-up review conversational and unsaved unless the user or project requires persistence.

### Update

Improve an existing skill while preserving useful behavior and limiting edits to approved files.

### Rename

Treat a rename as a migration. Update the directory, frontmatter, routing dependencies, documentation references, and validation targets together.

For human-facing rename or move approval, show old values before new values. Compare basenames for renames and parent directories without filenames for moves. For combined operations, compare both, then show the resulting full path.

A task can combine modes, but do not silently turn assessment or design discussion into implementation.

## Approval Gate

Before creating, modifying, moving, deleting, or reorganizing skill resources:

1. Explain the proposed change.
2. Explain the reasoning and trade-offs.
3. List every exact file to create, modify, move, or delete.
4. Identify external records or routing dependencies that may also need changes.
5. Wait for explicit user approval.

Use `agents-maintainer` for this gate when global repository resources are involved. Approval applies only to the described scope; pause when inspection reveals additional files or materially different behavior.

## Safety Inspection

Read [../../references/safety-inspection.md](../../references/safety-inspection.md) when a skill can execute commands or scripts, access sensitive or externally controlled data, modify or delete state, use credentials or networks, or create high-impact effects.

Keep safety rules needed during normal use in the target skill's always-loaded core. Skip irrelevant optional capabilities and stop when a required effect lacks safe provenance, containment, or authorization.

## Workflow

1. Identify whether the task is creation, Audit, Review, update, rename, or capability design.
2. Read active project and global instructions.
3. Inspect the target skill, owned resources, repository state, and direct dependencies.
4. Use `scripts/skill-audit.nu` for bounded read-only inventory or link checking when useful.
5. Read current harness documentation when discovery or frontmatter behavior matters.
6. Define the skill's responsibility boundary and routing relationships.
7. Ground design in user corrections, real tasks, reports, project artifacts, execution traces, or external standards.
8. Decide what belongs in the always-loaded core and what should load from references or assets.
9. Assess target-skill Audit/Review and proposal capability independently; read the matching capability reference only when normal runtime behavior may own it.
10. Default decision-record behavior to a `decision-record` handoff rather than adding mechanics or templates to the target skill.
11. Perform the shared safety inspection when required.
12. For every skill task, report whether a decision record is recommended and why. Use `decision-record` for substantive assessment and all record work. Routine wording or formatting corrections may report `not recommended` without loading the full workflow.
13. Pair with `audit-workflow` for saved Audits and proposals. Apply `references/audit-format.md`, `references/skill-validation.md`, and the relevant capability reference as Skill Creator's domain additions.
14. For tracked changes, confirm the Audit was reviewed before preparing a proposal. Use the shared proposal template, preserve exact-file scope, and run the Skill Creator proposal preflight.
15. Revise the proposal during review. Record approval before editing and implement in a separate phase.
16. Apply only approved changes, format them, and validate frontmatter, references, routing, safety, migration completeness, and repository scope.
17. Report changes, validation, limitations, untested runtime behavior, and the decision-record outcome.
18. Commit only when the user explicitly asks and the repository workflow permits it.

## Core Design Principles

- Give each skill one clear primary responsibility.
- Make the frontmatter description specific enough to route correctly.
- Keep always-needed routing, safety, and approval rules in the core.
- Move optional methods, long checklists, and domain detail to references.
- Put copyable or pattern-matching skill resources in assets.
- Use shared artifact templates directly rather than maintaining local copies.
- Ground changes in real source material rather than generic model knowledge.
- Prefer the smallest workflow that reliably changes behavior.
- Use direct, imperative instructions and keep rationale only when it changes a decision.
- Preserve confirmed decisions without presenting recommendations as decisions.
- Define handoffs so exploration, research, assessment, planning, and implementation remain distinct.
- Avoid duplicating global or shared-skill instructions unless repetition protects a critical local boundary.

Read [references/skill-design.md](references/skill-design.md) for detailed design guidance.

## Audit and Review Output

Use `audit-workflow` for structure, lifecycle, persistence, finding layout, and templates. Use [references/audit-format.md](references/audit-format.md) for Skill Creator's mode selection, evidence, resource evaluation, report lifecycle, priorities, and outcome vocabulary.

A full Skill Audit evaluates every owned reference and template plus justified missing capability. A Usage Report Audit evaluates selected reports and every materially related resource while listing unrelated exclusions. Inventory and link counts support but do not replace qualitative evaluation.

## Validation

Read [references/skill-validation.md](references/skill-validation.md) before declaring a creation, substantial update, or rename complete.

At minimum, confirm:

- Frontmatter is valid and routing is specific.
- The portable skill name matches its directory.
- References exist, load conditionally, and resolve.
- Shared Audit/proposal/decision guidance is loaded only when relevant.
- Skill-domain criteria remain clear after shared handoffs.
- No stale names or links remain after deletion, rename, or migration.
- Markdown is formatted.
- Only approved files changed.
- High-capability skills expose normal-use safety boundaries in the core.
- Runtime discovery limitations are reported when not tested.

## Default Response Shape

Use only the parts that help:

1. Current state, recommendation, or finding.
2. Main design decisions or exact proposed changes.
3. Validation, limitations, and next decision.
4. Decision-record outcome and reason.

Do not force headings onto a small answer.

## Tone

Be a practical skill-design partner. Lead with the next action or decision, preserve useful behavior, make migration impact visible, and keep reusable methodology in the responsible skill.
