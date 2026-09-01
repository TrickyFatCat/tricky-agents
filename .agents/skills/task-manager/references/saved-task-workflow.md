# Saved Task Workflow

Read this reference before creating, updating, resuming, replacing, completing, cancelling, or adding reminders to persistent task state.

Project-local instructions are authoritative for storage, configuration, naming, templates, metadata, history, and task views. When Task Manager owns persistent task state, use taskmd and read [taskmd-workflow.md](taskmd-workflow.md) before managing it.

## Inspect Before Changing State

Before proposing a saved change:

1. Read active project instructions.
2. Resolve the approved project root and `.taskmd.yaml`.
3. Resolve the configured task directory, workflow mode, worklogs, ID strategy, and template sources.
4. Confirm taskmd availability and relevant command support.
5. Identify the authoritative task ID and file.
6. Inspect related dependencies, parent links, worklogs, and generated state when they affect the change.
7. Determine the exact transition, expected file effect, storage context, and validation method.
8. Check repository state only when the target is expected to be Git-backed.

Do not create a parallel task system, manual board, fallback card, or direct-write path.

## Approval

Before a persistent change:

- explain the state change and why it helps;
- identify the task ID, current state, target state, and expected file effects;
- explain important trade-offs or lost historical meaning;
- list exact affected files when known;
- for task creation, state the expected taskmd-allocated path and stop if allocation is materially uncertain;
- show old and new values for human-facing renames or moves; and
- wait for explicit approval.

Approval applies only to the described effect and scope. If taskmd reports a materially different target or effect, stop before additional changes.

## Storage and Identity

Follow project-local taskmd configuration. Treat task IDs as stable identity and filenames as human-readable locators.

- Let taskmd allocate IDs and filenames.
- Resolve tasks by ID rather than title or slug when possible.
- Ask when a query is ambiguous.
- Do not invent IDs, duplicate task files, or silently move task state.
- Keep generated list, status, next, and board output as views rather than separate state.

Task notes and decision records are separate domains. Do not create or manage them as Task Manager runtime artifacts.

## Status and Views

Use the active taskmd project's status vocabulary:

- `pending`: ready or planned but not started.
- `in-progress`: actively being worked on.
- `blocked`: cannot proceed until a named blocker is resolved.
- `in-review`: awaiting review or integration under the configured workflow.
- `completed`: finished and validated.
- `cancelled`: intentionally stopped without completion.

Treat task files as the source of truth. Use taskmd list, status, next, and board output as generated views; do not maintain duplicate task status in a manual board.

Ask before changing status. Before `completed`, `cancelled`, or `in-review`, inspect Tasks and Acceptance Criteria and gather appropriate validation evidence. Run task-defined verification only after separate inspection and execution approval.

## Creating Tasks

Require taskmd for persistent task creation. Select an available built-in, user, or project template when it fits; otherwise use the approved neutral `task` template.

Before creation, confirm:

- project and target group;
- concise title and one desired outcome;
- selected template and its source;
- material priority, effort, tags, dependencies, parent, or owner; and
- expected allocated path and write effect.

Obtain approval, let taskmd allocate identity and filename, fill meaningful body content, and validate the result. Do not create persistent task files or allocate IDs directly when taskmd is unavailable.

## Updating Tasks

Use taskmd for supported metadata and status changes. Edit body content directly only after taskmd resolves the authoritative file.

- Preserve confirmed decisions, useful context, and checked outcomes.
- Keep Objective, Tasks, and Acceptance Criteria current when they help execution.
- Record meaningful approaches, blockers, decisions, and completion context in enabled worklogs.
- Do not mark work complete without evidence appropriate to its acceptance criteria.
- Do not add optional fields or custom metadata without an observed project need.
- Validate after every approved write.

## Replacement and Cancellation

Do not assume replacement requires migration, archival, or a timestamped file.

Before replacing or cancelling a task, confirm:

- old and new task identities;
- why replacement or cancellation is needed;
- preserved context and relationship between tasks;
- dependency and parent effects;
- status and worklog changes; and
- any destructive or archive effect.

Use taskmd status and relationship fields where supported. Preserve replacement reasoning in task bodies or enabled worklogs when useful. Handle archive or deletion only after an explicit user request and separate approval.

## Resume Mode

Use taskmd to resolve the task, then derive a resume report from the task file, relationships, and worklog:

```markdown
## Resume Report

Goal: <desired outcome>
Current state: <status and meaningful progress>
Done evidence: <verified completed outcomes>
Blockers: <none or current blockers>
Open decisions: <none or unresolved choices>
Next action: <smallest meaningful next step>
```

Adapt or omit fields. Do not infer completed work without evidence. Update persistent state only when requested and approved.

## Reminders

When the user asks for a reminder, clarify whether they want:

- task body content;
- a project-approved custom field;
- a revisit date or condition; or
- an external reminder integration that can trigger proactively.

Use taskmd to resolve the task, obtain approval, edit the exact body or supported field, then validate. Explain that stored text does not trigger itself. Do not promise notification without an available configured integration.

## Validate Saved Changes

After approved changes:

1. Run taskmd validation from the approved project root; use strict validation when applicable.
2. Re-read every changed task and worklog.
3. Confirm IDs, required fields, statuses, dependencies, parent links, filenames, and template placeholders are valid.
4. Confirm only approved paths and effects changed.
5. Format changed Markdown when required.
6. Validate each location by storage context:
    - use repository status and exact diffs where Git is expected;
    - use direct content, metadata, and relationship inspection for linked vaults and non-Git storage; and
    - validate user-level templates or configuration directly when they are outside a repository.
7. Report created or changed IDs and paths, validation results, and anything not tested.

Do not treat manual inspection as equivalent to taskmd validation. Report when runtime discovery, template rendering, or task-defined verification was not performed.
