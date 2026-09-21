# tricky-agents

Personal configuration for AI coding agents. It holds three things:

- The rules every agent follows.
- The skills an agent loads for a specific job.
- The scripts that build and install both.

## Requirements

Built for Linux and not tested on any other system.
[Nushell](https://www.nushell.sh) is required to run the scripts.

## Layout

| Path | What it holds |
|---|---|
| `global/` | Source files for the global `AGENTS.md` |
| `skills/` | Global skills, one folder each |
| `scripts/` | Build, install, and worktree cleanup |
| `chats/` | Per-service chat personalisation — ChatGPT mobile, Grok web |
| `docs/` | Documentation for skills |

`AGENTS.md` in the root covers the working process — worktrees, commits, and
cleaning up afterwards. It is written for agents, and this file is not.

## Rules Files

`global/` holds three files. Two are yours to edit, one is built from them.

**`machine-rules.md`** — hand-edited. Defaults that apply to any project:

- Decision policy.
- Change discipline.
- Safety.
- Tools and workflows.

**`personal-rules.md`** — hand-edited. Response rules, formatting preferences,
and who the author is.

**`global-agents.md`** — generated. The build joins the two sources under a
banner and drops every heading one level, so both sit under it as peers.

> ⚠️ **Warning**
>
> Never hand-edit `global-agents.md` — the next build overwrites it.

Changing a rule takes three steps.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run `nu scripts/build-global-agents.nu`.
3. Commit the source and `global-agents.md` together.

## Install

```nu
nu scripts/install.nu
```

Nothing is copied. The script creates symlinks, so a file edited in the
checkout changes what the tools read with no second step.

Nothing is replaced or deleted either. A path already in use is reported and
skipped, and repairing it is left to you.

It links two kinds of thing: the generated rules file, once per tool under the
name that tool expects, and each skill folder, one at a time, into the tool's
skills directory.

> ℹ️ **Note**
>
> Each skill is linked on its own, because linking the whole skills directory
> would hide the skills already in it from elsewhere.

### Supported Tools

| Tool | Rules file | Skills |
|---|---|---|
| `agents` | `~/.agents/AGENTS.md` | `~/.agents/skills/` |
| `claude` | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| `codex` | `~/.codex/AGENTS.md` | `~/.codex/skills/` |

### Flags

```nu
nu scripts/install.nu --tool claude     # one tool, rules and all skills
nu scripts/install.nu --skill tech-docs-writer   # one skill, no rules file
```
