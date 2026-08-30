<h1>Documentation Modes</h1>

Read this reference when selecting or adapting the structure of human-facing technical documentation.

Use [Diátaxis](https://diataxis.fr/) as the main baseline for tutorials, how-to guides, reference, and explanation. Select the reader need before applying renderer syntax or project-local formatting.

<!--toc:start-->

- [Choose a Mode](#choose-a-mode)
- [Tutorial](#tutorial)
- [How-to Guide](#how-to-guide)
- [Reference](#reference)
- [Explanation](#explanation)
- [Additional Technical Modes](#additional-technical-modes)
    - [Troubleshooting](#troubleshooting)
    - [Maintainer Documentation](#maintainer-documentation)
    - [README](#readme)
    - [Personal Documentation](#personal-documentation)
- [Adapt the Structure](#adapt-the-structure)

<!--toc:end-->

## Choose a Mode

Choose one primary mode from the reader's immediate need:

| Reader need                         | Primary mode             | Default result                                                    |
| ----------------------------------- | ------------------------ | ----------------------------------------------------------------- |
| Learn through a guided experience   | Tutorial                 | A controlled path that builds confidence and skill.               |
| Complete a known goal               | How-to guide             | A focused sequence that reaches one practical outcome.            |
| Look up accurate facts              | Reference                | A consistent inventory of behavior, syntax, or interfaces.        |
| Understand context or reasoning     | Explanation              | A conceptual account of relationships, causes, and trade-offs.    |
| Diagnose and recover from a symptom | Troubleshooting          | Symptom-led checks, likely causes, and recovery paths.            |
| Maintain or extend a project        | Maintainer documentation | Compact conventions, locations, validation, and extension points. |
| Orient a repository visitor         | README                   | A concise entry point with the next useful action.                |
| Preserve owner-specific knowledge   | Personal documentation   | Compact reminders and established preferences.                    |

Use the artifact name as evidence, not as the decision. A file named `README.md` may still be primarily a how-to guide or maintainer reference.

Combine modes through clear boundaries instead of blending them:

- Keep the primary path focused on one reader need.
- Link to a separate reference when exhaustive details would interrupt a tutorial or how-to guide.
- Add a short explanation only when it helps the reader make a decision.
- Keep symptom-led troubleshooting separate from normal operation unless one local warning belongs beside the affected step.

Apply project instructions, renderer conventions, headings, TOCs, callouts, and formatting after selecting the mode.

## Tutorial

**Reader need**

Learn by completing a guided, reliable experience.

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
6. Add focused recovery or rollback guidance when failure or persistence matters.

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

- Readers need syntax, options, defaults, schemas, return values, or compatibility details.
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
4. Document names, syntax, inputs, defaults, outputs, effects, and errors as applicable.
5. Include small examples only when they clarify exact use.
6. Record version or compatibility boundaries near the affected entries.

**Omit or limit**

- Tutorial-like walkthroughs.
- Repeated conceptual rationale.
- Examples that do not clarify a distinct behavior.
- Sections whose only purpose is to make every entry look identical.

For command-oriented references, also read [command-reference.md](command-reference.md).

Example entry shape:

```markdown
## `preview`

Syntax, arguments, options, output, side effects, errors, and one focused example.
```

## Explanation

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

## Additional Technical Modes

Use these modes when the reader need is not covered well by the four primary Diátaxis modes.

### Troubleshooting

Connect symptoms to safe diagnosis and recovery.

Use a repeated shape when practical:

1. Symptom or exact error.
2. Safe inspection command or check.
3. Likely causes in useful order.
4. Smallest reversible fix.
5. Verification.
6. Recovery or escalation when the fix fails.

Keep expected normal states with the feature that produces them. Add a troubleshooting entry only when symptom-led diagnosis or recovery adds value.

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

Keep wording compact and low-maintenance. Do not add onboarding sections unless maintainers need them.

### README

Treat a README as an entry point, not a mandatory fixed template.

Include only what helps the intended visitor choose the next action, such as:

- what the project is;
- the shortest useful example;
- requirements that affect first use;
- links to focused setup, usage, reference, or contributor documentation.

Do not duplicate detailed documentation merely to make the README self-contained.

### Personal Documentation

Preserve owner preferences, local shorthand, compact reminders, and established conventions.

Prefer retrieval value over generic onboarding. Do not expand personal notes into tutorials unless the user requests that change.

## Adapt the Structure

Use these rules for every mode:

- Start with the smallest structure that satisfies the reader need.
- Omit sections whose absence does not create confusion, risk, or failed action.
- Keep source validation independent from presentation mode.
- Preserve established project structure unless the user approves a change.
- Separate primary content from renderer-specific headings, TOCs, callouts, links, or extensions.
- State assumptions when the requested mode or audience remains uncertain.
- Split a document when competing reader needs make its primary path difficult to follow.
- Link related modes instead of duplicating large sections.

After drafting, verify that each major section supports the selected reader need. Remove sections added only because they appear in an example outline.
