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

The skill aims for a document that gives its reader what they need to act or
decide, and nothing else. Before it shows you the result, it:

1. Checks every sentence it wrote. It cuts a sentence that gives the reader
    nothing to do, see, use or understand.
2. Rewrites a sentence written from inside the subject, such as how a tool
    sorts its own steps. The new sentence says what the reader does, sees or
    gets. Every fact stays.
3. Gives the document to a cold reader: a second agent that has not seen the
    code or notes the document was written from. The cold reader lists what it
    could not understand.
4. Runs a set of checks. Each check is a search or a count, such as a search
    for "the other" where the text points back at items it does not name.
5. Fixes what steps 1 to 4 found.

Step 1 cuts a sentence only when the skill is sure you do not need it. When it
is not sure, it keeps the sentence. Extra text is easy to spot and cut. A
missing fact is not.

A check such as "is this clear?" is easy to pass without really checking. A
search or a count has to be done.

> ℹ️ **Note**
>
> The cold reader runs only where the agent can start another agent, as Claude
> Code can. Elsewhere the Not Checked block says "not checked by a cold reader".

When you ask it to change one section of your document, it changes only that
section. It reports problems in the rest of the document and does not fix them.

#### Reply

After the document, the reply can add these blocks. A block with nothing in it
is left out.

| Block            | What it holds                                           |
| ---------------- | ------------------------------------------------------- |
| Cuts             | Each fact the skill removed, by section, with a reason  |
| Cold Reader      | Each question from the cold reader, fixed or still open |
| Outside The Task | Problems in parts you did not ask it to change          |
| Not Checked      | Checks that did not run, and claims it could not verify |

An open question is a gap the skill could not fill from the source. The reply
says why. You can fill the gap yourself.

To restore a cut fact, quote its line from the Cuts block and ask for it back.

### Review

Review produces findings. It does not edit the reviewed file.

A review also runs the cold reader. A question that points to a missing fact or
an unclear sentence becomes a finding.

> ℹ️ **Note**
>
> A review stays in the conversation and has at most five findings, unless you
> ask for more.

Review mode does not apply changes. Use Write mode to do that. You can ask it to
apply specific findings.

**Example**

Ask for "review this and fix the worst part", and the skill:

1. Reviews the document.
2. Shows the findings.
3. Waits for you to say which one to fix.

#### Findings

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

Sometimes the skill reviews a document it wrote earlier in the same
conversation. When that happens, it tells you, and it checks every claim
against the source again.

It does not trust its memory of writing the document. It could have made a
mistake then.

## Context Gathering

The skill can ask you questions to gather important context, such as the
target audience and the type of document. The answers help it create a better
result.

It asks one question at a time, and only about things that change the
document. It can guess some details and ask you to confirm them.

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

### Fact Check Limits

Two cases make Fact harder to reach.

**No Code Intelligence Tool**

A code intelligence tool looks up definitions, symbols and call sites in code.
Without one, the skill reads the source directly. A clear source still gives
Fact. An ambiguous one does not.

**A Workflow Document**

There is no implementation to read. The authority is a named process owner or
a policy document. With either, a step can reach Fact. With neither, every step
is labelled an Assumption.

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
for research. The script takes one file. It refuses a directory or a glob
pattern, because `dprint` would format every file that matches.

To check a document without changing it:

```nu
nu skills/tech-docs-writer/scripts/format-docs.nu --check <file>
```

The script reports the outcome through its exit code:

| Exit | Meaning                             |
| ---- | ----------------------------------- |
| 0    | Formatted, or already formatted     |
| 1    | `dprint` reported an error          |
| 2    | Not a single file, so nothing ran   |
| 3    | `dprint` is not on `PATH`           |
| 20   | `--check` found unformatted content |

Formatting is not validation. `dprint` fixes spacing and table alignment, but
it cannot tell whether headings keep their level or links still resolve. The
skill runs its own checklist after formatting.
