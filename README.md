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

The script creates links, not copies. A link points to a file in this
repository. The tools always read the current version of that file. The
script:

- Links the rules file once per tool, under the name that tool expects.
- Links each skill folder into the tool's skills folder.
- Never replaces or deletes anything.

> ℹ️ **Note**
>
> Linking the whole skills folder would hide the skills that other sources put
> there.

An edit to a skill reaches the tools at once. An edit to a rule source reaches
them only after the build in Rules Files.

A path that is already in use is left alone and shown as `blocked`. Fix it by
hand, then run the script again.

- Yellow: a link that points somewhere else. Deleting it loses nothing.
- Red: a real file or folder. It may hold the only copy of its content.

### Supported Tools

The script installs for these tools. The Tool column is the name `--tool`
takes.

| Tool     | Rules file            | Skills              |
| -------- | --------------------- | ------------------- |
| `agents` | `~/.agents/AGENTS.md` | `~/.agents/skills/` |
| `claude` | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| `codex`  | `~/.codex/AGENTS.md`  | `~/.codex/skills/`  |

Without `--tool`, the script installs for every tool in the table. It creates
a tool's folder when it is missing, even for a tool you do not use.

### Flags

Both flags are optional.

| Flag              | Effect                                                |
| ----------------- | ----------------------------------------------------- |
| `--tool <tool>`   | Install for one tool only. The default is every tool. |
| `--skill <skill>` | Install one skill only, and skip the rules file.      |

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
| `scripts/` | Build, install, and worktree cleanup                 |
| `chats/`   | Chat personalisation for ChatGPT mobile and Grok web |
| `docs/`    | Documentation about skills                           |

## Rules Files

The rules file every tool reads is `global/global-agents.md`. The build makes
it from two sources.

| File                | Edited       | Holds                               |
| ------------------- | ------------ | ----------------------------------- |
| `machine-rules.md`  | By hand      | Defaults for any project            |
| `personal-rules.md` | By hand      | The author and how to reply to them |
| `global-agents.md`  | By the build | Both sources joined                 |

`machine-rules.md` covers:

- Decision policy.
- Change discipline.
- Safety.
- Tools and workflows.

> ⚠️ **Warning**
>
> The next build overwrites any hand edit to `global-agents.md`.

Changing a rule takes three steps.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run `nu scripts/build-global-agents.nu`.
3. Commit the source and `global-agents.md` together.

## Skill Documentation

- [agent-setup-helper](docs/agent-setup-helper.md) — designing, reviewing and
    safety-checking skills and `AGENTS.md` files.
- [tech-docs-writer](docs/tech-docs-writer.md) — writing, reviewing and
    formatting human-facing documentation.
