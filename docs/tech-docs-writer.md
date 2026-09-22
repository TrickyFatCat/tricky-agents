# tech-docs-writer

This skill writes and reviews technical documentation.

It handles:

- READMEs.
- Code and CLI references.
- Tutorials and how-to guides.
- Workflow documents.
- Troubleshooting, maintainer and personal notes.

It does not handle:

- Agent instruction files — `SKILL.md`, `AGENTS.md`, `CLAUDE.md`.
- Application code.
- Marketing and product copy.

**Example**

A Python library's `README.md` is in scope. The `CLAUDE.md` sitting beside it
in the same folder is not, and goes to `agent-setup-helper`.

## Modes

The skill works in one of two modes:

- **Write** — for writing and editing documents.
- **Review** — for reviewing documents you already have.

### Write

Write produces a new document, or edits one you already have. It gathers
context and picks a document type before it drafts anything.

### Review

Review produces findings. It does not edit the reviewed file.

Applying a finding is a Write, so it happens only when you ask. Name one
finding and it changes that one, leaving the rest of the document alone.

**Example**

Ask for "review this and fix the worst part" and it reviews first, shows the
findings, and waits for you to say which one to fix.

## Context Gathering

The skill asks questions before it drafts. Without the document type and the
reader it cannot choose a shape, so it does not start.

It asks one question at a time, and only about things that change the
document. Where it can guess, it offers the guess for you to confirm.

**Example**

```text
Weak    "Who is the reader?"
Strong  "This reads like a how-to for someone who already has the tool
         installed. Correct?"
```

If you say "you decide", answer vaguely, or are not there to answer, the
skill:

1. Chooses a value for every open question.
2. Lists those choices under `Assumptions`.
3. Says the result is yours to correct.
4. Continues without waiting.

> ℹ️ **Note**
>
> The skill never assumes silently.

## Document Types

The type decides the document's shape. Ten are available:

| Type            | For a reader who                       |
| --------------- | -------------------------------------- |
| README          | Is new to the repository               |
| Code Reference  | Looks up a source-level symbol         |
| CLI Reference   | Looks up a command                     |
| Instructions    | Learns by completing a guided task     |
| How-to          | Knows the tool and has a goal          |
| Workflow        | Follows a repeated multi-party process |
| Explanation     | Wants to understand a design choice    |
| Troubleshooting | Has a symptom and needs a fix          |
| Maintainer      | Contributes to the project             |
| Personal        | Is you, months later                   |

### What Each Type Needs

Every document needs its reader. Six types ask for more than that:

| Type           | Also needs                                          |
| -------------- | --------------------------------------------------- |
| README         | Project purpose, the visitor, their next action     |
| Code Reference | Source of truth, language, public-surface boundary  |
| CLI Reference  | The command, its help output, which commands count  |
| Instructions   | Starting state, the outcome, a safe environment     |
| How-to         | Reader's competence, the goal, the real environment |
| Workflow       | Roles, trigger, end state, who owns the process     |

The other four ask only for the reader and the subject.

> ℹ️ **Note**
>
> A file named `README.md` may really be a how-to guide. The name is evidence,
> not the decision.

## Confidence Labels

You can tell how far to trust any claim in the document, because every claim
carries a label.

| Label      | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| Fact       | Confirmed by an authority, a safe test, or generated help |
| Assumption | Inferred from context, not confirmed                      |
| Unknown    | Unavailable or unsafe to verify in this task              |

To earn Fact, the skill goes to the source. It reads the code, or runs the
tool's own help such as `--help`. A claim it cannot check that way reaches you
as Unknown rather than dressed up as verified.

> ⚠️ **Warning**
>
> The skill will not run a destructive or state-changing command just to
> improve a document.

**Example**

An older README is not proof. It is evidence of what someone once wrote, not
of what the code does now.

Two cases limit what the skill can confirm.

**No code intelligence tool**

It falls back to reading source directly, and an ambiguous source then stops
short of Fact.

**A workflow document**

There is no implementation to read. The authority is a named process owner or
a policy document, and with neither, every step is labelled an Assumption.

## Reviews

A review gives you at most five findings. If you want more, just ask.

Each finding carries a severity, written as a word:

| Mark      | Meaning                                                  |
| --------- | -------------------------------------------------------- |
| 🔴 High   | Blocks reader success, causes unsafe action, or misleads |
| 🟡 Medium | Confuses, slows down, or leaves an important gap         |
| 🟢 Low    | Polish, consistency, minor readability                   |

Two marks close a finding. `✅ Accepted` means you fixed it or meant it that
way, and `⛔ Declined` means you rejected it. A declined finding is not raised
again in the same conversation.

Findings live in the conversation. Nothing is written to a file, so anything
worth keeping has to be copied out.

### Reviewing Its Own Draft

Ask it to review a document it wrote earlier in the same conversation and it
says so, then checks every claim against the source again.

It does not trust its own memory of writing the document. A claim that was
wrong when it was written reads exactly the same in memory as a correct one.

## Formatting

The skill formats what it writes with [dprint](https://dprint.dev), run
through a bundled [Nushell](https://www.nushell.sh) script,
`scripts/format-docs.nu`.

Both tools are optional. The skill checks for them first, and what it finds
decides what it is allowed to claim:

| Situation                                 | Result                        |
| ----------------------------------------- | ----------------------------- |
| The project's own formatter               | Formatted                     |
| `format-docs.nu` with a `dprint` config   | Formatted                     |
| `format-docs.nu` with its fallback config | Formatted, fallback disclosed |
| `nu` or `dprint` missing                  | Not formatted, and it says so |

`dprint` locates its own configuration file, and the script does not
reimplement that search — see the
[dprint configuration docs](https://dprint.dev/config/). Only when `dprint`
reports that it found nothing does the script supply the bundled fallback.

The script formats one file, the one being written. Not a directory, and not
source material it is only reading.

It reports the outcome through its exit code:

| Exit | Meaning                             |
| ---- | ----------------------------------- |
| 0    | Formatted, or already formatted     |
| 20   | `--check` found unformatted content |
| 3    | `dprint` is not on `PATH`           |
| 1    | `dprint` reported an error          |

To check a document without changing it:

```nu
nu skills/tech-docs-writer/scripts/format-docs.nu --check <file>
```

Formatting is not validation. `dprint` fixes spacing and table alignment, but
it cannot tell whether a heading level survived or a relative link still
resolves, so a checklist runs after it.

> ℹ️ **Note**
>
> The skill never installs a formatter as part of a documentation task.
