# Skill Design

Read this reference when creating or substantially restructuring a skill.

A skill is a reusable capability package. Its core establishes when it applies and how behavior changes; optional resources provide detail only when needed.

Use [../assets/skill-core-template.md](../assets/skill-core-template.md) for a new or substantially restructured core. Use [../assets/skill-reference-template.md](../assets/skill-reference-template.md) for focused optional guidance.

## Source Material

Ground skill work in concrete evidence when available:

- hands-on task history;
- user corrections and preferences;
- existing project artifacts, runbooks, reports, and reviews;
- input and output formats;
- failure cases and execution traces; and
- external standards when relevant.

Do not synthesize a skill only from generic model knowledge when domain-specific context exists.

## Define the Responsibility

Before naming or writing the skill, identify:

- the recurring task or decision it supports;
- requests that should and should not activate it;
- behavior that should change after loading;
- material ownership overlaps or required handoffs that change execution;
- whether it advises, assesses, or changes state; and
- whether it is global, project-local, or package-provided.

Do not create a skill for one-off facts, clear project instructions already expressed elsewhere, or a workflow too vague to route reliably.

## Shared Artifact Responsibilities

Use shared skills as the default for reusable artifact mechanics:

- Use `audit-workflow` for Review, Audit, and proposal structure, lifecycle, persistence, and base templates.
- Use `decision-record` for decision-worthiness, record structure, status, storage, supersession, traceability, and validation.
- Keep domain evidence, criteria, judgment, recommendations, and implementation with their responsible domain workflows.

Read [audit-review-capability.md](audit-review-capability.md) only when deciding whether recurring domain assessment belongs in a target skill. Read [proposal-capability.md](proposal-capability.md) only when deciding whether the target skill should own domain proposal behavior.

Do not add target-owned artifact templates merely because Skill Creator used an Audit or proposal while changing the target. Use shared templates directly unless recurring evidence proves that a domain-specific output shape cannot be expressed through reference guidance.

Do not add target-owned decision-record mechanics or templates by default. A target skill may supply domain context to `decision-record` without owning the record workflow.

## Frontmatter

A portable `SKILL.md` starts with YAML frontmatter:

```yaml
---
name: example-skill
description: Use when the user asks to perform the recurring task. Explain what the skill does and when it applies.
---
```

### Name

Use a name that:

- contains 1–64 lowercase letters, digits, or hyphens;
- has no leading, trailing, or consecutive hyphens;
- matches the parent directory; and
- describes the capability rather than one output format.

### Description

Treat the description as routing logic. It is always visible during skill discovery.

A useful description:

- uses imperative phrasing such as `Use when...`;
- states what the skill does and when to use it;
- names distinctive triggers or artifacts;
- describes user intent before implementation mechanics;
- distinguishes adjacent skills; and
- remains within the harness limit of 1024 characters.

Do not include the full workflow, implementation history, generic benefits, or motivational prose. For substantial routing changes, test or reason through one matching request and one near-miss request.

### Optional Fields

Use optional frontmatter only for a demonstrated requirement:

- `license` for a license name or bundled license reference;
- `compatibility` for real runtime or environment requirements;
- `metadata` for implementation-specific key-value information;
- `allowed-tools` as a compatibility declaration when supported; and
- `disable-model-invocation: true` for an explicit-only skill.

Do not rely on optional fields for critical containment unless the harness verifies and enforces them.

## Scope and Routing

Give the skill one primary responsibility. Document:

- positive triggers;
- negative boundaries;
- material ownership overlaps or required handoffs; and
- when assessment, research, or exploration may become implementation.

Include a handoff only when it changes the owner, required workflow, approval or safety behavior, necessary context transfer, or a stopping condition. Do not list generic helper skills merely because they may be useful.

State each handoff once where the agent needs it. Do not repeat global skill-selection rules or handoffs already clear in reference loading, approval guidance, or a dedicated shared-workflow section. Omit a routing section when no material boundary remains unresolved.

Keep a handoff explicit when removing it would blur ownership, approval, safety, required context transfer, or stopping behavior. Domain skills should add context to shared workflows rather than copy their mechanics.

## Progressive Disclosure

Keep always-needed routing, safety, and workflow rules in `SKILL.md`. Move detail to `references/` when it is:

- a specialized analysis lens;
- a detailed checklist or protocol;
- relevant to only one operating mode; or
- likely to obscure the default path.

Use a reference table near the beginning of the core and state a specific load condition for every reference. Do not create references the core never routes to.

Keep `SKILL.md` under 500 lines by default. Exceed it only when always-loaded behavior genuinely requires the space and explain the exception in the proposal or review.

## Core Structure

Use only sections that affect behavior. A practical core may include:

1. Purpose and goal.
2. References and required shared-workflow handoffs.
3. Use cases and boundaries.
4. Operating modes.
5. Approval and safety.
6. Workflow.
7. Validation and final reporting.

Do not copy this structure mechanically. Small skills may need less.

## Instruction Design

Use this test for every instruction:

> Would the agent likely get this wrong, miss it, or waste time rediscovering it without the instruction?

If no, remove it or place it in a more relevant optional resource. If yes and the agent needs it before recognizing the situation, keep it in the core.

Prefer instructions that are:

- observable;
- conditional;
- prioritized;
- reversible; and
- specific enough to validate.

Use action-first language, short paragraphs, clear defaults, and only questions that can change the outcome. Avoid mandatory preambles, fixed report structures for trivial tasks, exhaustive checklists applied mechanically, and duplicated global or shared-skill policy.

## Calibrated Control

Be prescriptive for discovery, routing, approval, safety, naming, migration, scripts, and validation gates. Allow judgment where several safe approaches satisfy the goal.

Use task-to-approach tables only when common task types need materially different methods. Use `Gotchas` only for concrete, non-obvious mistakes the agent may not recognize before loading a reference.

## Safety and Approval

Keep safety-critical boundaries in the core. For state-changing skills, define:

- what needs explicit approval;
- which paths or systems are in scope;
- what state is protected by default;
- what inspection precedes changes;
- how scope expansion is handled; and
- whether commits, deployment, or destructive operations need separate approval.

Project and global instructions remain authoritative. Skills may strengthen but never weaken them.

## Scripts

Add a script only when deterministic automation is more reliable than instructions alone.

Before adding one:

- explain why a script is preferable;
- keep it under `scripts/`;
- document inputs, outputs, dependencies, side effects, and failure behavior;
- provide a non-destructive help, check, or dry-run path when practical; and
- use `code-reviewer` for implementation quality.

Use [../assets/script-output-contract-template.md](../assets/script-output-contract-template.md) when the script contract is recurring or fragile. Do not add installers, daemons, hooks, or broad automation by default.

## Assets and Templates

Use `assets/` for files copied or used as output patterns rather than read as instructions.

Use semantic filenames that identify role and subject. Reserve `README.md` for a real collection overview unless an external format requires it and the user approves the exception.

Keep templates minimal and adaptable. Omit irrelevant sections, support project-local overrides, and avoid embedding one project's conventions globally.

Skill Creator owns these skill-domain assets:

| Asset                                                                                        | Use                                 |
| -------------------------------------------------------------------------------------------- | ----------------------------------- |
| [../assets/skill-core-template.md](../assets/skill-core-template.md)                         | Drafting a skill core.              |
| [../assets/skill-reference-template.md](../assets/skill-reference-template.md)               | Drafting a focused reference.       |
| [../assets/script-output-contract-template.md](../assets/script-output-contract-template.md) | Defining a bundled script contract. |

Use shared assets from `audit-workflow` for Audits and proposals and from `decision-record` for decision records. Keep domain adaptation in references unless a separate target-owned template has recurring evidence and a distinct contract.

## Response Design

Define a small default response shape only when it improves consistency. Useful optional elements are:

- current state or recommendation;
- main findings or decisions;
- unknowns and blockers;
- proposed or completed changes; and
- validation and next action.

Response structure should help the user decide or act, not display every internal step.

## Design Check

Before implementation, confirm:

1. The name and description route to the intended recurring task.
2. The skill has one primary responsibility.
3. Material ownership overlaps and required shared-workflow handoffs are explicit without forming a generic skill catalog.
4. Safety and approval boundaries remain in the core.
5. Optional details have clear loading conditions.
6. Scripts and assets are justified and documented.
7. Shared artifact templates are used directly unless domain evidence justifies another.
8. The proposed file list includes dependencies and migration records.
9. New, moved, or reorganized artifacts have roles, semantic names, and any reserved-name exception.
10. Substantial changes include a trial, routing check, execution-trace review, or a stated reason it was not practical.
11. Target-skill Audit/Review and proposal capabilities are independently justified and add domain behavior rather than shared mechanics.
12. Decision-record work defaults to the shared owner and preserves domain context in the handoff.
