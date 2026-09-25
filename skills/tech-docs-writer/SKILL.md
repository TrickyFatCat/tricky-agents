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

This skill writes and reviews human-facing documents: READMEs, code and CLI
references, instructions, how-to guides and workflow documents.

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

Show, don't only tell. Where the reader must write or recognise something,
such as a request, a command, a value or an output, show one instance of it.
Leave out an instance that only repeats a claim the reader can already apply
as written.

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

A review stays in the conversation, with no saved file.

## Context Gate

Never draft while the document mode or the intended reader is unknown and
unstated. `references/context-gate.md` owns the questions, the choice when the
user defers, and the assumption block.

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

A section that answers no question does not belong. A fact that fits no
section means the structure is wrong, not that the fact is worthless.

Two sections that answer the same question merge into one. A reader who finds
the first stops looking and never reaches the second.

Do not explain the category the document belongs to. Someone reading a tool's
documentation already knows what a tool is.

A sentence you have had to explain twice is in the wrong place or the wrong
shape. Fix the structure before rewording it again.

## Reader Tests

Run both tests on every sentence the task writes or changes.

In an existing document, the tests edit only the sentences the task writes or
changes. For every other sentence, report what the tests find as a finding in
the report. Do not edit it.

### Job Test

Name the sentence's job from the list in A Good Document.

- A sentence with no job goes.
- A sentence whose job nearby text already does has no job. That includes a
  sentence that repeats nearby text, such as the sentence before it, the table
  beside it or the index entry above it. It also includes a sentence that
  spells out what a heading, lead-in, list, table or sentence already implies.
- A rule the subject applies internally, such as how it decides, classifies
  or verifies, stays only when knowing it changes what the reader does or
  expects, and nothing else in the document already gives them that.
  Otherwise cut it, and keep the result the reader sees. Run this before the
  `Reasons` check and the Behaviour Inventory. A rule it cuts counts as cut
  for a named reason.
- When you are not sure the reader needs the fact, keep the sentence.
  Low-value text can be seen and cut later. A missing fact cannot be seen.
  Doubt keeps a fact, not a second copy of it.
- A sentence with a job but no section to hold it means the structure is
  wrong. Fix the structure, and keep the sentence.

List every cut in the report, as Before Delivering describes.

**Example**

```text
Cut     The launcher picks a download server by pinging each one.
Keep    Your bracket depends on your last 20 matches, so one bad match
        moves it only a little.
```

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

Lead with what the reader gets or does, then the mechanism. Internal logic
alone does not say why it matters to them.

```text
Weak    Without a save slot the game cannot store progress, so it does not
        start.
Strong  Choose a save slot so the game can keep your progress.
```

**Copied Instruction**

A tool's instruction belongs in that tool's rules, not in the document about
it. It hides where the subject has rules of its own, because a copied
imperative reads as ordinary prose.

```text
Weak    So read each match before acting on it.
Strong  The scan gives you a list of candidates, not a verdict. Read each
        match yourself before you act on it.
```

**Missing Actor**

Name who performs each rule. Where the document and its subject can both act,
the reader cannot tell which one a rule means.

```text
Weak    The config is validated before the build.
Strong  The build script validates the config before it builds.
```

## Cold Reader

After every Write, a reader who has not seen the source reads the document.
Skip it only for an edit that changes no meaning, such as a typo fix. The
writer cannot run this check itself, because it has read the source.

1. Start a subagent. Give it only the finished document, the named reader,
   and that reader's starting point: what they already know and have done.
   Give it no source, no draft history and no skill rules.
   `references/context-gate.md` owns how the starting point is settled.
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
     `references/source-verification.md` requires;
   - known from context: a line in the starting point answers it, or it asks
     about a standard term of the field, as the `Definitions` check defines.
     Change nothing. Nothing else counts, and doubt makes it a gap.
5. Run the cold reader once per Write. Do not run it again after the fixes.
   List each question in the report as fixed, open or known from context.

When no subagent tool is available, skip the check and say "not checked by a
cold reader" in the report. Never imitate the cold reader in your own context.

Review runs the cold reader too. `references/review-criteria.md` owns how.

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
language server     tool list          absent → drop a verification rung
subagent            tool list          absent → skip the cold reader, say so
```

Check for `nu` before invoking the script, because the script cannot report
its own interpreter missing. The script owns the `dprint` check. `$env.PATH` is
`$env.Path` on Windows. `which` handles both.

For a language server (LSP), look in the tool list for tools whose names
carry `lsp`, `definition`, `references`, `hover` or `symbols`. Use them when
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

Rungs 2 and 3 run `nu scripts/format-docs.nu <file>`. Only exit 0 means
formatted. Exit 3 means dprint is absent, so rung 4 applies. The script's
`--help` lists every code. Its stdout record says whether the project or the
fallback config was used.

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

```text
Backward references   Search "the other", "those two", "the remaining"; name the items,
                      or cut the sentence when nearby text already implies what it says
Table lead-ins        Count the tables; each has a lead-in. Read each lead-in
                      alone; it names what the table lists
Table cells           Count the words in each description cell the page wrote; over 8,
                      move the extra detail into prose after the table or into a new
                      column. Never drop a fact. A cell that restates a source
                      condition keeps every clause; split it into columns, never into
                      prose
Examples              Search "for example", "for instance", quoted cases and paragraphs
                      holding two cases; each is labelled, adjacent ones distinctly;
                      the block after each example has its own heading or label; each
                      labelled example names a concrete case, not a general statement.
                      For each example, name what the reader could not do without it;
                      cut it if nothing. Each step where the reader writes or checks
                      something freely shows one instance
Internal rules        Search "decides", "counts as", "is treated as", "picks" and "only
                      when"; for each rule the subject applies internally, ask whether
                      knowing it changes what the reader does or expects. Cut it when
                      it does not, as the Job Test requires. Run this before Reasons
Reasons               Search "because", "so" and "same reason"; point each reason at a
                      source line, or cut it. Then search "only", "never", "always",
                      "refuses", "does not" and "also"; for each rule or automatic
                      action the reader meets and the Job Test keeps, give its reason
                      from the source in one sentence nearby. When the source has
                      none, list it under Not Checked
Behaviour claims      List each statement of what the subject does; point each at a
                      source line, or label it as Source Verification requires. In
                      that source line, search "unless", "except", "only", "if" and
                      "when"; the claim keeps each condition it finds. A clause that
                      limits which cases the rule covers is a condition too, with or
                      without those words
Broad words           Search "every", "all", "always", "never", "any" and "only"; for
                      each, search the source for cases that break it; name them, or
                      narrow the word
States                For each status, result or indicator the subject shows, list
                      the full set the reader can meet from the source; each is
                      named as the reader sees it and says what it means
Placement             For each callout, example, and paragraph that qualifies a table or
                      list, name the block it serves; it sits directly after that
                      block. A definition of one table item goes in that item's cell
Callouts              Search "never", "does not", "is not" and "cannot". Each guarantee
                      about the reader's work is a Note, each limit the reader relies
                      on is a Warning, and each action with permanent loss is a
                      Danger, as markdown-conventions.md Callouts defines
Section fit           Name the question each section answers; name the question each
                      paragraph and table answers; move a block whose question belongs
                      to another section
Order                 Name the first thing the reader does in the document and in
                      each section; it comes before descriptions and reference
                      detail, after the opening and the step's requirements
Terms                 List each name used in a heading, table or scope list; search the
                      rest for other words for it
Source words          List each noun the page takes from the source for a part, stage,
                      check or category. Keep one the reader types or sees: a command,
                      flag, setting, label or printed word. Replace the rest with the
                      word this reader uses in their own work
Steps                 Search sentences joining three or more actions with commas; each
                      is a numbered list. For each numbered item longer than one
                      sentence, the first line is the action alone
Plain language        Count sentences over 25 words; split each. Search "so", "because"
                      and "which" in long sentences; split any sentence carrying two
                      ideas; list each idiom, and each term new to this reader that has
                      no definition
Definitions           List each definition the page gives; cut one for a term this
                      reader uses or a standard term of the field; each defined
                      word is the exact term, not a vaguer word for it. A term is
                      standard when the field uses it widely and one search explains
                      it; give its common abbreviation in brackets on first use, such
                      as "language server (LSP)", and no definition
Orphan sentences      Read each section's first sentence with the heading hidden
Headings              Read each section heading this task wrote; one that starts with
                      How, When, Why, What or Where, or reads as a sentence, becomes a
                      short noun phrase. Step headings in how-tos and tutorials stay imperative
Environment           Search "/home/", "/Users/", "C:\", "this machine" and "on my"; each
                      becomes the setting that decides the outcome, or a placeholder
```

Fix what the pass finds before presenting the document. A defect fixed here is
not a finding to report. Cuts are still listed.

### Report

After the result, the report adds these blocks in this order. Leave out a
block that is empty.

1. **Cuts** — every fact the job test removed, grouped by section, one line
   each: the fact, and why it has no job.
2. **Cold Reader** — the starting point it was given, then each question,
   marked fixed with what changed, open with why, or known from context with
   the starting-point line or standard term that covers it.
3. **Outside The Task** — test findings on sentences the task did not change.
4. **Not Checked** — each check that did not run, such as the formatter or the
   cold reader, and each claim labelled Unknown.
