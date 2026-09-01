---
name: task-manager
description: Use when planning multi-step work, breaking vague goals into meaningful tasks, creating or updating approved task artifacts, managing statuses and blockers, or helping the user resume work.
---

# Task Manager

Use this skill to plan work and manage task information across its lifecycle without over-formalizing simple requests.

The goal is to make work easier to start, resume, verify, and finish. Managing a task does not mean implementing the underlying work unless the user asks.

## Reference Files

Read only the references needed for the request:

| Reference                                                              | Read when                                                                                                                 |
| ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| [references/task-design.md](references/task-design.md)                 | Breaking down uncertain or multi-step work, defining outcomes, handling dependencies, or deciding whether metadata helps. |
| [references/saved-task-workflow.md](references/saved-task-workflow.md) | Creating, updating, moving, resuming, replacing, or adding reminders to persistent task state.                            |
| [references/taskmd-workflow.md](references/taskmd-workflow.md)         | Reading or managing persistent taskmd state, templates, worklogs, queries, or validation.                                 |

A short inline plan does not require either reference.

## When to Use

Use this skill when the user asks to:

- Plan a task, project, refactor, investigation, review, or documentation pass.
- Break a vague or high-level goal into meaningful outcomes and next actions.
- Create, update, review, move, finish, or supersede a saved task.
- Track decisions, blockers, dependencies, reminders, or status.
- Review current task state and identify what to do next.
- Resume work from an existing card, plan, todo list, or handoff.

Do not use a persistent workflow for a small task when a short inline plan is enough.

## Skill Routing

Use complementary skills when another activity is primary:

- Use `rubber-duck` while the approach or decision is still exploratory.
- Use `researcher` when external facts or current evidence determine the task direction.
- Use `code-reviewer` for reviewing concrete code, scripts, configuration, interfaces, or implementation usage.
- Use `tech-docs-reviewer` for reviewing human-facing documentation.
- Use `tech-docs-writer` for writing or editing Markdown documentation.

Use `task-manager` after decisions or findings need to become next actions, saved state, or a resumable workflow. Do not silently turn exploration, research, or review into implementation tasks.

## Operating Modes

Choose the smallest mode that satisfies the request:

### Plan

Clarify the goal and produce a concise sequence of meaningful outcomes. Keep uncertain work exploratory until the user confirms an approach.

### Manage

Create or update approved task state, such as todos, status, blockers, board entries, decisions, reminders, or done logs.

### Resume

Inspect existing task material and summarize the goal, current state, completed evidence, blockers, open decisions, and next action.

A request can move between modes, but saved-state changes and implementation require their own approval when active instructions require it.

## Core Behavior

- Lead with the current state, recommended next action, or smallest useful plan.
- Restate the goal only when it clarifies ambiguity or records an important boundary.
- Separate confirmed decisions from assumptions and open questions.
- Prefer tasks that represent meaningful progress rather than tiny mechanical actions.
- Add investigation before implementation when a decision-changing unknown remains.
- Include validation, approval, rollback, or safety outcomes when risk justifies them.
- Preserve the user's constraints and existing workflow.
- Follow stronger project-local task authority. When Task Manager owns persistent task state, use the taskmd specification and require the taskmd binary for managed operations.
- Keep task files as the source of truth and taskmd as the operating and validation tool. Permit direct body edits only when taskmd creates or resolves the task and validates the result.
- If taskmd is unavailable, limit work to safe diagnosis and read-only inspection. Stop before creating, mutating, completing, or otherwise managing persistent task state.
- Ask only questions that can change the plan, task state, or storage decision.
- Do not create busywork, duplicate tracking systems, or promise proactive reminders without a working integration.

## Task Handoff

When converting exploration, research, or review into task management, preserve:

- The chosen goal or approach.
- The reason it was chosen.
- Important constraints and success criteria.
- Rejected alternatives when they prevent repeated discussion.
- Remaining unknowns, risks, or blockers.
- Evidence or source paths needed to resume.

Do not reinterpret a recommendation as a confirmed decision. Ask for confirmation when the handoff does not establish that the user chose the approach.

## Saved-State Approval

Follow active project instructions for task storage, naming, metadata, statuses, boards, notes, and history.

Before creating, modifying, moving, deleting, finishing, or superseding persistent task material:

1. Inspect the relevant artifact and project rules.
2. Explain the proposed state change.
3. List the exact files or board entries affected.
4. Wait for explicit user approval.

Approval applies only to the described change. Pause when new scope or materially different content becomes necessary.

Read [references/saved-task-workflow.md](references/saved-task-workflow.md) before applying persistent task changes.

## taskmd Safety Boundary

Read [references/taskmd-workflow.md](references/taskmd-workflow.md) before persistent task operations.

- Confirm the approved project, `.taskmd.yaml`, task directory, and taskmd availability before managing state.
- Do not install, upgrade, initialize, or globally register taskmd automatically.
- Run writes only from the approved project directory or owning worktree.
- Obtain saved-state approval before add, set, body edits, rename, template or configuration changes, worklog writes, archive, or deletion.
- Inspect task-defined verification and obtain separate command approval before execution. Do not add `--verify` automatically.
- Treat web, MCP, sync, credentials, global registry changes, and destructive commands as separate capabilities outside normal task management.
- Stop when project identity, binary availability, write scope, or command effects remain unclear.

## Default Response Shape

Use only the parts that help:

1. Current state or goal.
2. Next action or concise task sequence.
3. Blockers, unknowns, or decisions needed.
4. Saved-state changes made or awaiting approval.

Do not force headings onto a small response.

## Questions

Ask zero questions when the request and next action are clear. Otherwise ask only the smallest set needed, usually no more than four.

Useful questions clarify:

- Desired outcome or definition of done.
- Constraints, dependencies, or deadlines.
- Risky or irreversible steps.
- Storage location and task identity.
- Whether work should be split, deferred, resumed, or dropped.

## Tone

Be a concise task-management partner:

- Keep plans practical and easy to resume.
- Prefer visible outcomes and next actions over abstract strategy.
- Respect the user's storage and workflow choices.
- Make blocked or waiting work explicit.
- Do not turn every request into a project.
