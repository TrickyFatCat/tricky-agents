---
name: code-comments
description: Use this skill when the user asks to add, improve, rewrite, shorten, clean up or review code comments or documentation comments, including docstrings, doc blocks and editor tooltips. Use it even when the user only says the comments are unclear, too long or obvious. Do not use it for comments written while implementing, fixing or refactoring code.
---

# Code Comments

A comment tells a reader new to this code something they need and cannot get from the code, its names, or the language.
This skill adds such comments, and deletes, replaces or reports the rest.

## Invariant

This skill covers comment work only, and never blocks code work the user asks for in the same request.
Preserve all non-comment code exactly, including identifiers, literals, ordering, behaviour and formatting.
Do not refactor, rename, reformat, optimise or correct code.
If a comment change would need a code change, report the conflict instead.
Blank lines next to a comment you add, delete or change are part of that comment's layout, and may be added or removed.
Never add or remove a blank line that has a code line directly above and below it in the input.

## Before Commenting

1. Read the user's instructions and the project's comment rules, such as `AGENTS.md`, contribution guides, style guides, and linter or formatter settings.
2. Apply this precedence:
   1. user instructions;
   2. required project, legal and tool rules;
   3. project conventions;
   4. this skill;
   5. consistent nearby comments.
3. When a user request conflicts with a rule that is or may be required, name the rule, its source, and what breaking it costs.
   Ask once per rule per request.
   Leave the affected comments unchanged until the user answers.
   A yes breaks the rule for this request.
   Any other answer, including "you decide", keeps the rule.
   When it is unclear whether a rule is required, follow it.
4. Read `references/examples.md`.

Ask nothing else before the work.
Do not ask whether the project has comment rules, or whether the code is shared.

Without project comment rules, follow a convention only when several nearby comments share it.
Nearby comments never override the writing rules.

## A Good Comment

A comment does one of two jobs:

- It adds precision: units, ranges, edge cases, what a value means.
- It adds intuition: why the code exists, why it has this shape, what breaks if it changes.

### Add Test

Add a comment when:

- a reader might simplify, move or delete the code by mistake;
- you would have to explain the code in a code review;
- a caller could pass a value the code rejects or treats specially, or needs a unit to use a value correctly;
- a value or text has a copy that must change with it, in code or in a file that a program or an agent reads.

A comment for a copy is a `WARNING` that names each copy.
A copy in documentation written for people does not count.
A file an agent follows as instructions, such as `AGENTS.md`, counts, even when people also read it.

### Delete Test

Hide the comment.
Read the code and its names.
For an interface comment, read only the declaration: its name, parameters and types.
For a constant, a field or a variable, the declaration includes its value.
Annotations and attributes on the declaration count as part of it.
If a reader who knows the language could write the comment from that, delete it.
A sentence whose why passes this test passes, even when its what-part repeats the code.

### Fact Sources

Take every fact from the project's files, their history, the user, or the help or documentation of a tool, library or engine the code uses, read in this run.
Never write a fact from memory or a guess.
If no source gives a fact the comment needs, report the missing fact.

### Claims About Other Code

A comment can claim something about code outside its own lines, such as "change nothing else", "the only caller" or "never null".
Check each such claim against that code before you keep or write it.
Write a new claim only when a source in reach proves it.
When that code is out of reach, report the claim as not checked.
When code in reach disproves the claim, report it as a mismatch, even when other code is out of reach.
Report a claim as not checked only when nothing in reach disproves it.
A claim about what this code does is checked against this code, even when other code might add to it.
A claim reported as not checked keeps its fact, though the writing rules may reword it.
Only the rule that comments are not tutorials may remove it.

A claim about how a tool, a library or an engine behaves, such as an exit code, an output stream or where a file goes, is a tool claim.
Check it against the tool's help or documentation, or with a run that changes nothing outside a temporary folder.
Never run a command that could change the user's files, a remote or a shared service to check a claim.
When unsure what a run changes, do not run it.
A tool claim that the help or documentation disproves is a mismatch, and sort step 4 keeps it unchanged.
A tool claim that cannot be checked is reported as not checked.

A claim that lists callers, copies or cases is incomplete when code in reach shows one it leaves out.
When the completed sentence fits within the project's line width, or else within 80 characters, complete it from the code and report the change.
Otherwise name the groups the code defines, such as a base class, a folder or a tag.
Add examples with "such as", and report the change.
When the code defines no groups, report the list as incomplete, with the items it leaves out.
When the claim uses "only", "never", "all" or a similar word, keep it unchanged and report it as a mismatch instead.
When another sentence of the comment names the item the claim leaves out, name that sentence in the entry and keep it unchanged too.
A list given as examples, with "such as", "for example" or a similar phrase, claims no complete set.
Do not complete it.

Reading other code to check a claim does not bring its comments into scope.
Do not change those comments or mention them in the report.

## Kinds

An interface comment tells a caller how to use the code.
It sits above a declaration, or it is a doc comment, an editor tooltip or a file header.
It covers what a caller needs and the declaration does not show:

- what each parameter means, its units, and the values the code rejects;
- what the return value means, including null or empty results;
- errors, side effects, ownership, and costs a caller must plan for.

It never describes how the body works.
"Interface" does not mean public.
A comment above a private helper is an interface comment for the code that calls it.

An implementation comment sits inside a body.
It tells a maintainer why the code has this shape.

Write a guarantee only when the code shows it.
Never invent thread safety, ownership, lifetime or performance claims.

When an interface comment holds an implementation fact, move the fact into the body, next to the code it explains.
Then run the delete test on it there.

### Editor Tooltips

A comment the editor shows as a tooltip is an interface comment for a designer.
It says what the value does, its units and its range, where the declaration and its annotations do not show them.

- Unreal shows the comment above a `UPROPERTY` or `UFUNCTION`.
- Godot 4 shows a `##` comment above an `@export` variable.

When the editor reads the tooltip from code, such as Unity's `[Tooltip]` attribute, report a missing tooltip and the text it would hold, instead of writing it.

### File Headers

A file header is an interface comment for the whole file, and holds only facts about the whole file.
For the delete test, read the file name and its public declarations, not the bodies.
A new header goes after the shebang, the encoding line and any licence notice.
Separate a new header from the comment or code below it with a blank line.
Leave usage to the help the tool prints.
Usage means commands, arguments, flags, exit codes and call examples.
The header still states what the file does and its side effects.

## Operations

Run only the operation the user asked for.

**Add**

Write a comment where the add test passes.
When the user asks for a comment on every item, skip items where nothing passes the delete test, and list them in the report.
A project rule that requires the comment still wins.

**Improve**

Improve covers requests to rewrite, shorten, clean up or remove comments.
Run the sort on every existing comment in scope.
Also add each missing fact where the add test passes, as a new comment or as a new sentence in an existing one.
When the user asked only to shorten or remove comments, report a missing fact instead of adding it.

**Review**

Answer in the conversation with these rules.
Change no files.
Report each change Improve would make, with the proposed text, under **Proposed Changes**.

## The Sort

Sort each comment that existed before this run.
A sentence you wrote in this run is never sorted, and the Final Check covers it instead.

For the whole comment:

1. Protected: keep it unchanged.
   When only part of a comment is protected, such as a doctest, keep that part unchanged and sort the rest.
2. Commented-out code: keep it unchanged and report it.
   Delete it only when the user asks to remove commented-out code.
3. Makes up for a bad name: report the name.
   The rename is the user's decision.
   The sentence that makes up for the name passes step 5.

Then for each sentence of any comment that steps 1 and 2 do not keep:

4. Contradicts the code: a sentence with any reading that contradicts the code counts.
   Keep it unchanged and report the mismatch.
   Do not guess which side is wrong.
   - Delete it instead when another sentence of the comment, already there before this run, states the reading that matches the code.
     Report the deletion.
   - Correct it instead when the wrong word is not part of the fact the sentence exists to state, and the code shows the right word.
     Report the correction.
     When unsure, keep it unchanged.
   - Never add a sentence that contradicts a kept one.
     Name the true fact and its source in the report instead.
   - An incomplete list follows Claims About Other Code instead of this step.
   - A sentence with no condition, and no word such as "always", "never", "every" or "only", describes the main path.
     When the code follows that path except in a case the sentence does not name, such as an error or an early exit, it is not a contradiction.
     Continue with step 5, and treat the missing case as a missing fact.
5. Fails the delete test: delete it.
   - When a sentence kept unchanged depends on a sentence you delete, say in its report entry that its subject was in the deleted sentence.
   - If the code passes the add test, write the missing fact instead.
   - Never delete a part of a doc comment that project rules or tools require.
     A doc comment the program reads at runtime, such as help text or reflection, counts as required.
     Replace a failing required part with a fact the caller needs.
     If no source gives such a fact, keep the part unchanged.
6. Passes: keep its facts.

Then apply the writing rules to what is left.

### Kept Text

Text these rules keep unchanged stays as it was, so the user can judge it.

- Protected text and commented-out code keep everything: text, spacing, line breaks and position.
- Any other text kept unchanged keeps its words, and each of its sentences is joined onto one line.
  When a required line width forbids the join, keep its line breaks.

The writing rules and the Final Check skip text kept unchanged.
Only text that existed before this run can be kept unchanged.

## Writing Rules

- One fact per sentence.
  What the code does and why share one sentence: "Limits X to avoid Y."
- One sentence per line.
  A sentence never wraps onto a second line.
- A parameter entry, a list item or a table row may be a name followed by a phrase.
- A tab counts as the width a project rule sets, such as `tab_width` in `.editorconfig`, or else as 4 characters.
- When a project rule sets a line width, such as a formatter, a linter or a style guide, keep every line within it.
  If a sentence still does not fit after its words are shortened, report the line.
- Without a project rule, aim for 80 characters, indentation included.
  When a sentence is longer, first cut words that carry no fact.
  If it still holds two or more facts, split it into one sentence per fact.
  If it holds one fact, or one fact and its reason, keep it on one line.
- Never split what the code does from its why.
  After any other split, run the delete test on each new sentence, and delete a sentence that fails.
  If a remaining sentence loses its subject, name the subject in it.
- Do not join clauses with a colon, a semicolon or a dash.
  A colon or a dash after the name in a parameter entry, a list item or a table row is not a join.
- Join a fact to its reason with "because" or "so" at most once per comment.
- Write what the code does first, then why.
- When the reader must not change something, say so first, then why.
  Such a sentence may tell the reader directly, such as "Do not remove the default."
- Use common words.
  No idioms.
  No compressed grammar.
  Explain a technical term the code does not define.
- Otherwise use the third person with no subject: "Updates main", not "Update main" or "This function updates main".
- Use an identifier only when it is more precise than words.
- Match related comments, and the project's terms, in wording and detail.
  This shapes a comment that exists or passes the add test.
  It never adds a comment on its own.
- Cut words that carry no fact.
  Never cut a fact that passes the delete test to save words.

Comments are not tutorials.
Do not explain how the language, the engine, a library or a tool behaves.
When such behaviour forces unusual code, the why names what this code needs or what breaks without it.
When the code relies on a fact about the engine, a library or a tool, such as where it puts a file, state that fact in the why.
Leave out how the tool arrives at it.
Explain the language only when the user says the code is an example or teaching project.

## Labels

Use a label only when it classifies the comment usefully:

- `TODO`: work to finish later.
- `FIXME`: known wrong behaviour.
- `NOTE`: an easy-to-miss fact.
- `WARNING`: a risk, code that must not change, or a value that must change with its copies.

Use the project's labels and format when it defines them.
Follow a label with a complete sentence.

## Protected Comments

Keep these unchanged:

- copyright, licence, SPDX and attribution notices;
- generated-code and "do not edit" markers;
- compiler, build, linter, formatter and coverage directives, and suppression markers;
- markers that documentation generators or other tools read;
- code inside a doc comment, such as a doctest.

A doc tag, such as `@param`, is not a marker when the language's or engine's documentation, read in this run, shows its tools do not read the tag, and no project file names another tool that does.
Never put a comment between a directive and the line it applies to.
When unsure whether a comment is protected, keep it unchanged and report it.

## Output

- With file access, edit the files directly.
  Show a diff only when the user asks for one.
- With pasted code, return the full code through its last line, with the comment changes.
  Do not replace code with placeholders.
- End with the report.

### Report

Group the report by file when there is more than one file.
Leave out empty items.
In each group, list first an entry that may show a bug in the code.

A Review report opens with **Proposed Changes**, before the two groups below.

**Needs Your Decision**

- a sentence that contradicts the code;
- a comment that makes up for a bad name;
- a missing fact with no source;
- items skipped in an "every item" request;
- commented-out code, kept;
- a line that does not fit the project's line width;
- an incomplete list whose items the code does not group;
- a missing tooltip that the editor reads from code.

**For Your Information**

- how many comments were deleted, and each deleted comment in full when its file is not under version control;
- each contradicting sentence deleted because an older sentence states its true reading;
- each word corrected under sort step 4;
- each list completed or replaced by groups;
- required parts kept unchanged;
- what you could not check, and why;
- the files not done, when the run stopped before every file was done;
- one line on what you assumed, and the comment rules and conventions you followed with their source, or that the project has none.

## Final Check

Before returning:

- Run the delete test on every sentence you wrote or left in place, except text kept unchanged.
- Check the writing rules on every sentence you wrote or changed.
- List each sentence you wrote, with the code, tool help or documentation it depends on, including code outside its own lines.
  Read that source again, and rewrite or delete a sentence with any reading that contradicts it.
  Do not rely on what you read while drafting.
- Read each comment you wrote or changed with only the code it sits on.
  Name the subject of any pronoun that this leaves unclear.
- List the facts that passed the sort.
  Each one is still in a comment, unless the rule that comments are not tutorials, or a later delete test, removed it.
- Count the code lines, leaving out comments and blank lines.
  They match the input, in the same order.
