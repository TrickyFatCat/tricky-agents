# Planning

Load this reference when a planning trigger fires, and use it through to the
Approval Brief. Its rules are mandatory.

## Boundary

This file answers one question: what must be decided before a planned change
can be approved?

It owns the register, the decision log, one open decision at a time, scope
changes, deferral, blocking, the two stages, the approval gate and the
Approval Brief.

It does not own what starts planning, or what happens after approval.
`SKILL.md` owns the trigger and Focus Lock. `change-integrity.md` owns
application, validation and recovery.

Planning is mandatory before a planned change. A direct instruction to
implement does not bypass it.

## Start

When planning starts:

1. State which trigger fired, in one line.
2. Identify the known open decisions.
3. Write them into the register in plan order.
4. Begin with the first unresolved entry.
5. Continue one open decision at a time.

Planning covers one coherent change and the decisions it needs.

Discussion does not become a decision because it went well. A choice enters
the plan only when the user selects it, accepts it, or hands it to the agent.
When that is unclear, ask.

## The Register

The register is the plan. It replaces a separate list of steps, because a
decision and its status are the same thing recorded twice otherwise.

| Field | Holds |
|---|---|
| ID | A stable identifier, never reused |
| Status | Open, Proposed, Accepted, Deferred, Blocked, Superseded |
| Rule | The decision, written as the rule it becomes |
| Owner | The file that will hold the rule |
| Supersedes | The earlier rule or ID this replaces |

Entries sit in plan order. Mark the current entry with an arrow.

```text
    A01  Accepted  Discussion is the default for design talk   SKILL.md
→   A02  Open      Which file owns the safety patterns         —
    A03  Blocked   Pattern format, waits for A02                —
```

### Status Rules

**Blocked** names the ID it waits for. "Blocked" alone is a mood; "Blocked by
A02" is a dependency that can be checked.

**Superseded** keeps the entry and names what replaced it. Deleting a
superseded entry loses the reason the current rule looks the way it does,
which is the first thing anyone asks later.

An ID is never reused, and never renumbered to tidy the order. A decision that
leaves scope keeps its ID and its row.

### Sub-Decisions

A decision that exists only to resolve another gets its own ID and names its
parent. Do not nest numbering.

A parent is Accepted only when every sub-decision it depends on is resolved. A
deferred sub-decision does not block the parent unless the parent depends on
it.

### Ownership

Owner is the file that will hold the rule. It is not the same as authority,
which is who may set the rule. Record the owner, because validation later
checks that every accepted entry appears in the file named here.

### Storage

Store the register where the user asked. Failing that, write a temporary copy
outside the skill folder when a file tool exists.

Always show it in the conversation as well. A register that exists only in a
file the user has not opened does not do its job, and a harness without a file
tool must still be able to plan.

## Decision Log

The log sits beside the register, in `log.md`. This file owns it.

| Field | Holds |
|---|---|
| ID | The register entry it belongs to |
| Case | The corner case or question that raised it |
| Rationale | Why the decision went this way |
| Rejected | The alternatives, and why each was rejected |
| Tests | Scenario tests that do not persist in the built skill |

Keep rationale here, not in the skill files. A skill file states the rule; the
reason it exists is design history, and design history in an instruction file
competes for the agent's attention with the instruction.

### Both Are Disposable

The register and the log are working files. After the final freeze, the skill
files and `tests/behaviour.md` are the source of truth.

Nothing in the built skill may depend on either file existing. If a rule only
makes sense with the log open, the rule is incomplete.

## Working Files And The Planning Trigger

A temporary working file created outside the skill folder does not fire a
planning trigger. That covers the register, the log, and any baseline copy
made for validation, provided it is deleted or left disposable afterwards.

A file created inside the skill folder is always a planned change, whatever it
is for.

The distinction is reach, not intent. A file inside the skill is loaded by
future agents; a file outside it dies with the session.

## One At A Time

Present one open decision, resolve it, move to the next.

When presenting a choice:

- offer only materially distinct options;
- put the consequence or trade-off directly under the option it belongs to;
- do not add a rationale section that restates the options;
- do not ask the user to choose when only one option is viable.

When a decision resolves, move straight to the next unresolved entry. Add a
transition sentence only when it helps orientation.

## Scope Changes

When planning reveals another change:

- related to this one, explain the impact and ask whether to include it;
- unrelated, keep it separate and raise it only when it becomes relevant.

Never expand scope without the user choosing to.

Before adding scope, identify the dependencies and say which resolved entries
would reopen. Reopen an entry only when the new work materially affects it.

Before removing an entry, check what depends on it and say what would become
blocked, invalid or pointless. Ask before removing.

Remove a dependent entry automatically only when it has no purpose at all
without the removed one. Otherwise keep it and re-examine it.

When work leaves scope, keep its ID and mark the row. The ID stays reserved.
If the work returns in the same session, restore the original row and recheck
its assumptions.

## Deferral

A decision may be deferred only when the planned change does not depend on it.
Otherwise it is blocking, whatever it is called.

Deferring a parent defers its unresolved sub-decisions, unless one needs to be
shown for clarity.

Deferred work stays outside the approval scope. It is not reopened because
planning ended. Returning to it later starts a new workflow.

## Blocking

When a rule requires stopping, stop the affected work and everything that
depends on it. Say what the blocker is, and what the next action is when that
is not obvious.

Continue other work only when it neither depends on, constrains, nor affects
the blocker. When that independence is uncertain, treat the work as dependent.

Plan order does not imply dependency. Two entries next to each other may be
entirely unrelated.

A blocker does not end or suspend the workflow.

## Stages

Two stages run inside Planning. Neither is a second planning session.

### Architecture Analysis

Run `architecture-analysis.md` for a new multi-reference Skill, or a change
that adds, removes, splits or merges a reference.

Run it once the core architecture is coherent, and before corner-case
discovery.

Every blocking architectural issue must be resolved before planning can
complete. Mark a non-blocking improvement as optional; it is neither a blocker
nor deferred work.

### Corner-Case Discovery

Run `corner-case-discovery.md` for a new Skill or behavioural `AGENTS.md`, or
a change to a trigger, permission, routing rule, or a line containing must,
never, only or ask.

Run it once the core design is coherent. Resolve cases one at a time, and fold
accepted findings into the register before the final checks.

Planning cannot produce the Approval Brief until required discovery is
complete and nothing it raised is still blocking.

When both stages are required, run architecture analysis first.

## Approval Gate

Detect the gate before asking for approval. Three cases, in order.

1. A plan-mode tool is present in the tool list. Use it.
2. Plan mode is already active. Stay in it, and approve through its exit tool.
3. Neither. Use the skill's own gate: present the Approval Brief in the reply
   and wait.

Check the tool list rather than assuming. A harness with a plan tool that the
agent approves in chat instead has bypassed the user's own approval mechanism,
which is the one they trust.

## Completion

Planning completes on its own when every open decision in scope is resolved or
validly deferred and no blocker remains. It does not need the user to say so.

Before producing the Approval Brief:

1. Confirm every decision in scope is resolved or validly deferred.
2. Check earlier decisions, conversation context, references, templates,
   tooling and related artefacts.
3. Check for conflicts, stale assumptions, lost context, and dependencies on
   deferred work.
4. Reopen the relevant entry if anything blocks.
5. Produce the brief only when nothing unresolved blocks the change.

When the checks pass, produce the brief in the same turn. Do not announce that
planning is complete, and do not ask whether to move to approval.

## Approval Brief

```text
# Approval Brief

## Change

What will change, and the main effect.

## Scope

What is affected, and what important context is preserved.

## Files

**Create**
- `relative/path` — A01, A04

**Modify**
- `relative/path` — A02

**Delete**
- `relative/path`

## Deferred

Postponed open decisions, if any.

## Validation

How the applied change will be checked.
```

Keep the order: Change, Scope, Files, Deferred, Validation.

### Files And The Coverage Map

List exact relative paths, and beside each one the IDs of the accepted
decisions it implements. That list is the coverage map, and validation checks
it afterwards.

Include **Files** whenever files change, and omit it otherwise. Omit empty
categories.

When High-severity scenario tests came out of discovery, list
`tests/behaviour.md` under Create or Modify, and propose the tests here. Tests
are part of the approved change, not an extra the agent adds later.

### What The Brief Excludes

Omit **Deferred** when there is none.

Include only resolved planned changes. Exclude rejected and exploratory
proposals, and introduce no new decision.

Ask one direct approval question. Add no new recommendation, alternative or
analysis after it.
