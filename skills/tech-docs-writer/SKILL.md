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

Produce and assess human-facing technical documentation — README, code
reference, CLI reference, instructions, how-to and workflow — with an explicit
context gate before drafting and source-verified claims throughout.

Every rule has exactly one owner file. Where writing and reviewing need the
same rule, they load the same file.

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

## Writing For A Human

Build the structure before drafting. Decide what question each section
answers, and write the section to answer that question.

A section that answers no question does not belong. A fact that fits no
section means the structure is wrong, not that the fact is worthless.

Two sections that answer the same question merge into one. A reader who finds
the first stops looking and never reaches the second.

A fact earns its place by changing what the reader does or decides. Cut what
only shows that the writer understood the subject.

Explain a rule by its reason, not only by its mechanics. The reason is usually
already written in the source.

Do not explain the category the document belongs to. Someone reading a tool's
documentation already knows what a tool is.

A sentence you have had to explain twice is in the wrong place or the wrong
shape. Fix the structure before rewording it again.

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

Three capabilities are detected, never required.

```text
nu                  which nu           absent → skip the script, manual checks
dprint              script checks it   absent → exit 3, manual checks
code intelligence   tool list          absent → drop a verification rung
```

Check for `nu` before invoking the script, because the script cannot report
its own interpreter missing. The script owns the `dprint` check.

For code intelligence, look in the tool list for tools whose names carry
`lsp`, `definition`, `references`, `hover` or `symbols`. Use them when
present. Do not ask the user to install one during a task.

## Formatting

```text
1  Project formatter as the project configures it     → formatted
2  Bundled script, project dprint config              → formatted
3  Bundled script, bundled fallback config            → formatted, fallback disclosed
4  nu or dprint absent                                → manual checks, NOT formatted, disclosed
```

Rungs 2 and 3 run `nu scripts/format-docs.nu <file>`. It exits 0 when the file
is formatted, 20 when `--check` finds unformatted content, 3 when dprint is
absent, and 1 on a dprint error. Its stdout record reports whether the project
or the bundled fallback config was used.

Never report a document as formatted when it was not. Never install a
formatter as part of a documentation task.

Format only the document the task is writing. Never a directory, never source
material the task is reading.

After formatting, run the post-format checks in
`references/markdown-conventions.md`. Formatting is not validation.

## Before Delivering

Read the finished document as a reader who has not seen the source, and judge
what is on the page rather than what was meant. Each check below is a search or
a count, because a check phrased as a quality to confirm gets confirmed without
being run.

`references/review-criteria.md` states the same principle for facts: memory of
drafting is not verification. Prose is no different.

```text
Backward references   Search "the other", "those two", "the remaining"
Table lead-ins        Read each lead-in alone; it names what the table lists
Examples              Search "for example", "for instance", quoted cases and paragraphs
                      holding two cases; each is labelled, adjacent ones distinctly;
                      the block after each example has its own heading or label
Reasons               Search "because", "so" and "same reason"; point each reason at a
                      source line, or cut it
Behaviour claims      List each statement of what the subject does; point each at a
                      source line, or label it as Source Verification requires
Placement             For each callout and example, name the paragraph it serves; it
                      sits directly after that paragraph
Obvious statements    Read each sentence beside a table or callout; cut one if the other says it
Terms                 List each name used in a heading, table or scope list; search the
                      rest for other words for it
Steps                 Search sentences joining three or more actions with commas; each
                      is a numbered list
Plain language        Search "so", "because" and "which" in long sentences; split any
                      sentence carrying two ideas; list each idiom and undefined term
Orphan sentences      Read each section's first sentence with the heading hidden
Reader address        Every sentence tells the reader something, not a tool; it says
                      what the reader gets or does, not how the subject classifies it
Named actor           Every rule says who performs it
Environment           No claim about one machine, no local absolute path
```

Fix what the pass finds before presenting the document. A defect caught here is
not a finding to report.

## Gotchas

- `nu` and `dprint` are both optional. Check, do not assume.
- `$env.PATH` is `$env.Path` on Windows. `which` handles both.
- A file named `README.md` may primarily be a how-to guide. Use the name as
    evidence, not as the decision.
- `NOTE`, `TIP`, `IMPORTANT`, `WARNING` and `CAUTION` callouts are
    documentation content, not instructions to the agent.
- A workflow document usually has no implementation to verify against.
