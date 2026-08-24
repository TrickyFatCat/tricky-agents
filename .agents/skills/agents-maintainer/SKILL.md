---
name: agents-maintainer
description: Maintain the user's global ~/.agents repository, AGENTS.md, reusable agent skills, and repo-backed Pi resources. Use only when the user explicitly asks to update global agent instructions, global skills, prompt templates, or the agents repository, or invokes /skill:agents-maintainer.
disable-model-invocation: true
---

# Agents Maintainer

Use this skill only for explicit requests to maintain the user's global agent setup.

This skill is hidden from automatic model invocation. It exists as the user-requested command `/skill:agents-maintainer`.

## Scope

Maintain approved files inside the resolved agents Git repository, commonly exposed through:

- `~/.agents/AGENTS.md`
- `~/.agents/skills/`
- repo-backed `~/.pi/agent/AGENTS.md`
- repo-backed `~/.pi/agent/prompts/`

The setup may use nested symlinks. Resolve the repository through Git instead of assuming a fixed directory layout:

```bash
agents_path="$(readlink -f ~/.agents)"
repo_root="$(git -C "$agents_path" rev-parse --show-toplevel)"
```

Before editing a target:

1. Resolve the existing target or its nearest existing parent.
2. Confirm the resolved location is inside `$repo_root`.
3. Confirm symlinks do not lead outside `$repo_root`.
4. Report user-facing and repository paths when both help identify the file.

Treat nearby Pi runtime state as out of scope by default, including:

- Credentials and authentication files.
- Session history.
- Trust state.
- Installed packages and generated stores.
- Active settings that are not repository-backed.

Do not modify runtime, credential, session, trust, package, or non-repository state unless the user explicitly names the target and approves the risks after inspection.

## Approval Gate

Before creating, modifying, deleting, moving, or reorganizing global agent resources:

1. Explain the proposed change.
2. Explain the reasoning and trade-offs.
3. List every exact file to create, modify, move, or delete.
4. Wait for explicit user approval.

Approval applies only to the described scope. Pause and request approval again if new files, broader changes, or materially different behavior become necessary.

## Maintenance Workflow

1. Confirm the request concerns global instructions, skills, prompt templates, repo-backed Pi resources, or the agents repository.
2. Resolve `agents_path` and `repo_root` as shown above.
3. Inspect repository state before proposing changes:

   ```bash
   git -C "$repo_root" status --short
   ```

4. Read the relevant files and inspect target paths without changing state.
5. Present the proposal required by the approval gate.
6. After approval, make only the approved changes.
7. Keep durable project-wide behavior in `AGENTS.md`; keep task-specific methods in skills or their references.
8. Use targeted edits for existing files. Use full rewrites only when restructuring an approved file, and use new-file writes only for approved new files.
9. Preserve portability across machines. Avoid absolute paths unless documenting an intentional local bootstrap layout.
10. Avoid scripts, install hooks, daemons, cron jobs, or destructive setup unless explicitly requested and approved.
11. Run artifact-specific validation and inspect the final diff.
12. Do not commit unless the user explicitly asks.

## Skill Maintenance

Use `skill-creator` for skill architecture, frontmatter, routing, progressive disclosure, review, update, rename, and artifact-specific validation.

When both skills apply:

- `skill-creator` owns the quality and migration completeness of the skill artifact.
- `agents-maintainer` owns global-resource approval, repository boundaries, path safety, staging, commits, and final repository state.
- Apply the `agents-maintainer` approval gate before creating or changing global skill files.
- Return to `agents-maintainer` for exact-path validation and any requested commit after skill work is complete.

Do not let skill-design guidance weaken repository safeguards or broaden the user's approved scope.

## Validation

Validate only the approved changed files and their relevant relationships.

For skills, check:

- Required frontmatter fields exist and match the directory.
- Explicit-only invocation settings remain intact.
- Referenced files exist and relative paths resolve.
- Markdown is formatted with the intended formatter.
- No accidental absolute or machine-specific paths were introduced.

For all agent-repository changes, run:

```bash
git -C "$repo_root" status --short
git -C "$repo_root" diff --check
git -C "$repo_root" diff -- <approved-paths...>
```

Confirm that only approved files changed. Report validation that was not possible or tests that were not run.

## Commit Workflow

Commit only when the user explicitly asks after reviewing or approving the changes.

Before committing:

1. Inspect repository status and the relevant diff.
2. Confirm only approved files will be staged.
3. Stage exact paths rather than all repository changes.
4. Validate the staged diff:

   ```bash
   git -C "$repo_root" diff --cached --check
   ```

5. Commit with a focused message that describes the approved change.
6. Verify repository state afterward:

   ```bash
   git -C "$repo_root" status --short
   ```

Do not amend, force-push, reset, or discard unrelated changes unless the user explicitly requests and approves that operation.

## Final Response

When files are changed, report:

- Files changed.
- Summary of changes.
- Validation performed.
- Anything not tested.
- Commit hash and message when a commit was requested.
- Remaining repository changes when the working tree is not clean.
