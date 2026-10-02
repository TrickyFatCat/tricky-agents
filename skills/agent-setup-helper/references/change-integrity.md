# Change Integrity

Load this reference when approval is given, or when Direct Drafting finishes
an edit. Keep it active through application, validation and recovery.

## Boundary

This file answers one question: did the approved change land exactly, and what
happens if it did not?

It owns the context and dependency checks, validation, the coverage check, the
script run, the evals, recovery, the final integrity check and the validation
report.

It does not own what gets approved. `planning.md` owns that.

## Context And Dependency Checks

Before proposing or applying a change, inspect what it could materially
affect: earlier decisions, the current artefacts, conversation context,
references, templates, tooling, workflow dependencies, and related skills.

Do not inspect unrelated material because it happens to exist.

Prefer the current artefacts for current state. Use the conversation to
recover decisions, constraints, approvals, unresolved work and reasons.

Keep four things apart: what is implemented now, what is still being planned,
what was approved but not yet applied, and what was deferred, rejected,
discarded or merely discussed.

Do not assume an approved change was applied successfully. Check the resulting
file when one is available.

When sources disagree, apply the precedence order when it settles the matter,
and surface the conflict when it does not. Never merge or reconcile behaviour
silently.

When context is missing:

- say what is missing;
- say whether it blocks the decision or only limits confidence;
- do not assume it agrees, and do not assume it conflicts;
- stop only when it could materially change an open decision.

## Validation

After application:

1. Verify the result matches the approved brief.
2. Check context, dependencies, related artefacts and earlier decisions for
   conflict or lost context.
3. Verify that deferred and unrelated decisions were not implemented by
   accident.
4. Run the coverage check.
5. Run `check.py`.
6. Run the evals when the skill has `evals/evals.json`.
7. Read `tests/behaviour.md` when this skill itself changed.
8. Correct low-risk editorial mistakes directly.
9. Stop and use a recovery path when a correction would itself be a planned
   change.

Keep validation to what the change could materially affect. Scale the depth to
the possible impact. Do not turn validation into a general audit.

The evals are the one exception: when they run, every eval runs. A change in
one file can break a rule held in another, and an eval is the check that sees
it.

Report only the checks actually completed.

### Results

| Result | Meaning |
|---|---|
| Passed | Required checks completed, no blocking problem |
| Limited | A check could not run, and cannot change whether the work is correct |
| Failed | A blocking problem prevents validated completion |

When a missing check could change the correctness conclusion, the result is
Failed, not Limited. Limited is for checks whose absence does not matter, not
for checks that were inconvenient.

Passed and a genuinely non-blocking Limited complete the workflow. Report the
limitation in one line.

Failed does not end the workflow, and does not by itself authorise a
rollback.

When validation exposes an unrelated problem, do not fix it inside this
change. Raise it only if it matters now.

### Coverage Check

Every accepted decision must appear in the file named as its owner in the
register.

A decision with no location is a validation failure, not a note. The register
recorded a rule that the built artefact does not contain, which means either
the rule was lost or the owner was wrong. Both need the user.

Check the direction that catches silent loss: walk the register, and look for
each entry in its owner file. Walking the files instead finds only what is
already there.

### Running The Script

Run `check.py` with a Python 3.11 or newer interpreter. The command name
varies between machines, so use whichever interpreter on this machine meets
that version.

```bash
python3 scripts/check.py all <skill-dir>
```

Map the results:

| Script status | Validation |
|---|---|
| `pass` | Passed |
| `limited` | Limited, with the reason it gives |
| `findings` | Agent judgement, case by case |
| `error` | The check did not run; treat as Limited and say why |

Findings are not failures and not passes. Each one is read and judged. A
safety match may be a legitimate pattern in a security file; a near-limit size
finding may be acceptable.

Exit codes: 0 all passed, 1 at least one check has findings, 2 a usage or run
error, 3 no findings but at least one check limited.

When the script cannot run at all, validation is Limited, and the report says
which checks were skipped.

### Spec Dates

`references/skill-spec.md` and the constants in `check.py` each carry a fetch
date for the published limits. The script prints its date in every report.

Compare the two. A mismatch is a finding: one copy was updated and the other
was not, so the agent and the script are working to different rules.

### Permission Lines

The `permission-lines` check compares lines containing must, never, only or
ask against a baseline.

```text
skill under git  ──────────►  compare with the last commit
no git, baseline ──────────►  compare with --base <path>
no git, no copy  ──────────►  Limited, lists every trigger-word line
```

Outside git, copy the files to be edited to a temporary folder outside the
skill *before* editing, pass it with `--base`, and delete the copy after
validation. The agent makes that copy; the script never writes.

With neither git nor a copy, the result is Limited with the reason `no
baseline`, and the script lists every current trigger-word line in the touched
files. Check those against the diff shown to the user.

Flags caused by earlier uncommitted changes are expected. Check each against
the diff rather than treating the list as the change.

A changed permission line that no plan covered stops the work. It is a
planning trigger that fired during application, which means the approved scope
was wrong.

## Evals

An eval is a prompt run by a fresh agent that has the skill loaded, then
graded against the behaviour the skill must produce.

A skill with `evals/evals.json` has its evals run after every change except a
low-risk editorial change that fired no planning trigger. That covers Direct
Drafting as well as a planned change.

### Eval Files

`evals/evals.json` holds one entry per eval: the prompt, the expected
behaviour, the Must Not, the Owner (the file and section holding the rule),
any setup, and fixture files under `evals/files/`.

`evals/trigger.json` holds about 20 queries for the description, half that
should trigger the skill and half near misses that should not. Run them only
when the description changes, about 3 times each, as the trigger testing in
`skill-spec.md` describes.

Results go to a temporary folder outside the skill folder. They are never
committed.

An eval is never edited to make the change under validation pass. Changing or
removing an eval is a planned change of its own.

### Baseline

Before applying a change, copy the whole skill to a temporary folder outside
the skill folder. That copy is the baseline.

Git HEAD at validation time is not a baseline. A commit made before validation
turns HEAD into the changed version, which is then compared with itself.

Outside git, the same copy is the `--base` for `permission-lines`. Under git,
`permission-lines` keeps comparing with the last commit, because passing
`--base` switches that comparison off.

Run the changed version's evals against both versions.

### Isolation

An eval run never writes outside its own temporary folder.

1. Copy the version under test and the eval's fixtures into a fresh temporary
   folder outside the skill folder, one per run.
2. Tell the run to read the skill from that folder, and not to load it through
   the harness's skill mechanism. The installed copy may be another version.
3. After all runs, confirm that the real skill files changed only by the
   applied edits.
4. Read each run's transcript for the files it read and any skill it loaded.
   The same record shows which references the run used.

A run is invalid when it wrote outside its folder, loaded another copy of the
skill, or left no transcript to check. An invalid run counts as an eval that
did not run.

### Runs And Grading

Run each eval once on each version, each in a fresh subagent.

When an eval fails, or the two versions disagree, rerun both versions up to
three times each and compare pass rates. A result still mixed after three runs
is unstable, and counts as an eval that did not run.

A fresh subagent grades each run against the expected behaviour and the Must
Not, without being told which version produced it. Do not override a grade.
Take a disagreement with one to the user.

### Eval Results

| Outcome | Validation |
|---|---|
| Changed version fails, baseline passes | Failed: a regression |
| Both fail, rule touched | Failed |
| Both fail, rule not touched | An existing defect: report it, do not fix it here |
| Did not run, rule touched | Failed |
| Did not run, rule not touched | Limited, with the reason |
| No baseline, changed version fails | Failed |
| No baseline, changed version passes | Limited, with the reason `no baseline` |

A rule is touched when the diff changed the section that holds it, as the
eval's Owner names it. A routing change in `SKILL.md` touches a reference's
rules only when it removes or narrows a route to that reference. Adding a
route cannot stop a rule loading where it loaded before.

An eval did not run when it could not run, when its run was invalid or
unstable, or when the user asked to skip it. A skip is not an exception to the
table.

## Behaviour Tests

When agent-setup-helper itself is the artefact being changed, read
`tests/behaviour.md` during validation.

Each test gives a Trigger, a Must, a Must Not and an Owner. Read the built
rules and decide whether the Must is produced and the Must Not is prevented.

Read every test, including those that also run as evals. A test whose Must the
rules no longer produce is a Failed validation, not a test to update.

## Failure And Recovery

Choose the recovery path by cause.

**Process failure.** Stop the affected work. State the failure and its impact.
Treat everything after the failure point as unvalidated. Return to the last
reliable state and re-run the required checks.

**External change after approval.** Stop. State what changed and what it
affects. Return to planning when the approved plan needs reconsidering.

**Partial application.** Do not report completion. Continue when no new open
decision is required; otherwise return to planning.

**Implementation mismatch.** Correct it mechanically when that is possible.
Otherwise return to planning.

Missing context during implementation is not a normal state. It means a check
failed earlier, the process failed, or something outside changed. Stop and
follow the matching path.

When a process failure happened after files were modified, stop modifying,
identify what changed after the last reliable state, and do not silently
revert it. Restore only when the restoration is exact and mechanical.
Otherwise take recovery through planning.

A blocked state does not end or suspend the workflow.

## Final Integrity Check

Run this before the Approval Brief for a substantial rewrite, and again after
application.

- Consolidate overlapping rules by responsibility.
- Keep one authoritative rule per behaviour.
- Remove superseded, rejected and redundant wording.
- Keep a narrower rule only when it adds a distinct exception.
- Preserve every distinct approved behaviour, exception and precedence rule.
- Check for contradictions, stale assumptions, dependency gaps and lost
  context.
- Check source material and responsibility boundaries.
- Remove detail a stronger general rule already enforces.
- Keep an example only where it clarifies a real boundary.
- Prefer concise invariants and routing rules to repeated edge-case rules.

Do not shorten by weakening an obligation or dropping an edge case. Length is
not the goal; one authoritative rule per behaviour is.

## Validation Report

```text
Result        Passed, Limited or Failed
Checks        What was actually checked
Findings      What the script reported, and the judgement on each
Evals         Each eval's result on both versions, and any that did not run
Coverage      Accepted decisions with no location, or none
Limitations   What could not be checked, and why
```

Report the result first. A report that describes the checks and leaves the
result to be inferred makes the reader do the work the report exists to do.

Omit a line that has nothing in it, except Result.
