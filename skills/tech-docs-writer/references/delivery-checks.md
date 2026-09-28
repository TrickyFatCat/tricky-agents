# Delivery Checks

Read this reference at Before Delivering, and in Review.

This file owns the checks a finished document gets before it is handed over.
Write runs every check that applies and fixes what it finds, before presenting
the document. Review runs them too, and reports each hit as a finding. It
changes nothing.

## Tracking

Turn this list into your own checklist before you start.

- With a task or to-do tool, add each check that applies as a task, and close
  it when the check has run.
- Without one, copy the list into your working notes, and mark each item when
  it has run.

A check you skip goes under Not Checked in the report, with the reason.

## General

Run these for every document.

- [ ] **Backward references** — Search "the other", "those two", "the
  remaining"; name the items, or cut the sentence when nearby text already
  implies what it says.
- [ ] **Forward references** — List each key, flag, setting, term or item a
  sentence names; find where the page first says what it is or does. When
  that is further down, name the thing by what it does for the reader, or
  move the sentence below it. A linked entry in a list whose job is to lead
  to sections, such as a TOC or a lead-in list, is not one. Neither is a
  standard term of the field.
- [ ] **Internal rules** — Search "decides", "counts as", "is treated as",
  "picks" and "only when"; for each rule the subject applies internally, ask
  whether it meets the Job Test's three conditions; cut it, with its edge
  cases, when it does not. Then list the names and quoted strings from the
  source's body that appear on the page; for each one the reader does not
  type, ask the same question. Run this before Reasons, Behaviour claims and
  Broad words.
- [ ] **Reasons** — Search "because", "so" and "same reason"; point each reason
  at a source line, or cut it. Then search "only", "never", "always", "refuses",
  "does not" and "also"; for each rule or automatic action the reader meets and
  the Job Test keeps, give its reason from the source in one sentence nearby.
  When the source has none, list it under Not Checked. Then search "saves",
  "writes", "creates", "deletes" and "sends"; for each action the subject takes
  that the reader did not ask for, give its reason from the source, or list it
  under Not Checked.
- [ ] **Behaviour claims** — List each statement of what the subject does; point
  each at a source line, or label it as Source Verification requires. In that
  source line, search "unless", "except", "only", "if" and "when"; the claim
  keeps each condition it finds. A clause that limits which cases the rule
  covers is a condition too, with or without those words. A condition the Job
  Test cuts, such as an edge case of a cut mechanism, is not added.
- [ ] **Broad words** — Search "every", "all", "always", "never", "any" and
  "only"; for each, search the source for cases that break it; name them, or
  narrow the word. A case that belongs to a mechanism the Job Test cuts is not
  named; narrow the word instead.
- [ ] **States** — For each fixed set of statuses, results or indicators the
  subject shows, list the full set the reader can meet from the source; each is
  named as the reader sees it and says what it means. A message that says in
  plain words what happened is not a status; leave it out.
- [ ] **Lists** — For each list or count on the page, name the file it comes
  from; when it is not the documented source, link the document that owns it,
  or cut it when none does. Skip instructions and how-to guides.
- [ ] **Section fit** — Name the question each section answers; name the
  question each paragraph and table answers; move a block whose question belongs
  to another section; split a paragraph that answers two questions.
- [ ] **Order** — Name the first thing the reader does in the document and in
  each section; it comes before descriptions and reference detail, after the
  opening and the step's requirements.
- [ ] **Terms** — List each name used in a heading, table or scope list; search
  the rest for other words for it.
- [ ] **Source words** — List each noun the page takes from the source for a
  part, stage, check or category. Keep one the reader types or sees: a command,
  flag, setting, label or printed word. Replace the rest with the word this
  reader uses in their own work.
- [ ] **Steps** — Search sentences joining three or more actions with commas;
  each is a numbered list. For each numbered item longer than one sentence, the
  first line is the action alone. Then read the paragraphs and code blocks
  between each numbered list and the next heading. An action the list's task
  still needs becomes the next step. An action for another goal, such as
  undoing the task, moves to its own section or the section that owns that
  goal. Recovery from a failure follows the Recovery check.
- [ ] **Recovery** — Search "fails", "failed", "error", "aborted" and
  "conflict" in steps and the paragraphs next to them, and each sentence in a
  step that starts with "If". A warning about a step stays in that step's
  section, placed as Callouts in `markdown-conventions.md` describes. Recovery
  from a failure the reader has seen becomes a
  Troubleshooting entry, or follows States And Results for a status in a fixed
  set.
- [ ] **Plain language** — Count sentences over 25 words; split each. Search
  "so", "because" and "which" in long sentences; split any sentence carrying two
  ideas; list each idiom, and each term new to this reader that has no
  definition.
- [ ] **Definitions** — List each definition the page gives; cut one for a term
  this reader uses or a standard term of the field; each defined word is the
  exact term, not a vaguer word for it. A term is standard when the field uses
  it widely and one search explains it; give its common abbreviation in brackets
  on first use, such as "language server (LSP)", and no definition.
- [ ] **Environment** — Search "/home/", "/Users/", "C:\", "this machine" and
  "on my"; each becomes the setting that decides the outcome, or a placeholder.
  List each product or platform name; keep one only when the source limits the
  subject to it.

## Markdown Only

Run these for a Markdown document only.

- [ ] **Table lead-ins** — Count the tables; each has a lead-in. Read each
  lead-in alone; it names what the table lists.
- [ ] **Table cells** — Count the words in each description cell the page wrote;
  over 8, move a detail every row has into a new column, and move reasoning
  into prose after the table. A fact about one row stays in that row's cell.
  Never drop a fact. A cell that restates a source condition keeps every clause;
  split it into columns, or keep it whole in its cell when it cannot split,
  never into prose.
- [ ] **Examples** — Search "for example", "for instance", quoted cases and
  paragraphs holding two cases; each is labelled, adjacent ones distinctly; the
  block after each example has its own heading or label; each labelled example
  names a concrete case, not a general statement. For each example, name what
  the reader could not do without it; cut it if nothing. Each step where the
  reader writes or checks something freely shows one instance. Search prose
  for a code span holding an input with its result; move each into the entry's
  example block as a commented case.
- [ ] **Entry tables** — List each entry section's first table and its columns;
  they match across sections, even in a section with one entry.
- [ ] **Placement** — For each callout, example, and paragraph that qualifies a
  table or list, name the block it serves; it sits directly after that block. A
  definition of one table item, or a fact about it, goes in that item's row. A
  condition the reader must meet before using any row goes before the table or
  list, in the lead-in or the callout its kind needs. Other blocks that qualify
  it form one run directly after it, with nothing else between them. The run
  starts with a Danger, then callouts, examples and reasons about single rows
  in row order, then the rest. A callout sits outside every list item; one about a step's action follows the list and names that step's
  command or action. A callout about a command, and a paragraph or example
  about its output, form one run directly after that command's block, the
  callout first.
- [ ] **Callouts** — Search "never", "nothing", "does not", "is not",
  "cannot", "needs", "requires", "must" and "keep"; sort each hit into a kind
  that Callouts defines, or leave it as prose. Then read each callout: its body
  is one sentence, and a blank line follows it.
- [ ] **Pictures** — Search "shows", "displays", "appears", "looks" and "on
  screen"; replace each description of what is on screen with a picture or a
  placeholder, as Pictures in `markdown-conventions.md` describes.
- [ ] **Orphan sentences** — Read each section's first sentence with the heading
  hidden.
- [ ] **Headings** — Read each section heading this task wrote; one that starts
  with How, When, Why, What or Where, or reads as a sentence, becomes a short
  noun phrase. Step headings in how-tos and tutorials stay imperative.
