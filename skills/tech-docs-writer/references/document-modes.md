# Document Modes

Read this reference when selecting or adapting a document's shape.

This file owns which document this is, what shape it takes, and the shared
reference entry contract.

Use [Diátaxis](https://diataxis.fr/) as the baseline for instructions, how-to,
reference and explanation.

## Selecting A Mode

Choose one primary mode from the reader's immediate need. Combine modes
through clear boundaries and links, never by blending them.

Use the artifact name as evidence, not as the decision.

| Reader need                             | Primary mode   | Default result                                           |
| --------------------------------------- | -------------- | -------------------------------------------------------- |
| Orient a repository visitor             | README         | A concise entry point with the next useful action.       |
| Look up a source-level symbol           | Code Reference | A consistent inventory of the exported surface.          |
| Look up a command                       | CLI Reference  | A consistent inventory of invocations and their effects. |
| Learn by completing a guided experience | Instructions   | A controlled path that builds confidence and skill.      |
| Complete a known goal                   | How-to         | A focused sequence that reaches one practical outcome.   |
| Follow a repeated multi-party process   | Workflow       | Role-labelled steps with entry conditions and handoffs.  |

Combine modes through clear boundaries instead of blending them:

- Keep the primary path focused on one reader need.
- Link to a separate reference when exhaustive details would interrupt
    instructions or a how-to guide.
- Add a short explanation only when it helps the reader make a decision.
- Keep symptom-led troubleshooting separate from normal operation unless one
    local warning belongs beside the affected step.

Apply project instructions, renderer conventions, headings, TOCs, callouts,
and formatting after selecting the mode.

## Instructions Versus How-to

This is the distinction most often got wrong, so it gets a concrete test.

|             | Instructions (tutorial)   | How-to                |
| ----------- | ------------------------- | --------------------- |
| Reader is   | At study                  | At work               |
| Path        | A single line, no choices | Forks and branches    |
| Environment | Contrived, controlled     | The real world        |
| Safety      | Must be safe to restart   | Cannot promise safety |
| Basics      | Stated explicitly         | Assumed               |

Complexity is not the test. Both modes cover basic and advanced material; what
differs is whether the reader is acquiring competence or applying it.

## Workflow Mode

A workflow document describes a repeated process with several participants. It
is not a how-to with more steps.

### Required Shape

Every step names its actor, its entry condition and its handoff. A step with
no named actor is the defect this mode exists to catch.

```text
Step        Enemy damage sign-off
Actor       Combat designer
Entry       Draft numbers are in the balance sheet
Action      Review against the damage budget, approve or return with notes
Handoff     Approved numbers go to the build; returned notes go to the designer
```

### Prescriptive Or Descriptive

Settle this at the context gate. A prescriptive workflow makes deviation a
defect. A descriptive one records what currently happens and makes deviation
information.

### Not Second Person

A how-to addresses "you". A workflow cannot, because "you" is a different
person at each step. Use role labels. Voice in
[markdown-conventions.md](markdown-conventions.md) owns the general rule for
"you".

### Authority

A workflow has no implementation to read. See
[source-verification.md](source-verification.md).

## Instructions

**Reader need**

Learn by completing a guided, reliable experience. This is the Diátaxis
tutorial.

**Use when**

- The reader is new to the tool or concept.
- The sequence teaches through doing.
- A controlled path can produce a meaningful result.

**Avoid when**

- The reader only needs a fact or command signature.
- Several optional branches would obscure the learning path.
- The task assumes context that should be taught first.

**Adaptable structure**

1. State the learning outcome.
2. List only prerequisites needed to begin safely.
3. Establish a known starting state.
4. Lead the reader through ordered steps.
5. Show meaningful intermediate or expected results.
6. Verify the final outcome.
7. Summarize what the reader learned and identify one useful next step.

**Omit or limit**

- Exhaustive option inventories.
- Multiple competing setup paths.
- Long conceptual digressions.
- Edge cases that do not affect the guided path.

Example outline:

```markdown
# Build Your First Local Preview

## Outcome

## Requirements

## Start the Preview

## Make a Change

## Verify the Result

## Next Step
```

## How-to Guide

**Reader need**

Complete a specific practical goal.

**Use when**

- The reader knows the basic context.
- The task has a recognizable outcome.
- Steps, choices, and verification can stay focused on that outcome.

**Avoid when**

- The primary purpose is teaching foundational concepts.
- The reader needs a complete interface inventory.
- The document mainly explains why a system behaves as it does.

**Adaptable structure**

1. Name the goal in the title or opening sentence.
2. State prerequisites or assumptions only when they affect success.
3. Provide the shortest safe sequence.
4. Explain meaningful choices beside the affected step.
5. Show expected output or a verification command.
6. Add focused recovery or rollback guidance when failure or persistence
    matters.

**Omit or limit**

- Broad introductions.
- Unrelated alternatives.
- Full command or API inventories.
- Troubleshooting that does not affect this goal.

Example outline:

```markdown
# Configure a Local Cache

## Requirements

## Configure the Cache

## Verify the Configuration

## Roll Back
```

## Reference

**Reader need**

Look up accurate, complete, and consistently organized facts.

**Use when**

- Readers need syntax, options, defaults, schemas, return values, or
    compatibility details.
- Completeness and consistency matter more than a guided narrative.
- Entries can follow a stable repeated shape.

**Avoid when**

- The reader needs a first successful experience.
- The main goal is one procedure.
- The content depends on conceptual argument rather than lookup.

**Adaptable structure**

1. Define scope and source authority.
2. Group entries by the reader's lookup path.
3. Use a consistent field order.
4. Document names, syntax, inputs, defaults, outputs, effects, and errors as
    applicable.
5. Include small examples only when they clarify exact use.
6. Record version or compatibility boundaries near the affected entries.

**Omit or limit**

- Walkthroughs that belong in instructions.
- Repeated conceptual rationale.
- Examples that do not clarify a distinct behavior.
- Sections whose only purpose is to make every entry look identical.

Reference splits by subject. `cli-reference.md` owns the command line and
`code-reference.md` owns the source-level API.

Example entry shape:

```markdown
## `preview`

Syntax, arguments, options, output, side effects, errors, and one focused example.
```

## README

Treat a README as an entry point, not a mandatory fixed template.

Include only what helps the intended visitor choose the next action. Order it
from the broadest to the most specific, so a visitor who has decided can stop
reading:

1. What the project is, in one or two sentences.
2. The shortest useful example.
3. Requirements that affect first use, and install.
4. Common usage.
5. Links to focused setup, usage, reference, or contributor documentation.
6. Background and credits, when there are any.

Leave out a step that does not apply.

Do not duplicate detailed documentation merely to make the README
self-contained.

## Secondary Modes

Use these modes when the reader need is not covered well by the primary modes.

Do not impose the requirements of instructions on a maintainer reference or a
personal note.

### Explanation

**Reader need**

Understand a concept, relationship, cause, design choice, or trade-off.

**Use when**

- Readers need context to reason or make decisions.
- The important content is why or how concepts relate.
- Alternatives and consequences matter.

**Avoid when**

- The reader needs an immediate procedure.
- A concise reference entry answers the question.
- The explanation would delay a safety-critical action.

**Adaptable structure**

1. State the question or concept.
2. Establish relevant context and assumptions.
3. Explain the mechanism or relationship.
4. Compare alternatives or trade-offs when they affect understanding.
5. Connect the explanation to practical implications.
6. Link to procedures or reference material rather than duplicating them.

**Omit or limit**

- Step-by-step instructions that belong in a how-to guide.
- Exhaustive lookup tables.
- Historical detail that does not change understanding.
- Conclusions unsupported by source material.

Example outline:

```markdown
# Why Target-Local Formatting Takes Precedence

## Context

## Configuration Discovery

## Trade-offs

## Practical Consequences
```

### Troubleshooting

Connect symptoms to safe diagnosis and recovery.

Use a repeated shape when practical:

1. Symptom or exact error.
2. Safe inspection command or check.
3. Likely causes in useful order.
4. Smallest reversible fix.
5. Verification.
6. Recovery or escalation when the fix fails.

Keep expected normal states with the feature that produces them. Add a
troubleshooting entry only when symptom-led diagnosis or recovery adds value.

### Maintainer Documentation

Help contributors locate, validate, change, and extend a project safely.

Prefer:

- purpose and scope;
- authoritative paths;
- conventions and invariants;
- validation commands and expected results;
- extension points;
- common maintenance failures;
- related decisions or design material.

Keep wording compact and low-maintenance. Do not add onboarding sections
unless maintainers need them.

### Personal Documentation

Preserve owner preferences, local shorthand, compact reminders, and
established conventions.

Prefer retrieval value over generic onboarding. Do not expand personal notes
into tutorials unless the user requests that change.

## Shared Reference Entry Contract

Both `cli-reference.md` and `code-reference.md` inherit this shape. This file
is its only owner.

```text
Name or signature
One-sentence purpose          does not repeat the name
Inputs                        name, type, required or optional, default
Output                        return value or result
Errors                        what fails, and why
Side effects                  state changed outside the return
Example                       one, the smallest realistic case
```

Field order is fixed. Omit a field that does not apply. Never keep an empty
field to make entries look identical.

## Adapting

- Start with the smallest structure that satisfies the reader need.
- Omit sections whose absence creates no confusion, risk or failed action.
- Preserve established project structure unless the user approves a change.
- Split a document when competing reader needs obscure its primary path.
- Link related modes instead of duplicating large sections.
- Remove sections added only because an example outline showed them.

The question each section answers is decided before drafting. Structure in
`SKILL.md` owns that rule.

## Sources

Fetched 2026-09-20.

- <https://diataxis.fr/>
- <https://diataxis.fr/tutorials-how-to/>
