# tricky-agents

Personal configuration for AI coding agents: the rules they follow, the skills
they can load, and the scripts that install both.

One author, one machine, Linux. Nothing here is written to be portable.

## What Is Here

| Path | What it holds |
|---|---|
| `global/` | The rules every agent reads, as two sources and one generated file |
| `skills/` | One folder per skill, each with a `SKILL.md` |
| `scripts/` | Nushell scripts that build, install, and clean up |
| `chats/` | Per-service chat personalisation — ChatGPT mobile, Grok web |
| `docs/` | Documentation about this repository |
| `tmp/` | Scratch for work in progress, ignored by git |

`chats/` and `docs/` are reserved and currently empty.

## The Rules File

Two hand-edited sources merge into one generated file.

```text
global/machine-rules.md    ┐
                           ├─→  global/global-agents.md
global/personal-rules.md   ┘
```

`machine-rules.md` holds defaults that apply to any project: decision policy,
change discipline, safety, tooling. `personal-rules.md` holds the author's own
preferences: how answers should be written, structured, and scoped.

> ⚠️ **Warning**
>
> Never hand-edit `global/global-agents.md` — the next build overwrites it.

Edit a source, then rebuild:

```nu
nu scripts/build-global-agents.nu
```

The generated file is committed, so the rebuilt output goes in the same commit
as the source change.

## How Agents See It

`install.nu` symlinks the generated file into each tool's configuration
directory. There is no copy and no deploy step: the file in the checkout is the
file the tools read.

```text
~/.agents/AGENTS.md   ┐
~/.claude/CLAUDE.md   ├─→  global/global-agents.md
~/.codex/AGENTS.md    ┘
```

Skills are linked one folder at a time, because a tool's skills directory also
holds folders from elsewhere.

## Scripts

All scripts are Nushell and assume this repository's layout.

| Script | What it does |
|---|---|
| `build-global-agents.nu` | Merges the two rule sources into the generated file |
| `install.nu` | Creates the symlinks for rules and skills |
| `worktree-cleanup.nu` | Removes a finished worktree and its branch |

They share four exit codes: `0` done, `1` error, `2` refused, `3` partial. A
refusal means the request was valid and a safety rule declined it, so it prints
a plain block rather than an error box.

## Working On This Repo

The primary checkout stays on `main`, because its `global-agents.md` is the live
file. Changes happen in a worktree beside it.

`AGENTS.md` has the full workflow: worktree rules, the build-before-commit
order, commit format, and how cleanup decides what is safe to delete. Read it
before changing anything.
