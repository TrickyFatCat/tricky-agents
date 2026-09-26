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
- [ ] **Internal rules** — Search "decides", "counts as", "is treated as",
  "picks" and "only when"; for each rule the subject applies internally, ask
  whether knowing it changes what the reader does or expects. Cut it when it
  does not, as the Job Test requires. Run this before Reasons.
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
  covers is a condition too, with or without those words.
- [ ] **Broad words** — Search "every", "all", "always", "never", "any" and
  "only"; for each, search the source for cases that break it; name them, or
  narrow the word.
- [ ] **States** — For each status, result or indicator the subject shows, list
  the full set the reader can meet from the source; each is named as the reader
  sees it and says what it means.
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
  first line is the action alone.
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
  over 8, move the extra detail into prose after the table or into a new column.
  Never drop a fact. A cell that restates a source condition keeps every clause;
  split it into columns, or keep it whole in its cell when it cannot split,
  never into prose.
- [ ] **Examples** — Search "for example", "for instance", quoted cases and
  paragraphs holding two cases; each is labelled, adjacent ones distinctly; the
  block after each example has its own heading or label; each labelled example
  names a concrete case, not a general statement. For each example, name what
  the reader could not do without it; cut it if nothing. Each step where the
  reader writes or checks something freely shows one instance.
- [ ] **Placement** — For each callout, example, and paragraph that qualifies a
  table or list, name the block it serves; it sits directly after that block. A
  definition of one table item goes in that item's cell. A condition the reader
  must meet before using any row goes before the table or list, in the lead-in
  or the callout its kind needs. Other blocks that qualify it form one run
  directly after it, with nothing else between them: a Danger first, then blocks
  about single rows in row order, then the rest.
- [ ] **Callouts** — Search "never", "nothing", "does not", "is not" and
  "cannot"; sort each hit into a kind that Callouts defines, or leave it as
  prose. Then read each callout: its body is one sentence, and a blank line
  follows it.
- [ ] **Orphan sentences** — Read each section's first sentence with the heading
  hidden.
- [ ] **Headings** — Read each section heading this task wrote; one that starts
  with How, When, Why, What or Where, or reads as a sentence, becomes a short
  noun phrase. Step headings in how-tos and tutorials stay imperative.
