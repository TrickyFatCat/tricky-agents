# Review

Read this file before writing a review.
Lay the review out with `assets/review-template.md`.

A review explains each problem and gives a hint.
It never writes the fix, because the user makes the change.
A typo's corrected spelling is the one exception.
A risk gets a fix direction instead of a hint, because a risk must not wait for the learner.

A reader skims a review.
Keep each finding short, so its size matches the size of the problem.

## What To Check

The Goal line decides which kinds you check.
A general goal, such as "review" or "check", checks every kind.
Risks are always checked.
A kind you did not check shows `not checked` in the Overview table and in Coverage.

- **Risks**: security, data loss, destructive steps, and secrets in the code.
- **Bugs**: code that does not do what it is meant to do.
  A deprecated command is a bug too: it works now and breaks on a later release.
  Check the failure path of each external call, meaning a call to an external program or a network request: what happens when it is missing, fails or times out.
- **Architecture**: structure that will cause problems, and when.
- **Names**: unclear names, and one value or idea with several names or terms.
- **Comments**: see Comments below.
- **Typos**: in names, strings and comments.

## Each Finding

A finding holds one problem, in this order:

1. Where it is, as `file:line`, with the function name when there is one.
2. A snippet: up to five lines of the file around the problem, unchanged.
3. The problem.
4. The hint, or a Fix Direction for a risk.

Snippets are for bugs, architecture and comments.
Names and typos keep their location lists.
When a later finding would quote the same lines, write "Snippet: see finding N" instead.
Pasted code gets no snippet, only its line, because the user already has it in front of them.
A secret never appears in a snippet. Write `<redacted>` in its place, or show no snippet.

### The Problem

Start with what the code does at that line, then the effect.
Use a concrete value, such as "A dead enemy with 0 health gets 5 health and stays `alive: false`."
Add a general rule only when the fact needs it, in one sentence after the fact.
Give each sentence its own paragraph.
Write at most three sentences. More means two problems, or a list.

Behaviour that may be deliberate gets one condition, in one sentence after the problem, such as "This is a bug if dead enemies can be healed."
Evidence of intent, such as a comment that promises a result, gets its own sentence or is left out.
When the user says the behaviour is intended, name its risk once and close it.

The hint comes right after the problem.
It must not be answerable by re-reading the problem.
Names, comments and typos get no hint, because naming the problem is enough.

### Checks And Commands

Check a suspected cause before you state it, as `SKILL.md` describes under Checking Claims.
How each finding was checked goes in the Verification section at the end, by finding number.
A check that found nothing gets one line there too, because "no findings" never means "no bugs".
A command the user must run goes there too, with what it changes stated first.

When a finding is not checked, write its problem as a condition and add one line inside the finding: "Not checked. See Verification N."
A docs link that explains the problem stays in the finding.
The second step, with the name of the technique and a link, follows `SKILL.md` under Coaching and Sources.

## Risks

State risks as `SKILL.md` describes under Risks.
In a review, the Risks section comes first after the Overview, and holds the only callout for each risk.
It lists every risk, even one stated earlier in the session.

## Grouping And Order

Group findings under one shared cause only when every finding is the same kind and the same seriousness.
Otherwise write separate findings, and add "Same cause as finding N" to the later one.

Order the sections by seriousness: Risks, Bugs, Architecture, Names, Comments.
Typos come last.
Inside each section, follow file order.
Number findings across sections, so "work through 3" names one finding.

The stage changes the weight.
In a prototype, an architecture finding that matters only at a larger scale goes to a Later section after Comments.
Other stages change nothing.
With no stage weighting, there is no Later section.

Show every finding.
Never cap or sample them, because a missing finding reads as "no problem there".

## Coverage

When you did not read every file in the target, list what you read and what you did not.

When the goal skipped some kinds, name them below the Overview table.

When there are no findings, say which checks ran and which files were not read.
"No findings" never means "no bugs".

## Comments

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

One finding and its Verification entry, from a Nushell module:

````text
#### 3. Healed Enemies Stay Dead

`enemy-utils.nu:31` — `heal`

```nu
let life = [($enemy.health + $amount) $enemy.max_hp] | math min
$enemy | upsert health $life
```

`heal` sets `health` but never changes `alive`.

A dead enemy with 0 health gets 5 health and stays `alive: false`.

This is a bug if dead enemies can be healed.

**Hint**

What should `heal` do with an enemy whose `alive` is `false`?

...

### Verification

3. Checked by reading the file: no line sets `alive` to `true`.
````
