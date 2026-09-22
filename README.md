# tricky-agents

Personal configuration for AI coding agents. It holds three things:

- The rules every agent follows.
- The skills an agent loads for a specific job.
- The scripts that build and install both.

## Requirements

Built for Linux and not tested on any other system.
[Nushell](https://www.nushell.sh) is required to run the scripts.

## Layout

| Path       | What it holds                                               |
| ---------- | ----------------------------------------------------------- |
| `global/`  | Source files for the global `AGENTS.md`                     |
| `skills/`  | Global skills, one folder each                              |
| `scripts/` | Build, install, and worktree cleanup                        |
| `chats/`   | Per-service chat personalisation — ChatGPT mobile, Grok web |
| `docs/`    | Documentation about skills                                  |

## Skill Documentation

- [agent-setup-helper](docs/agent-setup-helper.md) — designing, reviewing and
    safety-checking skills and `AGENTS.md` files.
- [tech-docs-writer](docs/tech-docs-writer.md) — writing, reviewing and
    formatting human-facing documentation.

## Rules Files

`global/` holds:

- `machine-rules.md` — hand-edited
- `personal-rules.md` — hand-edited
- `global-agents.md` — generated from the other two

**`machine-rules.md`** — defaults that apply to any project:

- Decision policy.
- Change discipline.
- Safety.
- Tools and workflows.

**`personal-rules.md`** — response rules, formatting preferences, and who the
author is.

**`global-agents.md`** — the build joins the two sources under a banner and
drops every heading one level, so both sit under it as peers.

> ⚠️ **Warning**
>
> Never hand-edit `global-agents.md` — the next build overwrites it.

Changing a rule takes three steps.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run `nu scripts/build-global-agents.nu`.
3. Commit the source and `global-agents.md` together.

## Install

To install the global rules and every skill, run:

```nu
nu scripts/install.nu
```

The script does:

1. Link the generated rules file, once per tool, under the name that tool
    expects.
2. Link each skill folder on its own, into the tool's skills directory.

It does not:

1. Copy anything.
2. Replace or delete anything.

Because it links rather than copies, a file edited in the checkout changes what
the tools read with no second step. A path already in use is reported and
skipped, and repairing it is left to you.

> ℹ️ **Note**
>
> Each skill is linked on its own, because linking the whole skills directory
> would hide the skills already in it from elsewhere.

### Supported Tools

| Tool     | Rules file            | Skills              |
| -------- | --------------------- | ------------------- |
| `agents` | `~/.agents/AGENTS.md` | `~/.agents/skills/` |
| `claude` | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| `codex`  | `~/.codex/AGENTS.md`  | `~/.codex/skills/`  |

### Flags

| Flag              | Effect                                                |
| ----------------- | ----------------------------------------------------- |
| `--tool <tool>`   | Install for one tool only. The default is every tool. |
| `--skill <skill>` | Install one skill only, and skip the rules file.      |

```nu
nu scripts/install.nu --tool claude
nu scripts/install.nu --skill tech-docs-writer
```
