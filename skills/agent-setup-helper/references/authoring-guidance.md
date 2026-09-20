# Authoring Guidance

Load this reference when designing or reviewing a Skill, a reference or a
template.

## Boundary

This file answers one question: what makes a Skill, a reference or a template
well designed?

It owns the criteria for each of those three, the rules that apply across
them, instruction design and the Severity Order.

It does not own `AGENTS.md` design (`agents-md.md`), where content belongs
(`architecture-analysis.md`), unsafe patterns (`safety.md`), or when a stage
runs (`SKILL.md`).

This is knowledge, not permission. Nothing here authorises a change.

Identify the artefact type before applying any criterion below.

## Skill

Focus on:

- purpose;
- the conditions that trigger it, and the ones that must not;
- scope boundaries;
- workflow and behavioural rules;
- inputs and dependencies;
- decision points;
- exceptions;
- expected output;
- interaction with other skills and instructions.

A skill should be specific enough to produce reliable behaviour, without
constraining tasks it was never meant to cover.

The two failures are symmetrical. A skill too vague to change behaviour costs
context and gives nothing back. A skill too broad fires on work it does not
understand, and the user has to undo it.

## Skill Reference

Focus on:

- whether it holds reusable knowledge, rather than behavioural rules that
  belong in `SKILL.md`;
- whether the skill says clearly when to consult it;
- whether the information is complete enough to act on;
- whether it stays consistent with its parent skill;
- whether an important rule is hidden here, where it may never be read.

A reference supports a skill. It must not quietly redefine it.

The hidden-rule case is the one to watch. A rule in a reference only applies
when something loads that reference, so a rule that must always hold belongs
in `SKILL.md`, however well it fits the reference's topic.

## Skill Template

Focus on:

- what structure or behaviour must be preserved;
- what the author is expected to change;
- whether the placeholders are obvious;
- whether an example reads as a requirement by accident;
- inherited content that no instance needs;
- assumptions that will not hold for every use;
- whether the generated artefact still makes sense once the template's own
  context is gone.

A template should give a useful starting structure, without forcing an
irrelevant requirement into every instance.

## Cross-Artifact Rules

When related artefacts are available, review them as one system.

Check whether:

- an `AGENTS.md` and a skill assign conflicting behaviour;
- a skill duplicates or overrides project instructions unintentionally;
- a reference holds a behavioural requirement its skill never surfaces;
- a template contradicts the rules governing what it produces;
- a term means different things in different files;
- one decision is defined differently in two places;
- changing one artefact would leave another stale.

Prefer a single source of truth for important behaviour where that is
practical.

Do not remove deliberate duplication before understanding why it exists. It
may be there for discoverability, for reliability, or because the two copies
are meant to diverge.

### Supplied Sources

When the author provides existing files — an `AGENTS.md`, a skill, a
reference, a template, a specification, examples, project instructions or a
past discussion — use them as the primary basis for the work.

When supplied sources conflict: name the conflict, explain why it matters, and
ask the author to resolve it. Do not choose one silently.

An outside recommendation is allowed. Mark it clearly as an outside
recommendation, and never present it as a project requirement.

## Instruction Design

### Content Roles

Five kinds of content appear in these files, and they carry different weight.

| Role | What it is |
|---|---|
| Behavioural instruction | A rule the agent must follow |
| Rationale | Why the rule exists |
| Reference information | Supporting knowledge |
| Example | An illustration of intended behaviour |
| Template | A reusable starting structure |

Do not let rationale, an example or reference material introduce a
requirement by accident. An example written in the imperative reads as a rule.

Put a rule where the agent will meet it while deciding what to do.

### Specificity

Prefer a rule precise enough to guide behaviour, and no more restrictive than
it needs to be.

Watch vague terms: "when appropriate", "if needed", "normally", "where
possible", "use judgment", "complex", "significant", "relevant".

These are not automatically wrong. Challenge one only when two reasonable
readings would produce materially different behaviour. A vague word in a rule
about wording costs nothing; the same word in a rule about permissions is a
decision nobody made.

### Examples

Treat an example as a test of a rule, not a replacement for it.

Check whether:

- the rule is understandable without the example;
- the example actually follows the rule;
- a reader could mistake the example for the complete list;
- a copied value could quietly become a default.

Prefer a clear rule followed by the smallest example that clarifies it.

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

For a substantial artefact, also check whether:

- purpose and scope are clear;
- important rules and exceptions are explicit;
- terminology is consistent;
- examples agree with their rules;
- references and templates agree with their parents;
- required context exists only outside the artefact;
- redundant content can go;
- the expected action is clear.
