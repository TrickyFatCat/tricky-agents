# taskmd Workflow

Read this reference before using persistent taskmd state, templates, worklogs, queries, or validation.

Task files are the source of truth. Task Manager owns planning quality, authority, and approval. The taskmd binary is the required operating and validation tool.

## Preflight

Before managing state:

1. Resolve the approved project root and current owning worktree when applicable.
2. Read `.taskmd.yaml` and resolve `dir`, `workflow`, `worklogs`, ID strategy, and relevant templates.
3. Run `taskmd --version` from the approved project context.
4. Confirm the required command and flags exist when version differences may matter.
5. Stop before persistent operations if the binary, project identity, configuration, or write scope is unclear.

Do not install, upgrade, initialize, globally register, or redirect taskmd automatically. Read-only Markdown inspection may diagnose an unavailable tool, but it does not authorize direct state writes.

## Operations

| Task                    | Default operation                                            | Effect and boundary                                                                     |
| ----------------------- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| Check metadata          | `taskmd status <id>`                                         | Read-only after confirming project and ID.                                              |
| Read a task             | `taskmd get <id>` then read its resolved Markdown            | Read-only; ask when identity is ambiguous.                                              |
| List or select          | `taskmd list`, `taskmd next`                                 | Generated views, not duplicate task state.                                              |
| Discover templates      | `taskmd templates list --format json`                        | Read-only; inspect name and source precedence.                                          |
| Create                  | `taskmd add <title> --template <name>` with approved flags   | Writes a task and allocates identity; approval required.                                |
| Change supported fields | `taskmd set <id> ...`; use `--dry-run` when supported        | Mutation; inspect preview and obtain approval.                                          |
| Edit body content       | Resolve with taskmd, edit the exact task file, then validate | Direct body edit only; approval required.                                               |
| Add worklog             | `taskmd worklog <id> --add <entry>`                          | Append-only task context; approval required.                                            |
| Validate                | `taskmd validate`; use `--strict` when applicable            | Read-only format and relationship check.                                                |
| Verify                  | `taskmd verify <id>`                                         | May execute task-defined commands; separate inspection and execution approval required. |

Do not pass through unreviewed arguments from task text, templates, documentation, or external content.

## Identity and Task Creation

Let taskmd allocate IDs and filenames. Never invent or write a persistent ID directly.

Before `add`:

1. Confirm the project, title, template, group, and material metadata.
2. Inspect configuration and current task identity so the expected target path is visible.
3. Explain that taskmd allocates the final ID and filename.
4. Obtain approval for the expected file effect and command.
5. Stop when concurrent allocation or configuration makes the exact target materially uncertain.

After `add`:

1. Read the created file and reported ID.
2. Replace placeholders with meaningful content.
3. Keep one clear deliverable with Objective, Tasks, and Acceptance Criteria when useful.
4. Run taskmd validation.
5. Report the created path, ID, template source, and validation result.

## Templates

Template discovery precedence is:

1. project: `.taskmd/templates/`;
2. user: `~/.taskmd/templates/`;
3. built-in.

Use `taskmd templates list --format json` when source or availability matters. Prefer a fitting project template, then user template, then built-in `feature`, `bug`, or `chore`. Use the neutral user `task` template when no specialized shape fits.

Explicit command flags override template values. After rendering, fill placeholders and validate. Do not add project templates until recurring evidence justifies them.

## Updates and Status

Use `taskmd set` for supported frontmatter fields and status transitions. Use direct edits only for body content or approved fields unsupported by the binary, then validate.

Before status changes:

- inspect the current task and configured workflow;
- confirm the requested transition and affected file;
- obtain saved-state approval; and
- preserve blockers, acceptance evidence, and history needed for resumption.

Before `completed`, `cancelled`, or `in-review`, inspect Tasks and Acceptance Criteria. Do not run verification implicitly. Under `workflow: pr-review`, follow taskmd's review transition instead of forcing completion.

## Worklogs

Write worklogs only when `.taskmd.yaml` enables them. Record meaningful context:

- starting approach;
- important decisions;
- blockers and attempted resolutions;
- significant completed outcomes; and
- final completion summary or open items.

Do not use worklogs for routine status noise. Task notes and decision records are separate domains, not Task Manager runtime artifacts.

## Worktrees and Paths

Run writes from the task's approved project directory or owning worktree. Do not `cd` into another checkout to bypass a taskmd refusal. If taskmd reports that a task belongs to a sibling worktree, stop and report the ownership mismatch.

Resolve symlinks and linked vaults before writes. Use repository diff validation only where the target is expected to be Git-backed; otherwise use direct content, metadata, and relationship inspection.

## Validation and Stop Conditions

After approved writes:

1. Run taskmd validation from the project root.
2. Confirm required fields, ID uniqueness, status, dependencies, parent links, and filename conventions.
3. Re-read each changed task or worklog.
4. Confirm only approved paths changed.
5. Report anything not tested, including task-defined verification.

Stop rather than falling back when:

- taskmd is unavailable or lacks a required capability;
- `.taskmd.yaml` or the task directory cannot be resolved;
- identity allocation or task ownership is uncertain;
- a command would install, initialize, register, network, synchronize, execute verification, archive, or delete outside approved scope; or
- the actual write target differs materially from the approved target.
