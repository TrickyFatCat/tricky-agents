---
name: code-comments
description: Use this skill when the user asks to add, improve, rewrite, shorten, clean up or review code comments or documentation comments, including docstrings, doc blocks and editor tooltips. Use it even when the user only says the comments are unclear, too long or obvious. Do not use it for comments written while implementing, fixing or refactoring code.
---

# Code Comments

A comment tells the reader something they need and cannot get from the code, its names, or the language.
This skill adds such comments, and deletes, replaces or reports the rest.

## Invariant

Preserve all non-comment code exactly, including identifiers, literals, ordering, behaviour and formatting.
Do not refactor, rename, reformat, optimise or correct code.
If a comment change would need a code change, report the conflict instead.

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
- a caller could pass a value the code rejects or treats specially, or needs a unit to use a value correctly.

### Delete Test

Hide the comment.
Read the code and its names.
For an interface comment, read only the declaration: its name, parameters and types.
If a reader who knows the language could write the comment from that, delete it.

### Claims About Other Code

A comment can claim something about code outside its own lines, such as "change nothing else", "the only caller" or "never null".
Check each such claim against that code before you keep or write it.
When that code is out of reach, report the claim as not checked.
When code in reach disproves the claim, report it as a mismatch, even when other code is out of reach.
Report a claim as not checked only when nothing in reach disproves it.
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

State a guarantee only when the code shows it.
Never invent thread safety, ownership, lifetime or performance claims.

When an interface comment holds an implementation fact, move the fact into the body, next to the code it explains.
Then run the delete test on it there.

### Editor Tooltips

A comment the editor shows as a tooltip is an interface comment for a designer.
It says what the value does, its units and its range.

- Unreal shows the comment above a `UPROPERTY` or `UFUNCTION`.
- Godot 4 shows a `##` comment above an `@export` variable.

### File Headers

A file header is an interface comment for the whole file.
A file header holds only facts about the whole file.
For the delete test, read the file name and its public declarations, not the bodies.
A new header goes after the shebang, the encoding line and any licence notice.
Leave usage and arguments to the tool's help comments when the tool prints them.

## Operations

Run only the operation the user asked for.

**Add**

Write a comment where the add test passes.
When the user asks for a comment on every item, skip items where nothing passes the delete test, and list them in the report.
A project rule that requires the comment still wins.

**Improve**

Improve covers requests to rewrite, shorten, clean up or remove comments.
Run the sort on every existing comment in scope.
Also add a comment where the add test passes and no comment exists.
Take the fact only from the code, its history, or the user.
If no source gives it, report the missing fact.

**Review**

Answer in the conversation with these rules.
Change no files.

## The Sort

Sort each existing comment before you reword it.

For the whole comment:

1. Protected: leave it unchanged.
2. Commented-out code: keep it and report it.
   Delete it only when the user asks.
3. Makes up for a bad name: keep it and report the name.
   The rename is the user's decision.
   Never rename.

Then for each sentence of any other comment:

4. Contradicts the code: keep the sentence unchanged and report the mismatch.
   Do not guess which side is wrong.
5. Fails the delete test: delete it.
   - If the code passes the add test, write the missing fact instead.
     Take the fact only from the code, its history, or the user.
     If no source gives it, report the missing fact.
   - Never delete a part of a doc comment that project rules or tools require.
     A doc comment the program reads at runtime, such as help text or reflection, counts as required.
     Replace a failing required part with a fact the caller needs.
     If no source gives such a fact, keep the part as it is.
6. Passes: keep its facts.

Then apply the writing rules to what is left.

## Writing Rules

- One fact per sentence.
  What the code does and why share one sentence: "Limits X to avoid Y."
- One sentence per line.
  When a sentence is too long for one line, split it into two sentences.
  Keep every fact.
- Never split what the code does from its why.
  After any other split, run the delete test on each new sentence, and delete a sentence that fails.
  A sentence that carries a why passes, even when its what-part repeats the code.
  If a kept sentence loses its subject, name the subject in it.
- Do not join clauses with a colon, a semicolon or a dash.
- Join a fact to its reason with "because" or "so" at most once per comment.
- Write what the code does first, then why.
- When the reader must not change something, say so first, then why.
- Use common words.
  No idioms.
  No compressed grammar.
  Explain a technical term the code does not define.
- Use the third person with no subject: "Updates main", not "Update main" or "This function updates main".
- Use an identifier only when it is more precise than words.
- Match related comments, and the project's terms, in wording and detail.
- Cut words that carry no fact.
  Never cut a fact that passes the delete test to save words.

Comments are not tutorials.
Do not explain how the language, the engine, a library or a tool behaves.
The reader knows them better than you.
When such behaviour forces unusual code, write only what this code does and why, in this code's terms.
Leave out the mechanics behind it.
Explain the language only when the user says the code is an example or teaching project.

## Labels

Use a label only when it classifies the comment usefully:

- `TODO`: work to finish later.
- `FIXME`: known wrong behaviour.
- `NOTE`: an easy-to-miss fact.
- `WARNING`: a risk, or code that must not change.

Use the project's labels and format when it defines them.
Follow a label with a complete sentence.

## Protected Comments

Leave these exactly as they are, including text, spacing and position:

- copyright, licence, SPDX and attribution notices;
- generated-code and "do not edit" markers;
- compiler, build, linter, formatter and coverage directives, and suppression markers;
- markers that documentation generators or other tools read;
- code inside a doc comment, such as a doctest.

Never put a comment between a directive and the line it applies to.
When unsure whether a comment is protected, leave it unchanged and report it.

## Output

- With file access, edit the files directly.
  Show a diff only when the user asks for one.
- With pasted code, return the full code through its last line, with the comment changes.
  Do not replace code with placeholders.
- End with the report.

### Report

Group the report by file when there is more than one file.
Leave out empty items.

**Needs Your Decision**

- a sentence that contradicts the code;
- a comment that makes up for a bad name;
- a missing fact with no source;
- items skipped in an "every item" request;
- commented-out code, kept.

**For Your Information**

- how many comments were deleted, and each deleted comment in full when its file is not under version control;
- required parts kept unchanged;
- what you could not check, and why;
- the files not done, when the run stopped before every file was done;
- one line on what you assumed, including the source of any convention you followed.

## Final Check

Before returning:

- Run the delete test on every sentence you wrote or kept.
- Check the writing rules on every sentence.
- Count the non-comment lines.
  They match the input, in the same order.
