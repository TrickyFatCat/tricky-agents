# Saved Task Workflow

Read this reference before creating, updating, moving, finishing, superseding, or adding reminders to persistent task artifacts or boards.

Project-local instructions are authoritative for storage, naming, statuses, metadata, history, and board behavior.

## Inspect Before Changing State

Before proposing a saved change:

1. Read the active project instructions.
2. Inspect the owning task and relevant card, plan, todo, board entry, note, or index.
3. Inspect nearby related artifacts and established examples when extending an existing task history.
4. Identify project-defined naming, linking, step-log, index, history, and validation conventions that apply.
5. Determine which artifact is the source of truth.
6. Determine the target's storage and validation context.
7. Check repository state when the target is expected to be version-controlled.
8. Identify the exact state transition and affected files.

Apply only conventions established by the active project. Do not make nearby examples, numbered step logs, backlinks, indexes, or other local patterns mandatory globally.

Do not create a parallel task system when an active workflow already exists.

## Approval

Before a persistent change:

- Explain the proposed state change and why it helps.
- Identify important trade-offs or lost historical meaning.
- List every exact file or board entry to create, modify, move, or delete.
- For human-facing rename or move approval, show old values before new values. Compare basenames for renames and parent directories without filenames for moves. For combined operations, compare both, then show the resulting full path. Apply the same sequence to files and directories.
- Wait for explicit user approval.

If approved content must change because of new facts, pause and explain the difference before writing it.

## Storage and Identity

Follow project-local locations and naming rules.

If no applicable rules exist, clarify:

- The task subject and human-readable identity.
- Whether to create a new artifact or update an existing one.
- The save location and filename.
- Whether an index or board should change.
- Whether history needs a snapshot or can remain in a done log.

Do not choose persistent storage silently.

## Status and Boards

Use the project's status vocabulary when available.

If none exists, use only statuses that help the workflow. A practical fallback is:

- `backlog`: planned for later.
- `active`: currently being worked on.
- `waiting`: blocked by a decision, dependency, or event.
- `done`: completed and verified.
- `optional`: useful but not required.
- `superseded`: replaced by a newer task artifact.

Treat artifact metadata as the source of truth unless project instructions say otherwise. Keep boards high-level; detailed todos belong in the task artifact.

Ask before adding, moving, or removing board entries. When useful, link a waiting task to its blocker and the blocker back to its dependent task.

## Creating and Updating Tasks

Create one meaningful task artifact unless the workflow or user requires separate artifacts.

When updating an existing task:

- Preserve confirmed decisions and useful context.
- Record meaningful completed outcomes in the project's done-log style.
- Keep the next action and blockers current.
- Remove stale instructions only when the user approves and history remains understandable.
- Do not mark work done without evidence appropriate to its definition of done.

Do not overwrite historical snapshots when the project preserves immutable plan history.

## Replacement and Superseding

Do not assume replacement requires a timestamped file.

Follow project-local history rules:

- Stable-card workflows usually update the existing card and its log.
- Snapshot workflows may create a new version or timestamped artifact.
- A replacement artifact is appropriate when identity, scope, ownership, or approach changes materially and preserving the old state helps.

Before superseding, confirm:

- The old and new task identities.
- Why replacement is needed.
- The status and note to add to the old artifact.
- Required links between old and new artifacts.
- Board or index changes.

Never mark a task finished, abandoned, or superseded without explicit approval.

## Resume Mode

Use a resume report when the user returns to existing work or asks what to do next.

Suggested shape:

```markdown
## Resume Report

Goal: <desired outcome>
Current state: <where the work stands>
Done evidence: <verified completed outcomes>
Blockers: <none or current blockers>
Open decisions: <none or decisions still needed>
Next action: <smallest meaningful next step>
```

Adapt or omit fields to match the project. Derive the report from inspected task material; do not infer completed work without evidence.

Update saved task state only when the user requests and approves the update. A resume report can remain conversational.

## Reminders

When the user asks for a reminder, clarify whether they want:

- Metadata stored in the task artifact.
- A date or revisit condition.
- An external reminder integration that can trigger proactively.

Do not promise proactive notification without an available and configured integration.

A metadata-only reminder can use the project's format or a simple fallback:

```markdown
Reminder: <yyyy-mm-dd> — Revisit the unresolved decision.
```

Explain that metadata does not trigger itself and the user must return to or query the task unless an integration exists.

## Fallback Task Format

Use the project's format whenever one exists. Otherwise propose a minimal structure and obtain approval before saving:

```markdown
# Task Title

Status: active
Created: <yyyy-mm-dd>

## Goal

A concise desired outcome.

## Todo

- [ ] Complete a meaningful outcome.
- [ ] Validate the result.

## Blockers

None.

## Done Log

- <yyyy-mm-dd>: Task created.
```

Add priority, effort, decisions, context, links, reminders, or resume fields only when useful. Do not add per-item difficulty by default.

## Validate Saved Changes

After writing:

1. Re-read changed task artifacts and board entries.
2. Confirm metadata, links, statuses, and project-defined relationships agree.
3. Confirm only approved files changed.
4. Format changed Markdown when the project uses a formatter.
5. Validate each target according to its storage context:
    - use repository status and diff checks when the target is expected to be version-controlled;
    - use direct content, metadata, link, and relationship inspection for non-Git vaults and plain directories;
    - validate each location with its applicable mode when artifacts span multiple storage systems.
6. Report files changed, state transitions, validation mode, and anything not tested.

Describe Git as unavailable only when the project expected Git validation but it could not be performed. Otherwise report direct inspection as the applicable validation mode without presenting the absence of Git as a deficiency.
