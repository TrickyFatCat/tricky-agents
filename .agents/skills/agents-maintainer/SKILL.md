---
name: agents-maintainer
description: Maintain the user's global ~/.agents repository, AGENTS.md, and reusable agent skills. Use only when the user explicitly asks to update global agent instructions, global skills, or the agents repository, or invokes /skill:agents-maintainer.
disable-model-invocation: true
---

# Agents Maintainer

Use this skill only for explicit requests to maintain the user's global agent setup.

This skill is intentionally hidden from automatic model invocation. It exists as a user-requested command: `/skill:agents-maintainer`.

## Scope

Maintain files under the global agents repository, normally exposed at:

- `~/.agents/AGENTS.md`
- `~/.agents/skills/`
- repo-backed `~/.pi/agent/AGENTS.md`
- repo-backed `~/.pi/agent/prompts/`

The current setup may use symlinks. Resolve the real path before editing:

```bash
readlink -f ~/.agents
```

Prefer editing the resolved repository files, while reporting paths in both user-facing and repository terms when helpful.

## Workflow

1. Confirm the request is about global agent instructions, skills, or the agents repository.
2. Inspect repository state before changing files:

   ```bash
   git -C "$(readlink -f ~/.agents)/.." status --short
   ```

3. Read the relevant files before editing.
4. Keep durable behavior in skill files when it is task-specific; keep `AGENTS.md` concise and project-wide.
5. Make targeted edits with `edit` when modifying existing files. Use `write` only for new files or full rewrites.
6. Preserve portability across machines; avoid absolute paths unless documenting the local bootstrap layout.
7. Avoid scripts, install hooks, daemons, cron jobs, or destructive setup unless the user explicitly asks.
8. After edits, validate with:

   ```bash
   git -C "$(readlink -f ~/.agents)/.." status --short
   git -C "$(readlink -f ~/.agents)/.." diff --check
   ```

## Skill Maintenance Guidelines

When creating or updating a skill:

- Use a lowercase, hyphenated `name` in frontmatter.
- Keep `description` specific about when the skill should be used.
- Add `disable-model-invocation: true` for skills that should only run when explicitly requested.
- Keep helper scripts and references inside the skill directory.
- If a skill references relative files, make paths relative to that skill directory.

## Final Response

When files are changed, report:

- Files changed
- Summary of changes
- Validation performed
- Anything not tested
