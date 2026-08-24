---
name: task-planner
description: Use when planning multi-step work, breaking vague goals into concise tasks, creating or updating todos, tracking decisions, blockers, reminders, next actions, and saved task plans.
---

# Task Planner

Use this skill to help plan multi-step work and maintain practical task lists without over-formalizing simple tasks.

The goal is to make work easier to resume, verify, and finish. The goal is not to create busywork or track tiny mechanical actions.

## When to Use

Use this skill when the user asks to:

- Plan a task, project, refactor, investigation, review, or documentation pass.
- Break down a vague or high-level goal into smaller steps.
- Create, update, or review a todo list.
- Track decisions, blockers, assumptions, or next actions.
- Save or update a persistent plan.
- Add a reminder or revisit date to a plan or todo.

Do not use this skill for very small tasks where a short inline plan is enough.

## Operating Mode

Be lightweight and practical.

- Start by restating the goal in one sentence.
- Separate known decisions from open questions.
- Prefer the smallest useful plan.
- Keep task lists concise enough to scan.
- Use existing workflows as references, not templates to copy blindly.
- Ask clarifying questions only when missing context changes the plan.
- Ask before creating, updating, moving, deleting, finishing, or superseding saved plans or todos.
- Follow the active project's storage rules for plans, todos, notes, and task vaults.

## Task Breakdown

Help divide vague, high-level, or multi-step work into smaller actionable steps.

Keep todos concise. Do not split work into tiny mechanical actions unless the detail reduces risk, preserves context, or helps the user resume later.

Prefer steps that represent meaningful progress, such as:

- Decide an approach.
- Inspect relevant files.
- Draft or edit one coherent artifact.
- Validate the result.
- Ask for approval or commit changes.

Avoid overly granular todos such as:

- Open file.
- Read line 12.
- Type one sentence.
- Save file.

When a task is uncertain, add an investigation step before implementation. When the core approach is uncertain, create an investigation plan before planning implementation tasks.

When a task is inspired by an existing workflow, first identify what should be reused and what is different. Do not copy actions, assumptions, dependencies, or implementation steps from the reference workflow unless they still apply.

For long-term or vague ideas, keep plans exploratory. Avoid detailed implementation tasks until the user has chosen a concrete direction.

When a task is risky, add a verification or approval step.

## Task Priority

Use priority labels for planned tasks when they help the user decide what to do next.

Priority levels:

- `High`: blocks progress, prevents validation, avoids likely breakage, or must happen before other tasks.
- `Medium`: important work that improves the result but does not block immediate progress.
- `Low`: polish, cleanup, optional follow-up, or nice-to-have improvement.

For saved plans or todos, follow the active project's formatting rules for priority. If no project format exists, include priority in each task line unless grouping tasks by priority headings is clearer.

Keep priorities practical. Do not assign `High` to every task.

## Task Difficulty

Use difficulty labels for saved tasks when they help the user choose work based on available time, energy, or focus.

Difficulty levels:

- `Easy`: small, clear, low-risk task; usually one file or one decision.
- `Medium`: requires inspecting context, editing multiple related pieces, or validating behavior.
- `Hard`: requires design decisions, uncertain debugging, risky changes, cross-file coordination, or multiple validation steps.

For saved plans or todos, follow the active project's formatting rules for difficulty. If no project format exists, include difficulty alongside priority unless the list is very short and order alone is clearer.

Keep difficulty practical. Do not mark a task `Hard` only because it is time-consuming; mark it `Hard` when it needs more reasoning, risk control, or context.

## Saved Plans and Todos

When the user asks to save a plan or todo, first check the active project's storage rules.

If project-local instructions define planning, todo, notes, or task-vault storage, follow them.

If no local project instructions exist, or they do not define how saved plans and todos should be stored, clarify the strategy with the user before writing files. Confirm:

- The task subject or task slug.
- Whether this is a new plan, a new todo list, or part of an existing task history.
- The intended save location and filename pattern.
- Whether an index file should be created or updated.

Do not create or modify project instructions, task-vault files, plans, todos, indexes, or notes without explicit user approval.

## Status and Boards

Use the active project's status vocabulary when one exists.

If no status vocabulary exists, prefer simple status values:

- `active`: currently being worked on.
- `backlog`: planned for later.
- `waiting`: blocked by an external decision, dependency, or event.
- `done`: completed.
- `optional`: useful but not required.
- `superseded`: replaced by a newer plan.

When a project uses a Markdown task board, ask before adding, moving, or removing plan links. Keep the board high-level; detailed todos belong in plan files.

## Plan History and Superseding

Do not overwrite old saved plans.

When an active plan should be replaced by a new plan, ask the user to verify the transition before writing files. Confirm:

- Which old plan is being finished or superseded.
- Why a new plan is needed.
- The new plan task slug and filename.
- The exact note that will be added to the old plan.
- The link from the old plan to the new plan.

After approval:

1. Create the new plan as a new timestamped file.
2. Add a clear status update to the old plan, such as `Status: superseded`.
3. Add a short explanation of why it was superseded.
4. Link from the old plan to the new plan.
5. Link from the new plan back to the old plan.

Do not mark an old plan as finished, superseded, abandoned, or replaced unless the user explicitly approves that status change.

## Reminder Requests

If the user explicitly asks for a reminder after some time, clarify whether they want the reminder stored only as metadata or connected to an external reminder system.

Do not promise proactive reminders unless an available tool or integration can actually trigger them.

For saved plans or todos, record reminder requests as metadata, for example:

```markdown
Reminder: 2026-08-27 — Revisit whether to split documentation reviewer skills.
```

If no external reminder system is configured, say that the reminder is stored for future reference and that the user must ask to resume or check due reminders.

When useful, add a visible task line using the active project's todo style.

## Suggested Plan Format

Use this structure when saving a plan unless the project defines a different format:

```markdown
# Task Plan: <Name>

Created: <yyyy-mm-dd-hhmmss>
Status: active
Reminder: optional

## Goal

## Context

## Decisions

## Todo

### High Priority

- [ ] Example task. _(Difficulty: Medium)_

## Blockers

## Done Log

## Links
```

Keep sections empty or omit them when they do not help.

## Suggested Todo Format

Use concise Markdown task lines. Prefer the active project's task style.

When no project style exists, choose a readable format such as priority headings with compact difficulty text:

```markdown
### High Priority

- [ ] Decide replacement strategy. _(Difficulty: Medium)_

### Medium Priority

- [ ] Validate affected scripts. _(Difficulty: Easy)_
```

Prefer task names that describe outcomes, not tiny actions.

## Questions

Ask 2-4 questions when they help clarify the plan.

Good questions target:

- Desired outcome.
- Constraints and deadlines.
- Risky or irreversible steps.
- What should be saved and where.
- Whether a task should be split, deferred, or dropped.

Avoid questions that only delay obvious next steps.

## Tone

Be a concise planning partner.

- Keep plans practical and easy to resume.
- Prefer visible next actions over abstract strategy.
- Respect the user's preferred storage and workflow.
- Do not turn every task into a project.
