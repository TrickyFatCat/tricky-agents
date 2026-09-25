# Source Verification

Read this reference for any claim that can be checked against an authority.

This file owns one question: is this claim true, and how confident are we?

Both writing and review load this file. It is the single owner of
verification.

## Authority For Code

1. The current implementation or configuration schema.
2. Generated help from the installed version.
3. Tests and direct call sites.
4. Version-matched upstream documentation.
5. Existing local documentation.

An older README is not proof that current behaviour still matches it.

## Authority For A Workflow

A workflow document has no implementation to read.

1. A named process owner.
2. A policy or decision artefact.
3. Neither — every step is an Assumption, and the document says so.

Never present a described process as established fact when no authority was
named.

## Restating A Source

A document that restates a structured source, such as a table, an enum, or a
list of states or triggers, keeps the source's field names and every clause of
each condition. A renamed field or a shortened condition is a new claim, and
needs its own evidence.

A field keeps its source name when the reader sees that field. An internal
field the reader never sees may take the reader's word, as the `Source words`
check in `SKILL.md` requires. Check each of its cells against the source.

Check clause by clause. A paraphrase that reads correctly can still have
dropped the exception.

**Renamed Field**

A rate-limit table renames the source column `Burst` to `Max Per Second`, then
fills the cells by the new name. `Burst` was a bucket size, not a rate, so every
cell is now wrong.

**Dropped Clause**

```text
Source  Reloads on SIGHUP, or when the file changes, unless --no-watch is set.
Weak    Reloads when the file changes.
Strong  Reloads on SIGHUP or when the file changes, unless --no-watch is set.
```

## Confidence Labels

| Label      | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| Fact       | Confirmed by an authority, a safe test, or generated help |
| Assumption | Inferred from context, not confirmed                      |
| Unknown    | Unavailable or unsafe to verify in this task              |

## The Verification Ladder

```text
1  Code intelligence tool        signature, symbols, call sites   → Fact
2  Generated help or introspection  --help, go doc, help()        → Fact
3  Static source reading         Read and Grep                    → Fact if unambiguous, else Assumption
4  Nothing available             ─                                → Unknown, or ask
```

An ambiguous source read is an inference, so it is an Assumption. A lower rung
changes the label, not the claim. Rung 4 output must reach the
reader labelled Unknown; it must never be written as though it were verified.

## Safety

Prefer static inspection, generated help, validation modes, dry runs and
mocked dependencies before anything that changes files, processes, services or
application state.

Never run a destructive or state-changing command solely to improve a
document.

## Behaviour Inventory

For a README or a reference, list what the source does that the reader meets,
must approve, or is changed by. Each item is either documented or cut for a
reason the writer can name.

Another document covering the item for a different reader is such a reason.
Before cutting the item, open that document and confirm it covers the item. A
document the writer has not checked is an invented source, and cutting on its
strength leaves a gap in both documents.

Leave the item out, or link to that document when this reader needs to know
the behaviour exists.

Instructions and how-to guides leave behaviour out on purpose, to keep the
reader on one path. Do not run this check on them.

**Missing Behaviour**

A backup tool's README covers backup and restore. It never says that the tool
deletes backups older than 30 days.

**Covered Elsewhere**

A game's player manual does not explain the save-file format. The modding
guide explains it to modders, so the manual leaves it out.

## Subject Checklists

### Command and Script Checks

Check whether documentation accurately represents:

- Exported command inventory.
- Command names and aliases.
- Required and optional arguments.
- Flag names, value types, and repeatability.
- Defaults and precedence.
- Pattern matching, including regex versus exact matching.
- Return values and output shapes.
- Errors for missing or invalid input.
- File, process, network, or application-state side effects.
- Discovery and utility commands.

For commands, the inventory is the exported command list. Note missing, removed, or renamed commands.

### Configuration and Setup Checks

Check whether documentation accurately represents:

- Current file locations.
- Required and optional files.
- Default values.
- Search paths and environment variables.
- Configuration precedence.
- Validation commands.
- Reload or restart requirements.
- Persistent side effects.
- Version, platform, and permission constraints.

Do not recommend package, service, or privilege commands without checking the relevant environment when those details affect correctness.

### API and Extension Checks

Check whether documentation accurately represents:

- Public inputs and required fields.
- Output or return contracts.
- Registration, discovery, or dispatch points.
- Error behavior.
- Compatibility expectations.
- Safe extension validation.

Inspect at least one direct usage when it clarifies the contract.

## Final Check

1. Confirm every claim names or cites its basis, and that a cited page states
    the claim. A link to a page that does not say it is not evidence.
2. Recheck names, paths, flags, defaults and quoted behaviour, and every
    restated condition clause by clause.
3. Confirm source and documentation versions are compatible.
4. Separate implementation problems from documentation problems.
5. Report what was not checked.

If the implementation itself appears wrong, identify that separately. Do not
document a bug as intended behaviour without confirming the user's goal.
