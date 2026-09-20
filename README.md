# tricky-agents

Personal configuration for the AI coding agents on this machine. It holds three
things:

- The rules every agent follows.
- The skills an agent loads for a specific job.
- The scripts that build and install both.

## Requirements

- Linux.
- [Nushell](https://www.nushell.sh). Every script here is Nushell, with no
  fallback for another shell.
- Git.

## Layout

| Path | What it holds |
|---|---|
| `global/` | The rules every agent reads |
| `skills/` | One folder per skill, each with a `SKILL.md` |
| `scripts/` | Build, install, and worktree cleanup |
| `chats/` | Per-service chat personalisation — ChatGPT mobile, Grok web |
| `docs/` | Documentation about this repository |
| `AGENTS.md` | Rules for agents changing this repository |
| `tmp/` | Scratch, ignored by git |

## Rules Files

`global/` holds three files. Two are yours to edit, one is built from them.

**`machine-rules.md`** — hand-edited. Defaults that apply to any project:
decision policy, change discipline, safety, and which tools to use.

**`personal-rules.md`** — hand-edited. How an answer should be written,
structured, and scoped, and what the author works on.

**`global-agents.md`** — generated. The build joins the two sources under a
banner and drops every heading one level, so both sit under it as peers.

> ⚠️ **Warning**
>
> Never hand-edit `global-agents.md` — the next build overwrites it.

Changing a rule takes three steps.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run `nu scripts/build-global-agents.nu`.
3. Commit the source and `global-agents.md` together.

```text
global/machine-rules.md    ┐
                           ├─→  global/global-agents.md
global/personal-rules.md   ┘
```

## Install

```nu
nu scripts/install.nu
```

Nothing is copied. The script creates symlinks, so a file edited in the
checkout changes what the tools read with no second step.

It links two kinds of thing:

- The generated rules file, once per tool, under the name that tool expects.
- Each skill folder, one at a time, into the tool's skills directory. Linking
  that directory itself would hide the skills already in it from elsewhere.

| Tool | Rules file | Skills |
|---|---|---|
| `agents` | `~/.agents/AGENTS.md` | `~/.agents/skills/` |
| `claude` | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| `codex` | `~/.codex/AGENTS.md` | `~/.codex/skills/` |

Two flags narrow the run.

- `--tool claude` installs for one tool instead of all three.
- `--skill <name>` links one skill and leaves the rules files alone.

Nothing is replaced or deleted. A path already in use is reported and skipped,
and repairing it is a manual job. Run the script from the main checkout: links
point at whichever copy runs, so one made elsewhere dies with that copy.
