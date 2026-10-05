# Review

Load this reference when there is an artefact to assess.

## Boundary

Sections, in order: Default Shape; Finding Shape; Severity; Severity Order;
Status Labels; Principles; Insufficient Context; Final Checks.

This file answers two questions: what is wrong with this artefact, and how bad
is it?

It owns the review shape, the finding shape, the Severity Order and the status
labels.

It does not own what to look for. `authoring-guidance.md` holds the design
criteria, `agents-md.md` the criteria for an `AGENTS.md`, and `safety.md` the
unsafe patterns.

Review never authorises a change. Do not save, annotate, propose, approve or
implement from a review. When the user decides to pursue a finding, that
starts Planning.

Keep review proportional. A long reply is still a review; length alone does
not turn it into something else.

## Default Shape

Use only the sections that help.

1. **Overview**, for three or more findings, or where orientation prevents
   confusion.
2. **General Questions**, only when a question affects the whole review. A
   question about one finding goes inside that finding.
3. **Findings**, with descriptive headings when there are several.
4. **Good Decisions**, for specific behaviour worth keeping.
5. **Recommendation**, when a short judgement helps the user decide.

For one or two direct comments, drop the headings and write prose.

Keep the recommendation broad and aimed at the decision. Do not turn it into
implementation instructions unless that detail changes the decision.

## Finding Shape

```markdown
### <Finding title>

Severity: 🔴 High | 🟡 Medium | 🟢 Low

<Observation or evidence.>

**Rationale**

<Impact, risk, reader friction, maintenance cost or failure mode.>

**Direction**

<Focused recommendation, without approving an implementation.>
```

Keep severity on its own line. Do not put it in the heading.

Omit **Rationale**, **Direction** or a question when the finding is obvious
without them.

## Severity

| Severity | Meaning |
|---|---|
| 🔴 High | The agent would act incorrectly or unsafely |
| 🟡 Medium | Two reasonable agents could act differently |
| 🟢 Low | The rule is correct, but costly to read or maintain |

Severity is about what the agent does, not about how the text reads. A
badly-worded rule that still produces one behaviour is Low. A well-written
rule that two agents would read differently is Medium.

Pair severity with the label from corner-case discovery when one applies. The
label says what kind of problem it is; severity says how much it costs.

When several findings compete for attention, order them using the Severity
Order below.

Source order is better when the user will work through the file applying the
findings. Use whichever the user will act on.

## Severity Order

When several problems exist at once, prefer this order.

1. Unsafe or destructive behaviour.
2. Incorrect or conflicting behaviour.
3. Unclear scope or instruction precedence.
4. Ambiguous decision rules.
5. Missing constraints, exceptions or dependencies.
6. Inconsistency between files.
7. Hidden assumptions or missing context.
8. Unnecessary complexity or duplication.
9. Structure and readability.
10. Wording and style.

The order is by what the agent does wrong, not by how much text is affected.
A single ambiguous permission line outranks a whole file of awkward wording.

## Status Labels

Use these for notes that are not problems.

- `Status: ✅ Accepted`
- `Status: ✅ Pass`
- `Status: 🟢 Optional polish`
- `Status: ⛔ Declined`

## Principles

- Separate confirmed problems from conditional recommendations and from style
  preferences.
- Preserve specific good decisions, without praising a weak artefact to seem
  balanced.
- Ask questions inside the finding they belong to.
- Name what was not checked. A review that is silent about its gaps reads as
  complete.

## Insufficient Context

When the artefact cannot be assessed with what was given, say so and say what
is missing.

**Example**

A `SKILL.md` arrives without the references it routes to. Its routing rules
can be read, but not whether each reference owns what the table claims. Review
what is visible, and label the rest Insufficient Context.

The general rule: review what the given material supports, and name the part
it does not. Do not infer the missing file's contents from its name.

## Final Checks

Before presenting a substantial review:

- confirm review is the right mode;
- confirm the findings are proportional and relevant to a decision;
- confirm review, proposal, approval and implementation stayed separate;
- confirm any links resolve;
- state the checks that were not performed.
