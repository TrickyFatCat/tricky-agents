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
references, tutorials, how-to guides and workflow documents.

## A Good Document

A good document gives one named reader what they need to act or decide.
Nothing else goes in.

Each sentence does one job for that reader:

- tells them what this part covers, so they can read it or skip it;
- tells them what to do;
- tells them what they will see when they must check it, act on it or use it,
  and what it means;
- gives a fact they need to use the subject, choose, or avoid a mistake;
- explains why, when the reason changes what they do or how they judge the
  subject.

An example shows one of these jobs on a concrete case. It repeats a claim on
purpose.

Show, don't only tell. Where the reader must write or recognise something,
such as a request, a command, a value or an output, show one instance of it.
Leave out an instance that only repeats a claim the reader can already apply
as written.

Show what the reader sees on screen as Pictures in
`references/markdown-conventions.md` describes.

A lead-in names what follows. It does not summarise it.

An explanation stays on one question.

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
accepted finding does not authorise a rewrite of the document. The one
exception is Internal Review, which runs inside the writer's own Write.

For a mixed request such as "review this and fix the worst part", review
first, present findings, and apply only the findings the user names.

A review stays in the conversation, with no saved file.

## Write Stages

A Write runs these stages in this order. Each row names the section or the
reference that owns the stage.

```text
1  Context Gate          references/context-gate.md
2  Structure
3  Draft                 Reader Tests and Wording on every sentence
4  Cold Reader, fixes    references/cold-reader.md
5  Internal Review       new document or whole rewrite only;
                         references/review-criteria.md
6  Before Delivering     delivery checks, and the subject's final check:
                         Final Command Inventory Check (cli-reference.md)
                         or Final Check (source-verification.md)
7  Formatting            after the last text change; Markdown Formatting
                         in references/markdown-conventions.md
8  Report                Report in references/delivery-checks.md; load
                         it even when stage 6 was skipped
```

A text change after stage 7 sends the document back through stage 7.

Never report a document as formatted when it was not. Never install a
formatter as part of a documentation task. Format only the document the task
is writing. Never a directory, never source material the task is reading.

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

Do not explain the category the document belongs to, or the standard behaviour
of a platform the reader already uses. Someone reading a tool's documentation
already knows what a tool is.

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
- In a set whose items the reader sets up or uses one at a time, another item
  is not nearby text. Examples are the enemies in a bestiary and the weapon
  classes of a combat guide. Each item keeps its full requirements, controls and
  settings, even when they repeat. Controls and settings the source defines
  once for every item, such as a tool's global options, are stated once and
  linked from each item. A requirement every item shares goes once, in the
  opening that introduces the set.
- A rule the subject applies internally stays only when all of these hold:
  - knowing it changes what the reader does or expects;
  - the reader would not find it out through normal use, or finding it out
    that way would cost them work or time;
  - nothing else in the document already gives them that.

  That covers how it decides, classifies or verifies, and how it produces a
  result: the functions it calls, the branches it takes, the text it prints.
  Printed text the reader must check, act on or use is not covered. A Good
  Document decides it. Otherwise cut the rule, with its edge cases, and keep
  what the reader gets from it. Run this before the `Reasons`,
  `Behaviour claims` and `Broad words` checks and the Behaviour Inventory.
- A fact that another tool's configuration, or another file the page lists,
  defines goes out. An example is the key binding that opens the subject. Link
  that configuration's document, or the file's entry on the page, when one
  exists. A step the reader takes stays where the page teaches it, such as a
  key they press in a how-to step, or an action in another tool they need to
  use the subject.
- Where the page lists files so the reader can choose which one to open and
  edit, such as the config files of a setup, each entry names the kinds of
  content its file holds, not single settings or their values. The reader
  reads the rest in the file. The settings, values and comments the file
  states go out of the entry, and are not moved into prose or a new column. A
  fact the file cannot show stays, such as what loads it, what it overrides,
  or where a file missing from the reader's copy comes from. A file the reader
  runs or uses, such as a script or a shader, keeps what it does.
- When you are not sure the reader needs the fact, keep the sentence.
  Low-value text can be seen and cut later. A missing fact cannot be seen.
  Doubt keeps a fact, not a second copy of it. Doubt does not keep a fact this
  test cuts by kind:
  - a mechanism the reader finds out through normal use;
  - what a picture shows;
  - a fact another tool's configuration or another listed file defines;
  - what a listed file states, which the reader reads by opening it;
  - what the page already implies.
- A sentence with a job but no section to hold it means the structure is
  wrong. Fix the structure, and keep the sentence.

List every cut in the report, as Report in `references/delivery-checks.md`
describes.

**Example**

```text
Cut     The launcher picks a download server by pinging each one.
Keep    Your bracket depends on your last 20 matches, so one bad match
        moves it only a little.
Cut     retry() calls _backoff(n), which sleeps 2^n seconds.
Keep    Each retry waits longer than the one before.
Cut     The asset baker prints one line for each texture it compresses.
Keep    The bake ends with "0 errors". Any other count means some textures
        were not baked.
Cut     The dry run prints one line for each file it would copy.
Keep    The dry run must not end with "aborted".
```

### View Test

Name the subject of the sentence: who or what does the verb. A passive
sentence hides its subject, so name the actor first.

Check in the source that this actor performs the verb. A control the reader
uses, such as a key or a button, starts an action but does not perform it.
Name the part that does, then apply the next paragraph when the reader never
sees that part.

When the subject is a part the reader never sees or touches, such as an
internal stage, a mode, a check or a classification, rewrite the sentence from
the reader's side: what they do, what they see, or what they get.

A reference passes this test. Its subjects are the commands, functions and
settings the reader uses.

Before rewriting, apply Fact Guard in Wording. The rewrite changes the
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

## Wording

These rules apply to English text in every document, for every reader. They
paraphrase and adapt ASD-STE100 Simplified Technical English, without its
dictionary and its word counts.

Write applies them to the sentences the task writes or changes, as Reader
Tests says, and Review to every sentence. Wording searches in
`references/delivery-checks.md` says how hits on other sentences are listed.

A style-only hit, such as a contraction, changes how a sentence reads but not
what the reader does.

**Example**

```text
Before  If the build turns up any missing textures, it'll bail out and you
        should go back and re-run the baker.
After   If the build finds a missing texture, it stops. Run the baker again.
```

### Protected Text

Never reword:

- code, commands, flags, paths and config keys;
- labels and other text the reader sees on screen;
- error messages and printed output;
- text quoted from a source, or text the user asks to keep as written;
- names of products, files and links;
- requirement words a project defines, such as MUST and SHOULD in a
  specification.

The prose around protected text agrees with it.

### Rank

A style guide the project states, or the user's request, wins over these
rules. A document keeps its own established terms and spelling. For every
other rule here, the wording of existing pages, including this one, is
evidence, not a stated guide. These rules never remove a fact, a condition or
a heading.

### Words

- Name one concept with one term. Define it where it first appears, and use
  the same word every time after. A second word for the same thing makes
  the reader ask whether there are two things. Give one word one meaning
  on the page.
- Use the exact term the reader uses in their own work, with no definition.
  Do not swap it for a vaguer word. For a general idea, use the common word.
- Define a term new to this reader in one line, where it first appears. A
  standard term of the field needs no definition: "symlink" in a README for a
  Linux tool is one. When it is unclear whether this reader knows a term,
  keep the term and define it.
- Write an action as a verb, not as a noun made from it.
  The one exception: turn a clause into a noun, such as "after approval",
  only when one actor alone can perform the action.
- Replace a phrasal verb with a single verb that has the same meaning. Keep a
  phrasal verb that is the field's term or a label, such as "roll back".
- No idioms, slang or team shorthand. Write "for example", "that is" and "and
  so on", not "e.g.", "i.e." and "etc.". A heading that compares two things
  keeps `vs`.
- Break a stack of nouns that the reader must read backwards, unless it is a
  label.
- "You" is the reader, doing their own task. Name any other actor: "a
  person", "a player" or a role.

A reader who works in a second language has to translate an idiom before
they can use the sentence. A native reader loses nothing from plain words.

### Sentences

- One idea per sentence. A rule and its reason are two sentences.
- A step holds one action, written as a command. Two actions that happen
  together can share a step.
- In an instruction, the condition comes before the action. Two kinds of
  clause stay where they are: a limit with "only", and a clause that says
  which thing the action applies to. The condition-first rule does not
  apply to a description or a table row.
- When a condition covers every item of a list, it is the list's lead-in.
- Prose keeps its articles, subject and verb. A table cell, a heading or a
  list fragment can be shorter.
- No contractions. No semicolon between two full sentences.
- Write the noun when a pronoun such as "it", "they" or "this" can point to
  two nouns in this sentence or the one before.
- Replace "should", "may", "might" or "could" when it has two readings:
  - an obligation becomes a command;
  - a possibility becomes "can" or "possibly";
  - a permission becomes "can", with the actor;
  - advice names who recommends it, such as "the project recommends";
  - an expected result becomes what the reader sees.
- A sentence over 25 words is a signal, not a limit. Split it when it holds
  two ideas or a late condition.

### Fact Guard

Before you reword a sentence, list its facts, conditions, limits and
requirement words. After, find each one in the new sentence. When one is
missing, rewrite again or keep the original sentence.

```text
Source  The bake runs only on saved scenes, unless --force is set.
Facts   1 saved scenes only   2 --force lifts the limit
Weak    Save the scene before you bake.                    (2 lost)
Strong  Save the scene before you bake, or pass --force.   (1, 2 kept)
```

## Cold Reader

After every Write, a reader who has not seen the source reads the document.
Skip it only for an edit that Before Delivering exempts. The writer cannot run
this check itself, because it has read the source.
`references/cold-reader.md` owns how.

Review runs the cold reader too. `references/review-criteria.md` owns how a
review uses its questions.

## Routing

| Reference                            | Load when                                                        |
| ------------------------------------ | ---------------------------------------------------------------- |
| `references/context-gate.md`         | Before drafting, whenever required context is missing            |
| `references/cold-reader.md`          | At stage 4 of every Write, and in Review                         |
| `references/document-modes.md`       | Selecting or adapting a document's shape                         |
| `references/markdown-conventions.md` | Any Write or Review                                              |
| `references/cli-reference.md`        | Documenting commands, flags or shell workflows                   |
| `references/code-reference.md`       | Documenting a source-level API                                   |
| `references/source-verification.md`  | Any claim that can be checked against an authority               |
| `references/review-criteria.md`      | Review mode, and Internal Review                                 |
| `references/delivery-checks.md`      | At Before Delivering, at Report, and in Review                   |

## Before Delivering

Run the reader tests on every sentence the cold-reader fixes and Internal
Review added, then load `references/delivery-checks.md` and run every check
that applies. When a review finding is applied later, run the tests and
checks again on the sentences it added. Skip them only for an edit that
changes spelling, punctuation or formatting. Formatting is markup that leaves
every word and its order unchanged. A rewording is never such an edit,
because a reworded sentence can lose a fact. Size does not count.

Each check is a search or a count, because a check phrased as a quality to
confirm gets confirmed without being run.

Fix what the pass finds before presenting the document. A defect fixed here is
not a finding to report. Cuts are still listed.
