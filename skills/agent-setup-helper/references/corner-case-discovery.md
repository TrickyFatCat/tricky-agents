# Corner-Case Discovery

Load this reference for a new Skill or behavioural `AGENTS.md`, or for a
change to a trigger, a permission, a routing rule, or a line containing must,
never, only or ask.

## Boundary

This file answers one question: what could a user do next that the rules do
not handle?

It owns the lenses, the rule-addition gate, the consolidation cadence,
scenario tests and the freeze criteria. It does not own where content lives
(`architecture-analysis.md`), the register (`planning.md`), or the decision
log, which `planning.md` owns and this file only sends tests to.

Discovery is a stage inside Planning. It produces rules and tests for the
register, not file changes.

### Core Question

What could a reasonable user say or do next that would make the current rule
ambiguous, contradictory, unsafe or incomplete?

Find classes of user behaviour, not a list of possible messages.

## Skill Type And Lens Map

State the skill type in one line when discovery starts. The user can correct
it, and the correction costs nothing at that point.

A **mechanical** skill runs a fixed procedure on its inputs. A
**conversational** skill's behaviour depends on the user's replies during the
session. A **mixed** skill runs every lens.

| Lens | Conversational | Mechanical |
|---|---|---|
| 1, 2, 4, 6, 10, 11, 12, 13, 14 | Run | Run |
| 3 Intent, 5 Scope | Run | Run briefly |
| 7 Alternatives, 8 User Control, 9 Responsibility | Run | Skip |

A mechanical skill runs lenses 7 to 9 after all if it asks the user anything.
The moment a skill has a question, it has an answer it can mishandle.

## The Lenses

### 1. Define The Expected Path

Write the normal interaction first. Without it there is no path to depart
from, and discovery drifts into listing unrelated risks.

```text
Trigger → Required input → Processing → Output → Completion
```

Define what starts the behaviour, what it requires, what it produces, and what
ends it.

### 2. Input Quality

Test missing, partial, vague, incorrect, outdated and conflicting
information; referenced content that is unavailable; and information that
changes during the interaction.

Decide what must be asked, what may stay unknown, what may be inferred, and
what must never be assumed.

### 3. User Intent

Try requests that are explicit, implicit, ambiguous, indirect, broader than
expected, narrower than expected, and outside the purpose.

Decide whether to proceed, ask one focused question, restrict the output,
route elsewhere, or decline part of the request.

### 4. Conflicts

Check conflicts between the current and an earlier instruction, between goals
and requested actions, between the request and its sources, between two
authoritative sources, and between the output and a system boundary.

Define what stays visible, what can be handled safely, what needs the user,
and what must never be resolved silently.

### 5. Scope And Abstraction

Try requests that expand beyond scope, mix unrelated topics, mix abstraction
levels, combine responsibilities, turn guidance into implementation, or move
an open decision to the agent.

Ask whether this is still the same interaction. If not, narrow, split,
reroute, stop or start a new session.

### 6. Quantity And Scale

Try no stated quantity, very small and very large ones, requests for more
output, multi-stage output, combinatorial growth, and quantities that cannot
be met meaningfully.

Define defaults, quality thresholds, narrowing behaviour, and what happens
when scale destroys usefulness.

### 7. Alternatives

Where output contains options, test duplicates, overlap, mutually exclusive
options, mixed abstraction levels, invalid options, context-dependent options,
cosmetic variation, and options resting on unknown facts.

Define what makes an alternative meaningfully distinct.

### 8. User Control

Check what happens when the user accepts, rejects part, rejects everything,
asks for a revision, changes the goal, combines outputs, cancels, returns
later, or asks for more.

Define what is preserved, what becomes inactive, what needs explicit
permission, and what starts a new session.

The agent may filter or discard its own drafts before presenting them. It must
expose problems in content the user provided, and never silently remove, merge
or rewrite it.

That asymmetry is the point of this lens. Tidying the agent's own work is
editing. Tidying the user's work is deciding on their behalf.

### 9. Responsibility Pressure

Try "you decide", "do everything", "choose the best", "make it complete",
"implement it", "fill in the missing details".

Identify where help becomes unsupported inference, transferred responsibility,
an unauthorised decision, full implementation, or authorship.

Define how the open decision goes back to the user.

### 10. Uncertainty And Risk

Check unknown facts, missing external context, unverified capabilities,
unavailable sources, cost and schedule risk, potential conflicts, and
confirmed blockers.

Use a precise label rather than one generic warning.

| Label | Meaning | Example |
|---|---|---|
| Gap | The skill does not define a behaviour it needs | Design talk that ends in planning has no mode |
| Unknown | A fact about the harness or environment is unavailable | Whether the harness has a plan-mode tool |
| Risk | The rule works but can misfire, and is still usable | A keyword trigger that fires on wording-only edits |
| Non-Viable | A confirmed blocker stops the rule working | A rule that writes a register, with no file tool |
| Insufficient Context | The artefact cannot be assessed with what was given | A `SKILL.md` supplied without its references |

These labels say what *kind* of problem something is. Severity says how much
harm it causes. Use both: a Gap can be Low, and a Risk can be High.

### 11. Component Ownership

For every rule, ask which question it owns.

```text
When should the agent act?
What problem is being identified?
Why does the problem matter?
Which options should be considered?
How should the topic be explored?
How should feedback be presented?
```

Assign one owner. When a rule answers several of these questions, flag it for
architecture analysis. Do not split it here — splitting is an architectural
decision, and this stage does not own it.

### 12. Output Structure

Check whether the output stays useful when information is uneven, some results
need warnings, some items need more detail, the user asks for a custom format,
or the output grows long.

Preserve meaning over visual uniformity.

### 13. Continuation And Stopping

Define what happens after success, after partial completion, when required
information is unavailable, when no useful progress remains, when the user
changes direction, and when the user cancels.

Add two questions for procedures: what happens if it stops halfway, and what
happens when it is then run again.

Retries are bounded. A fallback path keeps the same permissions and the same
output contract as the main path; it must never widen what the skill may do.

A fallback that quietly widens permissions is the dangerous case, because it
only runs when something has already gone wrong and nobody is watching.

Do not allow accidental continuation or escalation.

### 14. Irreversible Actions

Ask which steps cannot be undone. Run this lens for both skill types.

For each such step, define the preview or dry run, the confirmation, and what
happens when confirmation is refused.

Refusal needs a defined path. A skill with no answer for "no" tends either to
stop halfway with the work in an unknown state, or to ask again.

## One-At-A-Time Pattern

Work one case at a time. A batch of cases produces a batch of rules that were
never tested against each other.

```text
1. Present one concrete user example.
2. Name the ambiguity or failure risk.
3. Decide the expected behaviour.
4. Generalise the decision into a reusable rule.
5. Test the rule against neighbouring behaviours.
6. Confirm one clear owner.
7. Accept the rule before moving on.
```

## Discovery Prompts

Use these repeatedly.

- What could the user say next?
- What important information might be missing?
- What if new information conflicts with earlier context?
- What if the user changes their mind?
- What if the request is much larger than expected?
- What if only part of the request can be completed?
- What if the output contains duplicates or conflicts?
- What if the user rejects the result?
- What if the user asks the agent to decide?
- What if the interaction should stop?

## Rule-Addition Gate

Classify every case before accepting it. Most cases do not deserve a rule, and
a skill that adds one per case becomes unreadable long before it becomes
complete.

| Kind | What it is | What it produces |
|---|---|---|
| Uncovered | Genuinely undefined behaviour | A new rule |
| Clarification | An existing rule is unclear here | A refinement of that rule |
| Example | Another instance of an existing rule | An example or a test, no rule |
| Contradiction | It conflicts with an existing rule | Nothing, until the conflict is resolved |
| Specialised | It applies to one situation only | No permanent instruction text |

Resolve a contradiction before continuing. An unresolved conflict makes every
later case ambiguous, because two rules now answer it.

## Consolidation Cadence

After three to five related cases, stop discovery and consolidate.

1. Group the cases.
2. Write one general rule that covers the group.
3. Test it against every case in the group.
4. Remove the local rules it replaces.

If the general rule fails a case, the group was wrong, not the case. Split the
group and try again.

## Scenario Tests

Every accepted case becomes a scenario test in this shape.

```text
Trigger    What happens
Must       What the agent has to do
Must Not   The plausible wrong behaviour
Owner      The file holding the rule
```

Must Not is the useful field. A test with only a Must passes when the agent
does the right thing for the wrong reason, and passes an agent that also does
the wrong thing alongside it.

The case discussion goes to the decision log, not into the skill.

### Which Tests Persist

During discovery, every accepted case has a test.

At delivery, only High-severity tests persist in the built skill's
`tests/behaviour.md`, proposed through the Approval Brief. The rest go to the
decision log.

The log is disposable. A test that matters after the freeze belongs in
`tests/behaviour.md`, not in the log.

## Freeze Criteria

Discovery is finished when all five hold.

1. The responsibility can be stated in one sentence, and every rule has one
   owner.
2. Triggers, boundaries and stop conditions are observable.
3. No contradiction is open, and superseded rules have been removed.
4. Every accepted case has a passing scenario test.
5. After the freeze, a new case reopens the design only if its scenario test
   fails.

Criterion 5 is what makes the freeze real. Without it, any new idea reopens
the work, and discovery never ends.
