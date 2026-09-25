# tech-docs-writer

This skill lets an agent write and review documents.

It covers:

- README files.
- Code and CLI references.
- Tutorials and how-to guides.
- Workflow documents.
- Troubleshooting, maintainer and personal notes.

It does not cover:

- Agent instruction files, such as `SKILL.md`, `AGENTS.md` and `CLAUDE.md`.
    Use `agent-setup-helper` for these.
- Application code.
- Marketing and product copy.

## Start

Ask your agent to write or review a document. Name the file, or the subject if
the document does not exist yet.

**Example**

```text
Existing file  "Review docs/enemy-spawner.md."
New document   "Write a how-to for adding a new enemy type."
```

The skill does one of two jobs:

- **Write** — creates a document, or edits one you already have.
- **Review** — lists the problems in a document and changes nothing.

Before it writes anything, the skill needs to know the document type and the
reader. If your request does not say them, it asks.

## Document Types

The type decides which sections the document has, and in which order. The
skill picks one main type from what the reader needs first.

The skill knows these types:

| Type            | Purpose                                      |
| --------------- | -------------------------------------------- |
| README          | Shows a reader the project and the next step |
| Code Reference  | Lists public functions, classes and symbols  |
| CLI Reference   | Lists commands, options and effects          |
| Instructions    | Tutorial: one guided task on a safe path     |
| How-to          | Leads to one goal, even in a `README.md`     |
| Workflow        | Lists the steps of a process, by role        |
| Explanation     | Explains a concept, cause or design choice   |
| Troubleshooting | Leads from a symptom to a safe fix           |
| Maintainer      | Helps contributors change the project        |
| Personal        | Keeps the owner's own notes                  |

## Questions

The skill asks two questions for every document, unless your request already
answers them:

- Which type is it?
- Who is the reader?

Some types need more. The skill asks only for what your request does not
already say:

| Type           | Also needed                                                        |
| -------------- | ------------------------------------------------------------------ |
| README         | What the project is for, who visits, the next thing they do        |
| Code Reference | The code to check against, the language, which symbols are public  |
| CLI Reference  | The command, how to get its help output, which commands to cover   |
| Instructions   | Where the learner starts, what they end with, a safe place to work |
| How-to         | What the reader can already do, the goal, their real environment   |
| Workflow       | The roles, what starts it, how it ends, its owner, its intent      |

The skill asks one question at a time, and only about something that changes
the document. It never asks again for what you already said.

For a workflow:

- The owner is the person or document that decides how the process runs.
- The intent is prescriptive or descriptive. A prescriptive document says how
    the process must run. A descriptive one records how it runs now.

The skill also asks where the document will be shown, but only when it will use
tables, callouts or similar syntax. Not every Markdown viewer shows them. It
asks what the document must cover only when your request is open-ended, such
as "document this project".

It prefers a guess you can confirm over an open question, because a guess is
easier to answer.

**Example**

```text
Open question     "Who is the reader?"
Guess to confirm  "This reads like a how-to for someone who already has the
                  tool installed. Correct?"
```

### Assumptions

The skill stops asking and chooses for you when:

- You say "you decide".
- Your answer is too vague to use.
- No one is there to answer, such as in an unattended run.

It then:

1. Chooses a value for every missing answer.
2. Lists each choice in its reply, under the heading `Assumptions`.
3. Says that the final result is yours to check.
4. Continues without waiting.
5. Offers once to add the assumptions to the document as `REVIEW` markers.

The skill never fills a missing answer without listing it. The list is what
lets you find a choice and correct it.

It adds `REVIEW` markers only if you accept that offer. Each marker sits at the
passage it affects. It is a temporary note for you to check and remove, not part
of the document.

**Example**

```markdown
> [!REVIEW]
> Assumed reader: a maintainer who knows Git.
```

## Writing

In a document you already have, the skill edits only the part you asked it to
change. It lists problems in the rest of the document in its report, and does
not fix them.

**Example**

You ask it to tighten the Install section. It edits only that section. A
problem it sees in Usage appears in the report under Outside The Task.

It keeps a structure the project already uses, unless you approve a change. It
renames a heading only when the heading is wrong. A rename breaks the links to
that section.

Before you see the result, the skill:

1. Plans the sections.

    Each section answers one question the reader has. A fact that fits no
    section means the plan is wrong, and the skill changes the plan.

2. Checks each sentence it wrote or changed.

    It cuts a sentence that gives the reader nothing to do, see, use or
    understand. It also cuts a sentence that repeats another. When it is not
    sure you need a fact, it keeps the fact. Extra text is easy to see and cut
    later. A missing fact is not.

3. Rewrites sentences about internal parts from the reader's side.

    A sentence about an internal stage or check becomes one about what the
    reader does, sees or gets. Every fact and condition in the sentence stays.

    **Example**

    ```text
    Before  The spawner checks the wave budget before each spawn, so a wave
            that exceeds it is truncated.
    After   Each enemy spawns only while the wave is under its budget.
            Enemies past the budget in the wave list do not spawn.
    ```

4. Gives the document to a cold reader.

    A cold reader is a second agent. It sees only the document, one line
    naming its intended reader, and what that reader already knows, such as
    "a maintainer who knows Git". It asks about what it could not understand,
    and changes nothing. The skill checks
    each question against the source. It fixes the document where the source
    has the answer.

5. Runs a fixed set of searches and counts, and fixes what they find.

    A search has to be run. A question such as "is this clear?" is easy to
    answer without checking. The set includes these checks:

    - Words that point back without naming, such as "the other".
    - Tables with no sentence before them.
    - Sentences over 25 words.
    - Headings written as a question or a sentence.
    - Paths from one machine, such as a home folder.

The cold reader exists because the skill has read the source. It cannot see
what a reader without the source would miss. The cold reader runs once for each
Write, and not again after the fixes. The skill skips it for an edit that
changes no meaning, such as a typo fix.

> ℹ️ **Note**
>
> The cold reader needs an agent that can start another agent, as Claude Code
> can. Without one, the report says "not checked by a cold reader".

### Report

After the document, the skill adds a report to its reply. The report does not
go into the document. It has these blocks, in this order, and leaves out any
block that is empty:

| Block            | What it lists                                                            |
| ---------------- | ------------------------------------------------------------------------ |
| Cuts             | Each fact the skill removed, by section, with the reason                 |
| Cold Reader      | Each question from the cold reader, as fixed, open or known from context |
| Outside The Task | Problems in sentences you did not ask it to change                       |
| Not Checked      | Checks that did not run, and claims the skill could not verify           |

A cold reader question stays open when the source does not answer it. The
report says why it is open.

A question is known from context when the reader already knows the answer,
such as a standard term of their field. The page does not change for it, and
the report says what covers it.

## Reviewing

A review gives you a list of problems, called findings. It does not change or
save any file. The findings stay in the conversation.

A review needs the reader too. If you cannot name the reader, the skill reviews
against the reader the document seems to be written for. It then reports the
unclear reader as a finding. A document that does not make its reader clear has
a real defect.

A review also runs the cold reader. A question that shows a missing fact or an
unclear sentence becomes a finding. A review also says what it could not check.

### Findings

Each finding has a severity:

| Severity           | Meaning                                                                  |
| ------------------ | ------------------------------------------------------------------------ |
| 🔴 High Severity   | Stops the reader from succeeding, leads to an unsafe action, or misleads |
| 🟡 Medium Severity | Confuses, slows the reader down, or leaves an important gap              |
| 🟢 Low Severity    | Polish, consistency, or a small readability problem                      |

A finding in full has a short heading, its severity, and the problem. It adds
only the details that help, such as:

- Where the problem is.
- The evidence.
- The effect on the reader.
- A direction for the fix.

The five most severe findings come in full. Each other finding comes as one
line: its severity, the passage, and the problem. Ask for any line to see it in
full.

You can fix a finding, keep the text on purpose, or reject the finding. The
skill marks a finding only after you answer it:

- `✅ Accepted` — you fixed it, or you said the text is intentional.
- `⛔ Declined` — you rejected it. The skill does not raise it again in the same
    conversation unless it finds new evidence.

### Applying Findings

To apply a finding, ask for it. The skill then edits the document as a Write.
It applies only the findings you name. Accepting one finding does not start a
rewrite of the whole document.

**Example**

You ask: "Review this and fix the worst part." The skill:

1. Reviews the document.
2. Shows you the findings.
3. Waits for you to name the findings to apply, and applies only those.

### Questioned Claims

When you ask whether a claim is true, the skill checks the claim against the
source and answers you. It does not weaken or remove a correct claim because
you asked. It changes the wording only when the wording caused your doubt.

**Example**

You ask whether the dodge really gives 0.3 seconds of invulnerability. The skill
reads the dodge code. If the code says 0.3 seconds, it tells you so, and the
claim stays.

### Self-Review

The skill may review a document it wrote earlier in the same conversation. It
tells you when that happens, and checks every claim against the source again.
A claim was as likely to be wrong when the skill wrote it as it is now.

## Fact Checking

The skill labels each claim by how well it could check it:

| Label      | Meaning                                                    |
| ---------- | ---------------------------------------------------------- |
| Fact       | Confirmed by an authority, a safe test, or the tool's help |
| Assumption | Inferred from context, not confirmed                       |
| Unknown    | Not available, or not safe to check in this task           |

An authority is what decides whether a claim is true, such as the current code
of a tool.

A claim the skill could not check never reaches you as Fact. You see a label
where a claim falls short of Fact:

- Each Unknown claim appears under Not Checked in the report.
- An unconfirmed workflow is marked as Assumption in the document itself.

For a claim about code, the skill uses the best check the agent has:

| Check                                 | Best label                                     |
| ------------------------------------- | ---------------------------------------------- |
| A language server (LSP) tool          | Fact                                           |
| The tool's own help, such as `--help` | Fact                                           |
| Reading the source files              | Fact if the source is clear, Assumption if not |
| None of these                         | Unknown, or the skill asks you                 |

The skill uses an LSP tool when the agent has one. It does not ask you to
install one during a task.

An older document is not proof. It shows what someone once wrote, not what the
code does now.

To check a claim, the skill prefers reading the code, help output, dry runs and
validation modes.

> ℹ️ **Note**
>
> The skill does not run a command that deletes or changes something only to
> improve a document.

## Formatting

The skill formats the document it writes. The bundled script is
`format-docs.nu`, described in Format Script. The skill uses the first of these
that applies:

| Situation                                | Result                                             |
| ---------------------------------------- | -------------------------------------------------- |
| The project's own formatter              | Formatted                                          |
| The bundled script, and a dprint config  | Formatted                                          |
| The bundled script, and no dprint config | Formatted with the fallback config, and it says so |
| No Nushell, or no dprint                 | Not formatted, manual checks only, and it says so  |

The skill never reports a document as formatted when it was not. It never
installs a formatter during a documentation task.

It formats only the document it writes. It never formats a folder, or a file it
reads for research. The bundled script refuses anything but one file, so dprint
cannot change a file the skill only reads.

> ⚠️ **Warning**
>
> Formatting is not a check.

After formatting, the skill confirms that headings, links, tables, callouts and
code fence languages are still right. When no formatter ran, this is the only
check.

### Format Script

`format-docs.nu` formats one Markdown document with dprint. You can run it
yourself.

It needs:

- [Nushell](https://www.nushell.sh).
- [dprint](https://dprint.dev).

Without Nushell the script cannot start, so no exit code covers that case.

Run it from the root of this repository. From another folder, give the path
where the skill is installed, such as
`~/.claude/skills/tech-docs-writer/scripts/format-docs.nu`.

```nu
nu skills/tech-docs-writer/scripts/format-docs.nu <file>
```

The script takes one argument and one flag:

| Input     | Meaning                                                           |
| --------- | ----------------------------------------------------------------- |
| `<file>`  | One document. The script refuses a folder or a glob pattern.      |
| `--check` | Reports whether the file needs formatting, and does not change it |

The script formats the file even when Git ignores it, because you chose that
file.

dprint looks for its own config file, `dprint.json`, `dprint.jsonc`,
`.dprint.json` or `.dprint.jsonc`. It searches the folder you run the script
in, then each folder above it. It can also use a global config file. See
`dprint --help` for where that file lives.

When dprint finds no config, the script runs it again with the bundled
fallback,
`skills/tech-docs-writer/assets/dprint.default.jsonc`. It prints a message on
stderr when it does this.

When dprint runs, with or without `--check`, the script prints a JSON record on
stdout:

```json
{
  "formatted": true,
  "config": "project",
  "file": "docs/tech-docs-writer.md"
}
```

The record has three fields:

- `formatted` — `true` when dprint finished without an error. With `--check`,
    `true` means the file is already formatted.
- `config` — `project` when dprint used a config it found itself, `fallback`
    when the script used the bundled one.
- `file` — the path you passed.

The script prints no record for exit 2 or 3, because dprint did not run.

The exit code gives the outcome:

| Exit | Meaning                                      |
| ---- | -------------------------------------------- |
| 0    | Formatted, or already formatted              |
| 1    | dprint reported an error                     |
| 2    | The argument is not one file, so nothing ran |
| 3    | dprint is not on `PATH`                      |
| 20   | `--check` found unformatted content          |
