# Delivery Checks

Read this reference at Before Delivering, at Report, and in Review.

This file owns the checks a finished document gets before it is handed over.
Write runs every check that applies and fixes what it finds in the text the
task wrote or changed, before presenting the document. Review runs them too, and reports each hit as a finding. Style-only
hits from the Wording searches are the exception: they form the
summary line that Reporting in review-criteria.md describes. Review
changes nothing.

## Tracking

Turn this list into your own checklist before you start.

- With a task or to-do tool, add each check that applies as a task, and close
  it when the check has run.
- Without one, copy the list into your working notes, and mark each item when
  it has run.

A check you skip goes under Not Checked in the report, with the reason.

In an existing document, each check reads the whole document. Write fixes a
hit only in the sentences and blocks the task wrote or changed. A hit
elsewhere goes under Outside The Task in the report, as a finding, not an
edit. Review reports every hit.

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
- [ ] **File entries** — For each table row or list item that names a file
  the reader opens to read or edit, list each setting name, value and comment
  the entry takes from inside that file; cut each one the Job Test cuts. Run
  this before Reasons, Behaviour claims and Broad words.
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
  narrow the word. A case the Job Test cuts, such as an edge case of a cut
  mechanism or a value inside a listed file, is not named; narrow the word
  instead.
- [ ] **States** — For each fixed set of statuses, results or indicators the
  subject shows, list the full set the reader can meet from the source; each is
  named as the reader sees it and says what it means. A message that says in
  plain words what happened is not a status; leave it out.
- [ ] **Lists** — For each list or count on the page, name the file it comes
  from; when it is not the documented source, link the document that owns it,
  or cut it when none does. Skip tutorials and how-to guides.
- [ ] **Section fit** — Name the question each section answers; name the
  question each paragraph and table answers; move a block whose question belongs
  to another section; split a paragraph that answers two questions.
- [ ] **Order** — Name the first thing the reader does in the document and in
  each section; it comes before descriptions and reference detail, after the
  opening and the step's requirements.
- [ ] **Terms** — List each name used in a heading, table or scope list; search
  the rest for other words for it. When the task writes several pages,
  search every page it writes.
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
- [ ] **Wording searches** — Run each search below as its own tracked item.
  Write fixes the hits on the sentences the task wrote or changed. Hits on
  other sentences go under Outside The Task in the report, as that block
  describes. Review runs
  every search on every sentence. Every search skips protected text, as
  Wording in `SKILL.md` lists it.
  - [ ] **Contractions** — Search "n't", "'ll", "'re", "'ve", "'d", "it's"
    and "let's", with straight and curly apostrophes; write the full form.
  - [ ] **Abbreviations** — Search "e.g.", "i.e.", "etc.", "cf." and "viz.";
    write the words.
  - [ ] **Semicolons** — Search ";"; when both sides are full sentences,
    write two sentences or a list.
  - [ ] **Pronouns** — Search the whole words "it", "they" and "them", and
    "This", "That" and "These" at the start of a sentence; list the nouns in
    this sentence and the one before that fit; when two fit, write the noun.
  - [ ] **Modal words** — Search the whole words "should", "may", "might" and
    "could"; when one has two readings, replace it as Wording in `SKILL.md`
    says.
  - [ ] **Late conditions** — In numbered steps, and in sentences outside a
    table that start with a verb, search " if ", " when ", " unless " and " after " anywhere
    but the sentence start; move the condition before the action. A limit
    with "only" stays, and so does a clause that says which thing.
  - [ ] **Two actions** — In each numbered step, search " and " and
    ", then "; split the step when each side has its own verb for the reader,
    unless the actions happen together.
  - [ ] **Step form** — In numbered steps, search "you should", "you need
    to", "you will want to", "the user" and "please"; write the command.
  - [ ] **Phrasal verbs** — Search the whole words "up", "out", "off", "down"
    and "back"; for each hit, check whether the word before it is a verb that
    forms a phrase with it; replace the phrase when a single verb keeps the
    meaning and the phrase is not a term or a label.
  - [ ] **Verb nouns** — Search "perform", "carry out", "make a", "do a",
    "tion of" and "ment of"; when the noun names an action, write the verb.
  - [ ] **Long sentences** — Count the words in each sentence; for each one
    over 25, check for two ideas or a late condition; split only then.
- [ ] **Definitions** — List each term the page uses that the starting point
  does not name and the field does not use widely; each has a one-line
  definition where it first appears. List each definition the page gives; cut one for a term
  this reader uses or a standard term of the field; each defined word is the
  exact term, not a vaguer word for it. A term is standard when the field uses
  it widely and one search explains it; give its common abbreviation in brackets
  on first use, such as "language server (LSP)", and no definition.
- [ ] **Environment** — Search "/home/", "/Users/", "C:\", "this machine" and
  "on my"; each becomes the setting that decides the outcome, or a placeholder.
  List each product or platform name; keep one only when the source limits the
  subject to it.
- [ ] **Examples** — Search "for example", "for instance", quoted cases and
  paragraphs holding two cases; each is labelled, adjacent ones distinctly; the
  block after each example has its own heading or label; each labelled example
  names a concrete case, not a general statement. For each example, name what
  the reader could not do without it; cut it if nothing. Each step where the
  reader writes or checks something freely shows one instance. Search prose
  for a code span holding an input with its result; move each into the entry's
  example block as a commented case.
- [ ] **Placement** — For each callout, example, and paragraph that qualifies a
  table or list, name the block it serves; it sits directly after that block. A
  definition of one table item, or a fact about it, goes in that item's row. A
  condition the reader must meet before using any row goes before the table or
  list, in the lead-in or the callout its kind needs. Other blocks that qualify
  it form one run directly after it, with nothing else between them. The run
  starts with a Danger, then callouts, examples and reasons about single rows
  in row order, then the rest. In Markdown, a callout sits outside every list item; one about a step's action follows the list and names that step's
  command or action. A callout about a command, and a paragraph or example
  about its output, form one run directly after that command's block, the
  callout first.
- [ ] **Callouts** — Search "never", "nothing", "does not", "is not",
  "cannot", "needs", "requires", "must" and "keep"; sort each hit into a kind
  that Callouts defines, or leave it as prose. Then read each callout: its body
  is one sentence, and, in Markdown, a blank line follows it.
- [ ] **Pictures** — Search "shows", "displays", "appears", "looks" and "on
  screen"; replace each description of what is on screen with a picture or a
  placeholder, as Pictures in `markdown-conventions.md` describes. Output a
  command prints before it exits stays as a text block, unless the user chose
  a picture.
- [ ] **Orphan sentences** — Read each section's first sentence with the heading
  hidden.
- [ ] **Headings** — Read each section heading this task wrote; one that starts
  with How, When, Why, What or Where, or reads as a sentence, becomes a short
  noun phrase. Step headings in how-tos and tutorials stay imperative.

## Markdown Only

Run these for a Markdown document only.

- [ ] **Table lead-ins** — Count the tables; each has a lead-in. Read each
  lead-in alone; it names what the table lists.
- [ ] **Table cells** — Count the words in each description cell the page wrote;
  over 8, look for a detail every row has and for reasoning. Move the detail
  into a new column, and the reasoning into prose after the table. A
  long cell with neither stays. A fact about one row stays in that row's cell.
  Never drop a fact the Job Test keeps. A cell that restates a source condition
  keeps every clause; split it into columns, or keep it whole in its cell when
  it cannot split, never into prose. Then group the rows whose items do the
  same kind of thing. In each group, list whether each cell starts with a verb,
  and the order of its clauses. They match: the usual result first, then each condition that
  changes it. Never add a clause to make rows match.
- [ ] **Entry tables** — List each entry section's first table and its columns;
  they match across sections, even in a section with one entry.

## Report

This section is for a Write. Review reports as `review-criteria.md` describes.

After the result, the report adds these blocks in this order. Leave out a
block that is empty.

1. **Assumptions** — each choice made without the user, as
   `context-gate.md` describes, one field per line.
2. **Cuts** — every fact the job test removed, grouped by section, one line
   each: the fact, and why it has no job.
3. **Pictures** — each placeholder, by section, with what it must show.
4. **Cold Reader** — the starting point it was given, then each question,
   marked fixed with what changed, open with why, known from context with
   the starting-point line or standard term that covers it, not needed
   with the Job Test reason, or outside the task with the fix it needs.
5. **Review** — each Internal Review finding, marked applied, partly applied
   with each declined fact and its reason, or declined with the reason.
6. **Outside The Task** — findings on sentences and blocks the task did not
   change: one line for the style-only hits of the Wording searches, with the
   count for each search, then one line for each other finding.
7. **Not Checked** — each check that did not run, such as the formatter, the
   cold reader or Internal Review, and each claim labelled Unknown. When the
   delivery checks did not run, say "delivery checks not run" with the reason,
   such as "edit changes only spelling".
