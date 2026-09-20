# Architecture Analysis

Load this reference for a new multi-reference Skill, or for a change that
adds, removes, splits or merges a reference.

## Boundary

This file answers one question: where does each piece of content belong?

It owns roles, unit analysis, splitting and merging, duplication ownership and
the stop rule. It does not own what makes a Skill good (`authoring-guidance.md`),
what could go wrong (`corner-case-discovery.md`), or when a change needs
planning (`SKILL.md`).

The analysis is a stage inside Planning. It produces decisions for the
register, not file changes.

## Core Principle

Every reference has one clear role, and many consumers.

A reference may cover several topics if they all serve the same role. Split
when a part answers a *different question*, not when it covers a different
topic.

Other references may use that role. They must not become second owners of it.

Clear responsibility is necessary but not sufficient for a separate file. A
split needs both a distinct responsibility and positive value once loading,
routing, maintenance, duplication and readability are counted.

The goal is not the smallest number of files, nor the largest. It is the
architecture that is easiest to maintain.

## Scope

Use a **full analysis** for a new multi-reference Skill or a major
restructuring. It reviews every unit and ends with the audit.

Use a **targeted analysis** for a smaller change. It reviews the affected
units, their boundaries, and any reviewed unit the change makes stale.

A Skill that becomes multi-reference during planning gets a targeted analysis
of the new reference and the boundaries it touches. Do not restart as a full
analysis.

Escalate a targeted analysis only when it exposes broad restructuring, several
stale ownership decisions, or a problem across the whole system.

## Unit Analysis

Work on one architectural unit at a time: normally one reference, and
`SKILL.md` whenever its own responsibilities are in question.

This applies to material that does not exist yet. A section being drafted is a
unit, and asking where it belongs before writing it is cheaper than moving it
afterwards.

### Assign A Provisional Role

Give each unit a role that answers: what responsibility is this supposed to
own?

A role must be specific enough to test contents against. "Review" is a topic.
"What is wrong with this artefact?" is a role.

Roles are hypotheses. They are a starting model, not a structure to defend.

### Read The Contents

Inspect what the file actually contains before changing anything. Then ask:

- What responsibility does it actually serve?
- Does every important part support that responsibility?
- Does another unit already serve it?
- Does it combine independent responsibility questions, rather than several
  topics inside one?

A useful test: if this file did not exist, which responsibility would have no
clear source?

### Compare And Correct

Compare the real responsibility with the assigned role, then choose the
smallest correction that makes ownership clear: keep it, move material to its
owner, split it, replace a copy with a cross-reference, redefine the role, or
create a new unit.

Do not create a reference because a sub-topic feels different. Create one when
it answers a distinct question and passes both split gates.

### Role Warning Signs

A role is probably wrong or too broad when:

- substantial sections answer different responsibility questions, rather than
  different topics inside one;
- material needs an exception to explain why it lives there;
- the name describes a broad topic rather than a usable responsibility.

When one of these appears, revise the role or split the unit before going on.

## Visibility

Prefer an architecture where every conditional reference is visible in
`SKILL.md` and loadable directly from it.

Do not reject a reference that loads another reference, but treat it as
something to justify rather than a default. A chain hides the second file from
the routing table, so the agent meets it only if it already read the first.

Weigh a local improvement against the loading cost of the whole system. During
a full analysis, look for both faults: references that multiplied without
need, and merges that were never considered.

## Split Or Merge

### Splitting

Two gates, in order.

**Distinctness.** Does the material answer a genuinely different
responsibility question? A different topic alone is not enough.

**Value.** Does separating it improve the architecture enough to justify
another unit? Weigh ownership clarity, independent evolution, loading cost,
reuse, maintenance, discoverability, and whether consumers normally need the
parts together.

A small, stable responsibility used by one or two consumers is often easier to
maintain where it is.

### Merging

Two gates, in order.

**Shared role.** Can these units share one higher-level responsibility without
mixed ownership? If not, stop.

**Example**

```text
review-heuristics.md   How are findings identified?
review-priorities.md   How are findings ordered?
→ review.md            How are findings identified and ordered?
```

That merge works. This one does not:

```text
review.md              What is wrong?
coaching.md            How do we work through it?
→ review-coaching.md   two independent questions in one file
```

**Value.** Compare coupling, loading, duplication removed, independence lost,
resulting breadth, and consumers outside the merge who would become coupled to
material they do not use.

Files being loaded together is evidence worth weighing, not a rule to merge.

### Partial Redistribution

Splitting and merging compose. A mixed reference can be split, with each part
merged into the owner that fits it best.

**Example**

```text
evidence.md
├── review evidence rules      → review.md
├── planning evidence rules    → planning.md
└── shared evidence principles → one owner, or nothing
```

Then ask whether the shared remainder still justifies a file of its own.

## Duplication

Duplication is not one thing. Classify it before removing it.

**Intentional duplication** exists where local copies are meant to diverge.
Once it is intentional, neither copy is the authoritative one, and neither
should be treated as such.

**Standardised duplication** exists where copies must stay in step. It needs
one authoritative owner and the removal of every competing copy.

There is no fixed destination for the owner. Choose by asking how broadly the
rule applies, whether it is global or shared by a cluster, whether consumers
load together, whether it is substantial enough for its own file, whether
`SKILL.md` would be polluted by always loading it, and whether an existing
owner can absorb it cleanly.

Choose the smallest coherent owner.

## Stop Rule

Do not restructure for theoretical tidiness.

For a targeted analysis, stop when the affected boundaries are clear and no
broader problem has surfaced. When the goal was to split a mixed reference and
redistribute its parts, stop once that is done.

Cleanup that the active goal does not require is optional. Raise it as a
separate decision rather than doing it.

## Audit Checklist

Run this once, after every unit has been analysed.

- [ ] Every unit has one responsibility question, statable in a sentence.
- [ ] The contents of each unit support its role.
- [ ] No two units are authoritative for the same responsibility.
- [ ] Units cross-reference each other rather than copying.
- [ ] Every split passed both distinctness and value.
- [ ] Merge candidates were checked, including partial redistribution.
- [ ] Standardised duplication has exactly one owner.
- [ ] Intentional duplication is independent, not quietly synchronised.
- [ ] Reference chains are justified; direct loading is preferred.
- [ ] Examples respect the same boundaries as the rules.
- [ ] The architecture creates no conflicting permissions or authority.
- [ ] Units analysed earlier were rechecked after later changes.

When an item fails, record it as an open decision in the register. Do not fix
it inside the audit.
