# Review

Read this file before writing a review.
Lay the review out with `assets/review-template.md`.

A review explains each problem and gives a hint.
It never writes the fix, because the user makes the change.
A typo's corrected spelling is the one exception.
A risk gets a fix direction instead of a hint, because a risk must not wait for the learner.

## What To Check

- **Risks**: security, data loss, destructive steps, and secrets in the code.
- **Bugs**: code that does not do what it is meant to do.
- **Architecture**: structure that will cause problems, and when.
- **Names**: unclear names, and one value or idea with several names or terms.
- **Comments**: see Comments below.
- **Typos**: in names, strings and comments.

## Each Finding

Each finding gives:

- where it is, as `file:line`, with the function name when there is one;
- what goes wrong, when, and why it matters;
- a hint toward another way.

Explain the symptom and its effect.
The hint must not be answerable by re-reading the explanation.

Names, comments and typos get no hint, because naming the problem is enough.
Typos go in their own table, with the corrected spelling.

Behaviour that may be deliberate is written as a condition, such as "If you only use one monitor, this never shows."
When the user says the behaviour is intended, name its risk once and close it.

Check a suspected cause before you state it, as `SKILL.md` describes under Checking Claims.
When you cannot check it, write the finding as a condition and say it is not checked.

The second step, with the name of the technique and a link, follows `SKILL.md` under Coaching and Sources.
Risks are stated at once, as `SKILL.md` describes under Risks.

## Grouping And Order

When several findings share one root cause, name the cause once and list the findings under it.

Order the sections by seriousness: Risks, Bugs, Architecture, Names, Comments.
Typos come last.
Inside each section, follow file order.
Number findings across sections, so "work through 3" names one finding.

The stage changes the weight.
In a prototype, an architecture finding that matters only at a larger scale goes to a Later section after Comments.
With no stage weighting, there is no Later section.

Show every finding.
Never cap or sample them, because a missing finding reads as "no problem there".

## Coverage

When you did not read every file in the target, list what you read and what you did not.

When there are no findings, say which checks ran and which files were not read.
"No findings" never means "no bugs".

## Comments

These tests are adapted from the `code-comments` skill, and may differ from it on purpose.
Flag the comment. Never rewrite it.

Flag a comment that:

- contradicts the code, with the true fact and its source;
- says what the code already says, so a reader who hides the comment could write it from the code and its names;
- is commented-out code, which reads as either a planned change or dead code;
- makes up for a bad name, and flag the name instead;
- makes a claim about other code, such as "the only caller", that the code in reach disproves.

An interface comment, above a declaration, is judged by what the declaration shows, not the body.
When a caller needs a fact the declaration does not show, such as units or a null result, flag the missing fact.
Follow the project's own comment rules when it has them.

## Worked Example

One finding, from a Nushell module:

```text
#### 1. Values Lost Before The Last Line

- `mango-utils.nu:22` — `mwm-get-all-clients`, empty-fields branch
- `mango-utils.nu:40` — `mwm-get-tags --active`

Both functions produce a value, then keep running or stop without it.
Nushell hands back only the last expression of a custom command, so the value is dropped.
Callers such as other scripts get the wrong value or nothing.

Checked on Nushell 0.116 with two made-up commands.

**Hint**

How can a command stop early and still hand back a value?
```
