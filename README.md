# tricky-agents

Personal configuration for AI coding agents. It holds three things:

- The rules every agent follows.
- The skills an agent loads for a specific job.
- The scripts that build and install both.

## Requirements

Built for Linux and not tested on any other system.
[Nushell](https://www.nushell.sh) is required to run the scripts.

## Install

To install the rules file and every skill, run this from the root of the
repository:

```nu
nu scripts/install.nu
```

The script creates symlinks to files in this repository. It never copies,
replaces or deletes a file.

- The rules file is linked once per tool, under the name that tool expects.
- Each skill folder is linked into the tool's skills folder.

> ℹ️ **Note**
>
> Skills are linked one by one, so skills from other sources stay in the
> tool's skills folder.

### Report

The script prints a report with one row per link. The `action` column shows
the status of each link.

| Status    | Meaning                                                  |
| --------- | -------------------------------------------------------- |
| `created` | The script made the link.                                |
| `ok`      | The link was already there. Nothing changed.             |
| `blocked` | Something else is at the path. The script left it alone. |

For a `blocked` row, the `reason` column says what is at the path. It is
either a symlink to another place or a real file or folder. Clear the path,
then run the script again.

### Supported Tools

The script installs for every tool below. It creates a tool's folder when it
is missing, even for a tool you do not use.

| Tool     | Rules file            | Skills              |
| -------- | --------------------- | ------------------- |
| `agents` | `~/.agents/AGENTS.md` | `~/.agents/skills/` |
| `claude` | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| `codex`  | `~/.codex/AGENTS.md`  | `~/.codex/skills/`  |

### Flags

Optional flags:

| Flag              | Effect                                                |
| ----------------- | ----------------------------------------------------- |
| `--tool <tool>`   | Install for one tool only. The default is every tool. |
| `--skill <skill>` | Install one skill only, and skip the rules file.      |

A new skill reaches the tools only after the script links it. `--skill` links
just that one.

**Example**

```nu
nu scripts/install.nu --tool claude
nu scripts/install.nu --skill tech-docs-writer
```

## Layout

Each top-level folder holds one kind of file.

| Path       | What it holds                                        |
| ---------- | ---------------------------------------------------- |
| `global/`  | The rule sources and the rules file built from them  |
| `skills/`  | Global skills, one folder each                       |
| `scripts/` | Build, install, and worktree scripts                 |
| `chats/`   | Chat personalisation for ChatGPT mobile and Grok web |
| `docs/`    | Documentation about skills                           |

## Rules Files

`global/global-agents.md` is linked as the global instructions for every
supported tool, for example `~/.agents/AGENTS.md`. It is built from two files:

1. `global/machine-rules.md`
2. `global/personal-rules.md`

> ⚠️ **Warning**
>
> The next build overwrites any hand edit to `global-agents.md`.

Changing a rule takes three steps.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run `nu scripts/build-global-agents.nu`.
3. Commit the source and `global-agents.md` together.

### Machine Rules

`machine-rules.md` holds defaults for any project:

- Decision policy.
- Change discipline.
- Safety.
- Tools and workflows.

### Personal Rules

`personal-rules.md` holds how agents work with the author:

- Who the author is and how they read.
- Writing, structure and formatting.
- Options, proposals and scope.
- Errors, feedback and disagreement.
- Short replies and agent status lines.

## Skill Documentation

- [agent-setup-helper](docs/agent-setup-helper.md) — designing, reviewing and
    safety-checking skills and `AGENTS.md` files.
- [tech-docs-writer](docs/tech-docs-writer.md) — writing, reviewing and
    formatting human-facing documentation.
