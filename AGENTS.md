# AGENTS.md

Rules for working on this repository. They apply to every agent and to every
change, including one-line ones.

## Repository

A personal configuration repo: agent instructions, skills, and chat
configuration. One author, one machine, Linux.

All scripts are Nushell. They are written for this repository only — no
`--repo` flag, no support for bare repositories or other layouts.

## Files

| Path | Kind |
|---|---|
| `global/machine-rules.md` | Source, hand-edited |
| `global/personal-rules.md` | Source, hand-edited |
| `global/global-agents.md` | Generated, committed, never hand-edited |
| `skills/<name>/SKILL.md` | Source, one folder per skill |
| `scripts/*.nu` | Source |
| `chats/` | Source, per-service chat personalisation — ChatGPT mobile, Grok web |
| `docs/` | Documentation about this repository |

Never edit `global/global-agents.md`. Edit a source and rebuild.

## Merge Contract

`global-agents.md` is `machine-rules.md` followed by `personal-rules.md`, under
a generated-file banner naming both sources.

Every heading drops one level. The output carries no level-one heading, so the
two sources sit under the banner as peers.

### Section Names Must Be Distinct

The build compares every heading in one source against every heading in the
other and refuses when a pair looks alike. The check is fuzzy, not exact: a
heading contained in a longer one counts as a clash, so `Safety` and
`Safety Rules` stop the build.

Fix a clash by renaming one side. `--similarity` raises the threshold if the
match is a genuine false positive.

### Headings Stop At Level Five

A level-six heading cannot be demoted, so the build refuses rather than emit
seven hashes and silently turn the section into body text.

## Build Before Commit

The generated file is committed, so a commit that changes a source must carry
the rebuilt output. A commit must never hold a stale artifact.

```nu
nu scripts/build-global-agents.nu
```

Three steps, in order.

1. Edit `machine-rules.md` or `personal-rules.md`.
2. Run the build.
3. Commit the source and `global-agents.md` together.

## Worktrees

`global-agents.md` is symlinked into the live agent configuration, so whatever
sits in the primary checkout is what every agent on this machine reads. There is
no deploy step between the file and its effect.

```text
~/.agents/AGENTS.md   ┐
~/.claude/CLAUDE.md   ├─→  ~/Repos/tricky-agents/global/global-agents.md
~/.codex/AGENTS.md    ┘
```

**Primary checkout stays on main**

`~/Repos/tricky-agents` is the primary checkout. Editing sources there makes
unfinished work live immediately, so it stays on `main` and nothing meaningful
happens in it.

**Work happens in a worktree**

Beside the primary checkout, never inside it.

```nu
git worktree add -b <branch> ../tricky-agents-<branch>
```

Run that from the primary checkout. From anywhere else `../` resolves somewhere
else and nests the worktree quietly, so pass the absolute path instead.

A worktree has its own `global/global-agents.md`, so building inside it leaves
the live file alone. That isolation is the point.

An agent that starts in a worktree somewhere else creates a conforming one and
switches to it before making any change. After the first change it must not
relocate, because moving then strands the work: it stops and says where it is.
You may waive the location for that session.

**After the merge**

Update the primary checkout and the live file is current. No rebuild is needed
there, because the built file arrives with the merge.

**Cleaning up**

Update the primary checkout first. The merged check reads local `main`, so a
branch merged only on the remote still counts as unmerged.

```nu
nu scripts/worktree-cleanup.nu <worktree-path>
```

It refuses when the branch is `main`, when the target is the primary checkout,
when the worktree holds uncommitted, untracked or ignored files, when the path
resolves through a symlink, when the worktree is locked, or when the branch is
not merged into `main`. Pass `--abandon` to drop an unmerged branch on purpose.

The branch is deleted only if it still points at the head the worktree had, so a
commit added in the meantime is never discarded.

## Install Tooling

`install.nu` creates the symlinks. It never replaces anything: a path already in
use is reported and skipped, and repairing it is a manual job.

It refuses to run outside the primary checkout. Links point at the checkout the
script runs from, so a link made in a worktree would die when that worktree is
removed.

**Full run — the author's to start**

```nu
nu scripts/install.nu
```

Do not run this on the author's behalf.

**One skill — an agent may run this**

```nu
nu scripts/install.nu --skill <name>
```

Allowed after that skill is merged into `main`. The script resolves the checkout
from its own location, not from the working directory, so what matters is which
copy runs. An agent working in a worktree runs the primary checkout's copy.

```nu
nu <primary-checkout>/scripts/install.nu --skill <name>
```

It links the named skill and nothing else, and leaves the rules files alone.

## Commits

Conventional Commits, lower case, no trailing full stop.

| Type | Use for |
|---|---|
| `feat` | A new skill, script, or rule section |
| `fix` | Corrected behaviour in a script |
| `docs` | README, AGENTS.md, comments only |
| `refactor` | Restructuring with no behaviour change |
| `chore` | Config, gitignore, housekeeping |

Scope is the top-level area: `global`, `skills`, `scripts`, `chats`, `docs`.

```text
feat(skills): add combat-encounter-review
fix(scripts): refuse a level-six heading instead of emitting seven hashes
docs(agents): record the worktree workflow
```

A change to a rule source and its rebuilt output is one commit, not two.

## Exit Codes

Every script uses the same four.

| Code | Meaning |
|---|---|
| 0 | Done |
| 1 | Error — something was missing, malformed, or git failed |
| 2 | Refused — the request was valid and a safety rule declined it |
| 3 | Partial — some of the work was done |

An error prints Nushell's error box. A refusal prints a plain block, because it
is not a mistake.

| Script | Codes it produces |
|---|---|
| `build-global-agents.nu` | 0, 1, 2 |
| `install.nu` | 0, 1, 2, 3 |
| `worktree-cleanup.nu` | 0, 1, 2, 3 |

`install.nu` exits 3 when any row in its report is blocked.
`worktree-cleanup.nu` exits 3 when the worktree was removed but the branch was
kept.
