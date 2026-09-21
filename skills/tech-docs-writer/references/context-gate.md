# Context Gate

Read this reference before drafting, whenever required context is missing.

This file owns what must be known before drafting, how to ask for it, and what
happens when the user hands the choice back.

## Required Context

Two fields are required for every mode: the document mode, and the intended
reader. Each mode adds its own.

| Mode           | Also required                                                                  |
| -------------- | ------------------------------------------------------------------------------ |
| README         | Project purpose, intended visitor, the next action they take                   |
| Code Reference | Source of truth, language, public-surface boundary                             |
| CLI Reference  | The command, how to obtain its help, which commands are in scope               |
| Instructions   | Learner's starting state, the outcome, a safe environment                      |
| How-to         | Reader's existing competence, the goal, the real environment                   |
| Workflow       | Roles, trigger, terminal state, process authority, prescriptive or descriptive |

Destination and renderer are required only when the document will use Markdown
extensions. Scope boundary is required only when the request is open-ended.

## Asking

1. Ask only about what changes the document.
2. Ask one question at a time.
3. Prefer a confirmable inference over an open question.
4. Never re-ask what is already known or stated.
5. Stop asking once the answers settle what remains.

A confirmable inference is better because it is easier to answer:

```text
Weak    "Who is the reader?"
Strong  "This reads like a how-to for someone who already has the tool
         installed. Correct?"
```

## When The User Defers

This path runs when the user says "you decide", answers vaguely, or is not
present to answer.

1. Choose a value for every unresolved required field.
2. State the choices in the reply, under a heading `Assumptions`, one field
    per line with the chosen value.
3. State that the user owns the final result.
4. Continue without waiting.
5. Offer once to record the assumptions in the document as `REVIEW` markers.
    Add them only if asked.

Never record an assumption silently. The assumption block is what makes the
choice correctable.

## Review And The Gate

The gate applies to review as well as writing. A document cannot be assessed
for reader fit without knowing the reader.

Review has one fallback that writing does not: assess the document against the
reader it implies, and report the ambiguity itself as a finding. See
[review-criteria.md](review-criteria.md).
