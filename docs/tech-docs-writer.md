# tech-docs-writer

This skill writes and reviews documentation meant for people to read.

## Scope

The line is who reads the file, not what the file is about.

| In scope                                       | Out of scope                         |
| ---------------------------------------------- | ------------------------------------ |
| README, code and CLI reference                 | `SKILL.md`, `AGENTS.md`, `CLAUDE.md` |
| Tutorials, how-to guides, workflow documents   | Agent instruction files of any kind  |
| Troubleshooting, maintainer and personal notes | Application code                     |
| Reviewing documentation, including your own    | Marketing and product copy           |

This repository holds both kinds side by side. `README.md` is in scope, and
the `SKILL.md` two folders away is not. Agent instruction files go to
`agent-setup-helper`.

## Write And Review

The skill does two things, and keeps them apart.

- **Write** — produces or edits a document.
- **Review** — produces findings and nothing else.

A review leaves no edited file behind, and no corrected version quoted in the
reply either. Applying a finding is a Write, so you have to ask for it.

Accepting one finding does not authorise a rewrite. Ask for "review this and
fix the worst part" and it reviews first, shows the findings, and changes only
the ones you name.

## The Context Gate

The gate is a check that runs before drafting. The skill will not write until
it knows the document's mode and who reads it.

It asks one question at a time, and only about things that change the
document. Where it can guess, it offers the guess for you to confirm:

```text
Weak    "Who is the reader?"
Strong  "This reads like a how-to for someone who already has the tool
         installed. Correct?"
```

Say "you decide", answer vaguely, or leave it running unattended, and it
chooses for itself. It then lists the choices under `Assumptions`, says the
result is yours to correct, and continues without waiting.

It never assumes silently. The assumption block is what makes a wrong guess
cheap to fix.

## Document Modes

The mode decides the document's shape. The skill picks it from what the reader
needs to do.

| Reader need                             | Mode           |
| --------------------------------------- | -------------- |
| Orient a repository visitor             | README         |
| Look up a source-level symbol           | Code Reference |
| Look up a command                       | CLI Reference  |
| Learn by completing a guided experience | Instructions   |
| Complete a known goal                   | How-to         |
| Follow a repeated multi-party process   | Workflow       |

Four secondary modes — explanation, troubleshooting, maintainer and personal —
cover documents that fit none of the six.

Each mode adds its own required context on top of the reader. A Workflow needs
the roles, the trigger, the terminal state, and who owns the process.

## Source Verification

Every claim carries a confidence label, and the label comes from how the claim
was checked.

| Label      | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| Fact       | Confirmed by an authority, a safe test, or generated help |
| Assumption | Inferred from context, not confirmed                      |
| Unknown    | Unavailable or unsafe to verify in this task              |

Reading the source earns Fact when the source is unambiguous, and generated
help such as `--help` earns it too. When there is nothing to check against,
the claim reaches you marked Unknown rather than dressed up as verified.

An older README is not proof. A document is evidence of what someone once
wrote, not of what the code does now.

> ⚠️ **Warning**
>
> The skill will not run a destructive or state-changing command just to
> improve a document.

A workflow document has no implementation to read, so its authority is a named
process owner or a policy document. With neither, every step is labelled an
Assumption and the document says so.

## Reviews

A review gives you at most five findings by default. Ask for more to get more.

Each finding carries its severity as a word, not only as a colour.

| Mark      | Meaning                                                  |
| --------- | -------------------------------------------------------- |
| 🔴 High   | Blocks reader success, causes unsafe action, or misleads |
| 🟡 Medium | Confuses, slows down, or leaves an important gap         |
| 🟢 Low    | Polish, consistency, minor readability                   |

Within one conversation, `✅ Accepted` marks a finding you resolved or judged
intentional, and `⛔ Declined` marks one you rejected. A declined finding does
not come back without new evidence.

### Self-Review

A document the skill drafted earlier in the same session gets the same
treatment as a stranger's, and the reply says that it is reviewing its own
work.

Memory of writing a line is not evidence the line was right. A claim was as
likely to be wrong when it was written as it is now.

## Formatting

Formatting runs through `dprint`, and both it and Nushell are optional. The
skill checks for them rather than assuming, and what it finds decides what it
is allowed to claim.

| Situation                                    | Result                        |
| -------------------------------------------- | ----------------------------- |
| Project formatter, configured by the project | Formatted                     |
| Bundled script, project `dprint` config      | Formatted                     |
| Bundled script, bundled fallback config      | Formatted, fallback disclosed |
| `nu` or `dprint` missing                     | Not formatted, disclosed      |

On this machine `dprint` resolves `~/.config/dprint/dprint.jsonc`, so the
second row is what runs and the script reports `config: project`. That field
says `dprint` found a config on its own, not that the config belongs to the
repository.

The bundled script formats one file at a time. Never a directory, and never
source material it is only reading.

`scripts/format-docs.nu` reports what happened and decides nothing itself:

| Exit | Meaning                             |
| ---- | ----------------------------------- |
| 0    | Formatted, or already formatted     |
| 20   | `--check` found unformatted content |
| 3    | `dprint` is not on `PATH`           |
| 1    | `dprint` reported an error          |

To check a document without changing it:

```nu
nu skills/tech-docs-writer/scripts/format-docs.nu --check docs/tech-docs-writer.md
```

Formatting is not validation. A pass through `dprint` fixes spacing and table
alignment, but it cannot tell whether a heading level survived or a relative
link still resolves, so a checklist runs after it.

> ℹ️ **Note**
>
> The skill never installs a formatter as part of a documentation task.

## Known Limits

- It will not touch `SKILL.md`, `AGENTS.md` or `CLAUDE.md`. Those go to
    `agent-setup-helper`.
- A file named `README.md` may really be a how-to guide. The name is evidence,
    not the decision.
- Without a code intelligence tool it falls back to reading source directly.
    An ambiguous source then stops short of Fact.
- A review lives in the conversation. Nothing is saved to come back to later.
