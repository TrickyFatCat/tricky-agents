---
name: tech-docs-writer
description: >-
  Use when writing, drafting, editing or reviewing human-facing technical
  documentation — READMEs, code and CLI references, tutorials, how-to guides,
  and process or workflow documents. Use it for any request to write docs for
  a tool, script, library or process, to improve or restructure an existing
  document, or to review documentation someone else wrote, including checking
  whether documented behaviour still matches the source. Do not use it for
  agent instruction files such as SKILL.md, AGENTS.md or CLAUDE.md.
---

# Tech Docs Writer

A good document gives one named reader what they need to act or decide. This
skill writes and reviews such documents: READMEs, code and CLI references,
instructions, how-to guides and workflow documents.

Every rule has exactly one owner file. Where writing and reviewing need the
same rule, they load the same file.

## A Good Document

A good document gives one named reader what they need to act or decide.
Nothing else goes in.

Each sentence does one job for that reader:

- tells them what this part covers, so they can read it or skip it;
- tells them what to do;
- tells them what they will see, and what it means;
- gives a fact they need to use the subject, choose, or avoid a mistake;
- explains why, when the reason changes what they do or how they judge the
  subject.

An example shows one of these jobs on a concrete case. It repeats a claim on
purpose.

A lead-in names what follows. It does not summarise it.

An explanation stays on one question. Steps belong in a how-to guide, and
lookup detail belongs in a reference.

## Scope

The boundary is who reads the file, not what it is about.

| In scope                                          | Out of scope                         |
| ------------------------------------------------- | ------------------------------------ |
| README, code and CLI reference                    | `SKILL.md`, `AGENTS.md`, `CLAUDE.md` |
| Tutorials, how-to guides, workflow documents      | Agent instruction files of any kind  |
| Troubleshooting, maintainer and personal notes    | Application code                     |
| Reviewing documentation, including the user's own | Marketing and product copy           |

A `README.md` for a skills repository is in scope. That repository's
`SKILL.md` is not, even though they sit in the same folder. Route agent
instruction files to `agent-setup-helper`.

## Two Operations

The skill has exactly two operations, and they are separate.

**Write** produces or edits a document.

**Review** produces findings about a document. It produces nothing else.

Applying a finding is a Write operation and needs the user to ask for it. One
accepted finding does not authorise a rewrite of the document.

For a mixed request such as "review this and fix the worst part", review
first, present findings, and apply only the findings the user names.

This skill is self-contained. It loads only the seven references below, it
delivers a review in the conversation, and it has no audit mode and no saved
review artefact.

## Context Gate

Never draft while the document mode or the intended reader is unknown and
unstated.

Ask about what changes the document, one question at a time. When the user
defers the choice, says "you decide", answers vaguely, or cannot answer,
choose, state the choice explicitly, and continue. The user owns the final
result.

`references/context-gate.md` owns the required fields, the question order and
the assumption block.

## Structure

Build the structure before drafting. Decide what question each section
answers, in the reader's words, and write the section to answer that question.

**Example**

```text
Section     Question it answers
Install     How do I get it running?
Report      What does each status mean?
Limits      When will this not work for me?
```

The question is a planning note, not the section's heading.

A section that answers no question does not belong. A fact that fits no
section means the structure is wrong, not that the fact is worthless.

Two sections that answer the same question merge into one. A reader who finds
the first stops looking and never reaches the second.

Explain a rule by its reason, not only by its mechanics. The reason is usually
already written in the source.

Do not explain the category the document belongs to. Someone reading a tool's
documentation already knows what a tool is.

A sentence you have had to explain twice is in the wrong place or the wrong
shape. Fix the structure before rewording it again.

After drafting, check that each section still answers its question.

## Reader Tests

Run both tests on every sentence the task writes or changes.

In an existing document, the tests edit only the sentences the task writes or
changes. For every other sentence, report what the tests find as a finding in
the reply. Do not edit it.

### Job Test

Name the sentence's job from the list in A Good Document.

- A sentence with no job goes.
- A sentence whose job another block already does has no job. A sentence that
  repeats the table beside it, or the index entry above it, is one.
- When you are not sure the reader needs the fact, keep the sentence.
  Low-value text can be seen and cut later. A missing fact cannot be seen.
- A sentence with a job but no section to hold it means the structure is
  wrong. Fix the structure, and keep the sentence.

List every cut in the reply, as Before Delivering describes.

### View Test

Name the subject of the sentence: who or what does the verb. A passive
sentence hides its subject, so name the actor first.

When the subject is a part the reader never sees or touches, such as an
internal stage, a mode, a check or a classification, rewrite the sentence from
the reader's side: what they do, what they see, or what they get.

A reference passes this test. Its subjects are the commands, functions and
settings the reader uses.

Before rewriting, list the facts and conditions in the sentence. After
rewriting, check that each one is still there. The rewrite changes the
viewpoint, never the facts.

**Example**

```text
Source   The spawner checks the wave budget before each spawn, so a wave
         that exceeds it is truncated.
Facts    1 budget is checked   2 before each spawn   3 extra enemies do not spawn
Weak     A wave never has more enemies than its budget.            (2 lost)
Strong   Each enemy spawns only while the wave is under its budget.
         Enemies past the budget in the wave list do not spawn.    (1, 2, 3 kept)
```

The test catches three common shapes.

**Internal Logic**

A rule stated as the subject's internal logic does not tell the reader why it
matters to them. Lead with what the reader gets or does, then the mechanism.

```text
Weak    Without a save slot the game cannot store progress, so it does not
        start.
Strong  Choose a save slot so the game can keep your progress.
```

**Copied Instruction**

A sentence that tells a tool what to do belongs in that tool's own rules, not
in the document about it. The defect hides wherever the documented subject has
rules of its own, because an imperative copied from those rules still reads as
ordinary prose.

```text
Weak    So read each match before acting on it.
Strong  The scan gives you a list of candidates, not a verdict. Read each
        match yourself before you act on it.
```

**Missing Actor**

A rule names who performs it. Where the document and its subject can both act,
a rule with no actor leaves the reader deciding which one it means.

```text
Weak    The config is validated before the build.
Strong  The build script validates the config before it builds.
```

## Cold Reader

After every Write, a reader who has not seen the source reads the document.
Skip it only for an edit that changes no meaning, such as a typo fix. The
writer cannot run this check itself, because it has read the source.

1. Start a subagent. Give it only the finished document and the named reader:
   no source, no draft history and no skill rules.
2. Ask it to answer from the page alone:
   - What is this document for, and who is it for?
   - What do you do first?
   - What does each status or result mean?
   - Which terms or sentences did you not understand?
3. It returns questions only. It proposes no wording and edits nothing.
4. Check each question against the source:
   - a gap: add the missing fact;
   - a misreading: rewrite the sentence;
   - the source cannot answer it: label the claim Unknown, as
     `references/source-verification.md` requires.
5. Run the cold reader once per Write. Do not run it again after the fixes.
   Report each question in the reply as fixed or open.

When no subagent tool is available, skip the check and say "not checked by a
cold reader" in the reply. Never imitate the cold reader in your own context.

Review runs the cold reader too. `references/review-criteria.md` owns how.

## Mode Summary

| Reader need                             | Mode           |
| --------------------------------------- | -------------- |
| Orient a repository visitor             | README         |
| Look up a source-level symbol           | Code Reference |
| Look up a command                       | CLI Reference  |
| Learn by completing a guided experience | Instructions   |
| Complete a known goal                   | How-to         |
| Follow a repeated multi-party process   | Workflow       |

Secondary modes — explanation, troubleshooting, maintainer, personal — are
available and defined in `references/document-modes.md`.

## Routing

| Reference                            | Load when                                             |
| ------------------------------------ | ----------------------------------------------------- |
| `references/context-gate.md`         | Before drafting, whenever required context is missing |
| `references/document-modes.md`       | Selecting or adapting a document's shape              |
| `references/markdown-conventions.md` | Creating, editing or reviewing Markdown               |
| `references/cli-reference.md`        | Documenting commands, flags or shell workflows        |
| `references/code-reference.md`       | Documenting a source-level API                        |
| `references/source-verification.md`  | Any claim that can be checked against an authority    |
| `references/review-criteria.md`      | Review mode                                           |

## Capability Detection

Four capabilities are detected, never required.

```text
nu                  which nu           absent → skip the script, manual checks
dprint              script checks it   absent → exit 3, manual checks
code intelligence   tool list          absent → drop a verification rung
subagent            tool list          absent → skip the cold reader, say so
```

Check for `nu` before invoking the script, because the script cannot report
its own interpreter missing. The script owns the `dprint` check.

For code intelligence, look in the tool list for tools whose names carry
`lsp`, `definition`, `references`, `hover` or `symbols`. Use them when
present. Do not name a specific server, because the available bridges change.
Do not ask the user to install one during a task.

For a subagent, look in the tool list for a tool that starts another agent
with its own context, such as `Agent` or `Task`.

## Formatting

```text
1  Project formatter as the project configures it     → formatted
2  Bundled script, project dprint config              → formatted
3  Bundled script, bundled fallback config            → formatted, fallback disclosed
4  nu or dprint absent                                → manual checks, NOT formatted, disclosed
```

Rungs 2 and 3 run `nu scripts/format-docs.nu <file>`. It exits 0 when the file
is formatted, 20 when `--check` finds unformatted content, 3 when dprint is
absent, 2 when the argument is not a single file, and 1 on a dprint error. Its
stdout record reports whether the project or the bundled fallback config was
used.

Never report a document as formatted when it was not. Never install a
formatter as part of a documentation task.

Format only the document the task is writing. Never a directory, never source
material the task is reading.

After formatting, run the post-format checks in
`references/markdown-conventions.md`. Formatting is not validation.

## Before Delivering

Run the reader tests and the cold reader first. Then run each check below.
Each check is a search or a count, because a check phrased as a quality to
confirm gets confirmed without being run.

`references/review-criteria.md` states the same principle for facts: memory of
drafting is not verification. Prose is no different.

```text
Backward references   Search "the other", "those two", "the remaining"
Table lead-ins        Count the tables; each has a lead-in. Read each lead-in
                      alone; it names what the table lists
Examples              Search "for example", "for instance", quoted cases and paragraphs
                      holding two cases; each is labelled, adjacent ones distinctly;
                      the block after each example has its own heading or label; each
                      labelled example names a concrete case, not a general statement
Reasons               Search "because", "so" and "same reason"; point each reason at a
                      source line, or cut it
Behaviour claims      List each statement of what the subject does; point each at a
                      source line, or label it as Source Verification requires
States                For each status, result or indicator the subject shows, list
                      the full set the reader can meet from the source; each is
                      named as the reader sees it and says what it means
Placement             For each callout and example, name the paragraph it serves; it
                      sits directly after that paragraph
Section fit           Name the question each section answers; name the question each
                      paragraph and table answers; move a block whose question belongs
                      to another section
Order                 Name the first thing the reader does in the document and in
                      each section; it comes before descriptions and reference
                      detail, after the opening and the step's requirements
Terms                 List each name used in a heading, table or scope list; search the
                      rest for other words for it
Steps                 Search sentences joining three or more actions with commas; each
                      is a numbered list
Plain language        Count sentences over 25 words; split each. Search "so", "because"
                      and "which" in long sentences; split any sentence carrying two
                      ideas; list each idiom, and each term new to this reader that has
                      no definition
Definitions           List each definition the page gives; cut one for a term this
                      reader uses or a standard term of the field; each defined
                      word is the exact term, not a vaguer word for it
Orphan sentences      Read each section's first sentence with the heading hidden
Headings              Read each section heading this task wrote; one that starts with
                      How, When, Why, What or Where, or reads as a sentence, becomes a
                      short noun phrase. Step headings in how-tos and tutorials stay imperative
Environment           Search "/home/", "/Users/", "C:\", "this machine" and "on my"; each
                      becomes the setting that decides the outcome, or a placeholder
```

Fix what the pass finds before presenting the document. A defect fixed here is
not a finding to report. Cuts are still listed.

### Reply

After the result, the reply adds these blocks in this order. Leave out a block
that is empty.

1. **Cuts** — every fact the job test removed, grouped by section, one line
   each: the fact, and why it has no job.
2. **Cold Reader** — each question, marked fixed with what changed, or open
   with why.
3. **Outside The Task** — test findings on sentences the task did not change.
4. **Not Checked** — each check that did not run, such as the formatter or the
   cold reader, and each claim labelled Unknown.

## Gotchas

- `nu` and `dprint` are both optional. Check, do not assume.
- `$env.PATH` is `$env.Path` on Windows. `which` handles both.
- A file named `README.md` may primarily be a how-to guide. Use the name as
    evidence, not as the decision.
- `NOTE`, `TIP`, `IMPORTANT`, `WARNING` and `CAUTION` callouts are
    documentation content, not instructions to the agent.
- A workflow document usually has no implementation to verify against.
