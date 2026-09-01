# Mandatory taskmd Task Management Workflow

Status: Accepted
Date: 2026-08-31

Related:

- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)
- [Global Shell Selection Policy](0021-global-shell-selection-policy.md)

## Context

Task Manager supported project-defined cards and a generic Markdown fallback. That kept persistence tool-independent but required agents to manage identity, statuses, boards, validation, and repeated task structure themselves.

The user evaluated taskmd locally, accepted its Markdown format, and selected the binary as the required operating tool. Current taskmd guidance recommends focused tasks, generated views, genuine blocking dependencies, flat initial organization, explicit worklogs when an audit trail matters, and binary validation.

## Decision

Require taskmd whenever Task Manager owns persistent task state.

- Keep task Markdown as the source of truth.
- Keep Task Manager responsible for planning quality, authority, approval, handoffs, and lifecycle meaning.
- Use taskmd for project discovery, task queries, identity and filename allocation, templates, metadata and status mutation, worklogs, generated views, and validation.
- Permit direct task-body edits only after taskmd resolves or creates the task and require taskmd validation afterward.
- Stop persistent operations when taskmd or required capabilities are unavailable. Do not install, upgrade, initialize, or fall back to direct state writes automatically.
- Follow stronger project-local configuration, storage, privacy, template, and approval rules.
- Keep task-defined verification, web, MCP, sync, credentials, registration, archive, deletion, and other high-effect capabilities behind separate inspection and approval.

Use a neutral user-level `task` template under `~/.taskmd/templates/`. Keep project-specific templates optional and evidence-driven. Built-in taskmd templates remain available.

Use Objective, Tasks, and Acceptance Criteria for substantial tasks. Prefer one deliverable, split when task breadth or roughly 8–10 distinct subtasks makes one task unwieldy, and create dependencies only for genuine blockers.

Treat task notes and decision records as separate domains rather than Task Manager runtime artifacts. Use enabled worklogs for task approaches, progress, blockers, and completion context.

Apply this workflow prospectively. Do not migrate or maintain compatibility with deprecated card and manual-board state.

## Reasons

- Mandatory binary use avoids duplicating fragile ID, mutation, template, ranking, worklog, and validation behavior.
- Markdown remains inspectable and portable while the binary provides consistent operations.
- A neutral generic template reduces boilerplate without creating a premature project-template catalog.
- Generated views avoid a second status source.
- Explicit domain boundaries keep Task Manager focused on task state.

## Consequences

- **Benefits:** Stable identity, consistent lifecycle mutations, reusable templates, generated prioritization, worklogs, and validation.
- **Costs:** Persistent task management stops when taskmd is missing or incompatible.
- **Safety:** Binary presence does not authorize installation, execution of task verification, network services, credentials, or destructive effects.
- **Portability:** User-level templates are local non-Git state and need direct validation on each machine.
- **Project authority:** Projects control configuration and may impose stronger approval or storage rules.
- **Compatibility:** Historical cards and boards remain physically untouched but unsupported by normal Task Manager operations.

## Alternatives

- Keep taskmd optional with direct-write fallback — rejected because agents would duplicate identity and validation behavior.
- Adopt only the taskmd format — rejected because the selected workflow requires the binary.
- Use built-in templates only — rejected because no neutral task template exists.
- Add research and agent-change project templates immediately — deferred until recurring use proves their shape.
- Migrate historical cards — rejected by the user.

## Sources

- [Best Practices and Workflows](https://driangle.github.io/taskmd/guide/best-practices.html)
- [taskmd Specification](https://driangle.github.io/taskmd/reference/specification.html)
- [Core Concepts](https://driangle.github.io/taskmd/getting-started/concepts.html)

## Related Changes

- `.agents/skills/task-manager/SKILL.md`
- `.agents/skills/task-manager/references/taskmd-workflow.md`
- `.agents/skills/task-manager/references/saved-task-workflow.md`
- `.agents/skills/task-manager/references/task-design.md`
