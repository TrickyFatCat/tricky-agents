# tech-docs-writer

This skill writes and reviews technical documentation.

It handles:

- READMEs.
- Code and CLI references.
- Instructions (tutorials) and how-to guides.
- Workflow documents.
- Troubleshooting, maintainer and personal notes.

It does not handle:

- Agent instruction files — `SKILL.md`, `AGENTS.md`, `CLAUDE.md`.
- Application code.
- Other types of documentation, such as marketing and product copy.

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

Before it shows you the result, it reads the finished document again as a reader
would and fixes what it finds. Each check in this pass is a search or a count,
because a check phrased as a quality to confirm tends to get confirmed without
being run.

### Review

Review produces findings. It does not edit the reviewed file.

Applying a finding is a Write, so it happens only when you ask. Name one
finding and it changes that one, leaving the rest of the document alone.

**Example**

Ask for "review this and fix the worst part" and it reviews first, shows the
findings, and waits for you to say which one to fix.

A review stays in the conversation. It gives you at most five findings. Ask for
more if you need them.

Each finding carries a severity:

| Mark      | Meaning                                                  |
| --------- | -------------------------------------------------------- |
| 🔴 High   | Blocks reader success, causes unsafe action, or misleads |
| 🟡 Medium | Confuses, slows down, or leaves an important gap         |
| 🟢 Low    | Polish, consistency, minor readability                   |

When you answer a finding, it closes with one of two marks:

- `✅ Accepted` — you fixed it, or you chose to keep it.
- `⛔ Declined` — you rejected it. It is not raised again in the same
    conversation unless there is new evidence.

#### Self-Review

If the document under review is one the skill wrote earlier in the same
conversation, it says so and checks every claim against the source again.

Memory of writing the document is not a check. A mistake made while writing can
still be there.

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

The skill stops asking and chooses for you when:

- You say "you decide".
- Your answer is too vague to use.
- No one is there to answer.

It then:

1. Chooses a value for every open question.
2. Lists those choices under `Assumptions`.
3. Says the result is yours to correct.
4. Continues without waiting.
5. Offers once to add the assumptions to the document as `REVIEW` markers.

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

> ℹ️ **Note**
>
> A file called `README.md` that walks you through one task is a how-to guide,
> and the skill treats it as one.

### Additional Context

Every document needs its reader. Beyond that, each type requires different
additional context:

| Type            | Additional Context                                                        |
| --------------- | ------------------------------------------------------------------------- |
| README          | Project purpose, the visitor, their next action                           |
| Code Reference  | Source of truth, language, which symbols are public                       |
| CLI Reference   | The command, its help output, which commands to cover                     |
| Instructions    | Starting state, the outcome, a safe environment                           |
| How-to          | Reader's competence, the goal, the real environment                       |
| Workflow        | Roles, trigger, end state, process authority, prescriptive or descriptive |
| Explanation     | Nothing more                                                              |
| Troubleshooting | Nothing more                                                              |
| Maintainer      | Nothing more                                                              |
| Personal        | Nothing more                                                              |

A symbol is a named thing in code, such as a function or a class. The source of
truth is what the reference is checked against.

## Confidence Labels

Every claim gets one of three labels, and the label says how well the skill
could check it:

| Label      | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| Fact       | Confirmed by an authority, a safe test, or generated help |
| Assumption | Inferred from context, not confirmed                      |
| Unknown    | Unavailable or unsafe to verify in this task              |

To earn Fact, the skill goes to the source. It reads the code, or runs the
tool's own help such as `--help`. A claim it cannot check that way never
reaches you as Fact.

**Example**

An older README is not proof. It is evidence of what someone once wrote, not
of what the code does now.

> ℹ️ **Note**
>
> The skill will not run a destructive or state-changing command just to
> improve a document.

### When It Cannot Reach Fact

Two cases stop a claim from reaching Fact.

**No Code Intelligence Tool**

A code intelligence tool looks up definitions, symbols and call sites in code.
Without one, the skill reads the source directly. If the source is ambiguous,
the claim does not reach Fact.

**A Workflow Document**

There is no implementation to read. The authority is a named process owner or
a policy document, and with neither, every step is labelled an Assumption.

## Formatting

The skill formats what it writes with [dprint](https://dprint.dev), a code
formatter, run through a bundled [Nushell](https://www.nushell.sh) script,
`scripts/format-docs.nu`.

Both tools are optional, and the skill checks for them first.

> ℹ️ **Note**
>
> The skill never installs a formatter as part of a documentation task.

`dprint` finds its own configuration file. If it finds none, the script uses
the bundled fallback, `skills/tech-docs-writer/assets/dprint.default.jsonc`.

What the skill finds decides what it is allowed to claim:

| Situation                                 | Result                                            |
| ----------------------------------------- | ------------------------------------------------- |
| The project has its own formatter         | Formatted                                         |
| `format-docs.nu` with a `dprint` config   | Formatted                                         |
| `format-docs.nu` with its fallback config | Formatted, fallback disclosed                     |
| `nu` or `dprint` missing                  | Not formatted, manual checks only, and it says so |

The skill formats only the document it is writing, never the files it reads
for research. The script takes one file, never a directory.

To check a document without changing it:

```nu
nu skills/tech-docs-writer/scripts/format-docs.nu --check <file>
```

The script reports the outcome through its exit code:

| Exit | Meaning                             |
| ---- | ----------------------------------- |
| 0    | Formatted, or already formatted     |
| 1    | `dprint` reported an error          |
| 3    | `dprint` is not on `PATH`           |
| 20   | `--check` found unformatted content |

Formatting is not validation. `dprint` fixes spacing and table alignment, but
it cannot tell whether headings keep their level or links still resolve. The
skill runs its own checklist after formatting.
