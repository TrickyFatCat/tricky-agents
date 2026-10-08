# Change Integrity

Load this reference when approval is given, or when Direct Drafting finishes
an edit. Keep it active through application, validation and recovery.

## Boundary

Sections, in order: Context And Dependency Checks; Validation; Evals; Behaviour
Tests; Failure And Recovery; Final Integrity Check; Validation Report.

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

After application, or after a Direct Drafting edit:

1. Verify the result matches the approved brief or, after Direct Drafting,
   the request.
2. Check context, dependencies, related artefacts and earlier decisions for
   conflict or lost context.
3. Verify that nothing beyond the brief or request changed, and that deferred
   and unrelated decisions were not implemented by accident.
4. Run the coverage check. It does not apply to Direct Drafting, which has no
   register.
5. Run `check.py`.
6. Run the evals when the skill has `evals/evals.json`.
7. Read `tests/behaviour.md` when this skill itself changed.
8. Correct low-risk editorial mistakes directly, except in a permission line
   or a line that bans or limits an agent action. Then run `check.py` again.
   A round is one set of corrections, then one `check.py` run. A second round
   that still finds problems stops, and the Findings line says so. It lists
   each problem still found, judged as usual, and the result follows from
   those judgements.
9. Stop and use a recovery path when a correction would itself be a planned
   change. A correction that changes a permission line, or a line that bans
   or limits an agent action, is a planned change. This holds even when it
   makes the file match the approved brief, and for a listed line that
   application missed. Do not apply it. The problem stays on the report,
   judged as usual.

Keep validation to what the change could materially affect. Scale the depth to
the possible impact. Do not turn validation into a general audit.

The evals are the one exception: when they run, every eval runs. A change in
one file can break a rule held in another, and an eval is the check that sees
it.

Report only the checks actually completed.

Judged as usual means: a script finding by Severity, as Running The Script
says, and any other problem by Failed Causes.

Each correction, mismatch fix and restore made during validation goes on the
Findings line, with its file and line, marked "fixed during validation".

A problem is unrelated when it sits outside the brief or request, the diff did
not cause or worsen it, and the diff did not change the section that holds it.
Note it once, marked "unrelated", on the report line of the check that found
it, or on the Findings line when no check did. Never fix it inside this change.
It is not a Failed cause, even when it is real, and it does not affect the
result.

An unrelated real safety finding goes on the Safety line instead, first in the
report, with its file and line. It is never fixed inside this change, and it
does not affect the result. The report recommends planning its fix next.

### Results

| Result | Meaning |
|---|---|
| Passed | Every check the change needed ran, and no Failed cause holds |
| Limited | A check did not run, and it cannot change the result for this change |
| Failed | At least one Failed cause holds |

When results mix, Failed beats Limited, and Limited beats Passed.

### Failed Causes

Validation is Failed when any of these holds:

- an accepted decision is missing from its owner file (Coverage Check);
- a permission line changed that no plan covered (Permission Lines);
- a finding is judged a real problem, even inside an approved change;
- an eval outcome is Failed in the Eval Results table;
- a check did not run and could change the result (Missing Checks);
- a behaviour test's Must is no longer produced;
- the change does something the brief or request did not ask for, or misses
  something it asked for.

### Missing Checks

A check did not run when it errored, ended `limited`, could not run, or was
skipped, including at the user's request.

Such a check is Limited only when it cannot change the result for this change.
It can when the diff changed something the check covers. When that is unclear,
the result is Failed, and the report says which check and which file.

Before reporting that a script cannot run, rule out a path error, as Gotchas in
`SKILL.md` describes.

The Eval Results table is the specific rule for evals. This section does not
override it.

### Ending After Failed

Failed does not end the workflow by itself, and does not by itself authorise a
rollback. The work returns to Planning, unless the user explicitly chooses one
of two endings.

After a Failed report, put the three paths to the user in one Decision
Prompt: return to Planning, Accept or Abandon. Planning is the default. The
prompt also says that the user may change the judgement of a script finding.
A changed permission line that no plan covered is the exception: the work
moves to Planning, as Direct Drafting in `SKILL.md` and Permission Lines say.

When every open Failed cause is a check that this agent cannot run, say so in
the prompt, and offer Accept and Abandon instead of the three paths. When the
user asks to plan, return to Planning. A plan clears these causes only by a
change that no longer touches what the check covers.

- **Accept.** The Failed causes inside the approved scope, or inside the request
  after Direct Drafting, stay open, and the work ends. Content outside that
  scope cannot be accepted. Ask the user about each piece of outside content:
  restore it from the baseline, or plan it. Restore only those lines or files,
  and only when the user chooses restore. A piece that the user plans starts a
  new plan after this work ends, as Baseline describes.
- **Abandon.** The change ends and the files stay as they are. Offer an exact
  restore from the baseline. Restore only on the user's yes, then confirm
  that the files match the baseline.

A reply chooses an ending only when it names the ending or states its effect:
keep the change with its open causes (Accept), or give the change up
(Abandon). When a reply fits both endings, ask. A reply that chooses neither
ending leaves the work in Planning. Never infer either ending from silence,
"ok" or a change of topic. Accepting never overrides global safety.

The Result line stays Failed and adds "ended: Failed accepted" or "ended:
abandoned", never "completed". The report lists every open Failed cause and
any safety finding.

### Coverage Check

Every accepted decision must appear in the file named as its owner in the
register.

A decision is found when its owner file states the same behaviour at the same
strength (must, may, never) and under the same conditions. Exact wording is
not required. Quote the matching line in the report.

Weaker wording is a miss. "Should ask" does not cover a decision that says
"must ask".

A decision with no location is a validation failure, not a note. The register
recorded a rule that the built artefact does not contain, which means either
the rule was lost or the owner was wrong. Both need the user.

Check the direction that catches silent loss: walk the register, and look for
each entry in its owner file. Walking the files instead finds only what is
already there.

### Running The Script

Run `check.py` with a Python 3.11 or newer interpreter. The command name
varies between machines, so use whichever interpreter on this machine meets
that version. Run it by this skill's base directory, as Gotchas in `SKILL.md`
describes.

```bash
python3 <this-skill-dir>/scripts/check.py all <skill-dir>
```

Add `--base <baseline>` when a baseline exists, as Permission Lines says.

Map each check's status:

| Script status | Validation |
|---|---|
| `pass` | Passed for that check |
| `findings` | Judge each finding; a real problem is a Failed cause |
| `limited` | Judge each listed finding as for `findings`; Missing Checks decides the part that did not run |
| `error` | Did not run; Missing Checks decides |

Findings are not failures and not passes. Each one is read and judged. A
safety match may be a legitimate pattern in a security file; a near-limit size
finding may be acceptable.

Judge a script finding by Severity in `review.md`. A High or Medium finding is
a real problem. A finding that would make a platform reject the skill, or
load it wrongly, is High. A size finding over the limit is a real problem. A
finding that matches another Failed cause, such as a permission line that no
plan covered, is a real problem at any severity. A Low finding is acceptable,
and the report gives the reason.

The user may change the judgement of a script finding. The report marks that
finding "judged by the user", and the result follows from it. Two findings
are exceptions, and each stays a real problem: a safety finding judged a real
problem, and a permission line that no plan covered.

A finding labelled "Claude platform only" can be a real problem only when
Claude may load the skill: installed for Claude Code, or uploaded to claude.ai
or the API. When that is unknown, count the skill as targeted, and still judge
the finding. A tag-shaped placeholder may be harmless; a reserved word in a
skill Claude loads is not.

Take the result from each check's status, never from the exit code alone.
`check.py --help` lists the exit codes.

A check lists at most 50 findings. When its report says `truncated`, read the
rest in the files themselves.

When the script cannot run at all, every check counts as not run, and Missing
Checks decides.

### Spec Dates

`references/skill-spec.md` and `check.py` each hold a copy of the published
limits and frontmatter rules. Each source page carries its own fetch date, and
the script prints its date in every report.

Compare the two copies only when the change touches skill-spec.md Limits,
Frontmatter Fields or Sources, or a published limit value in `check.py`.
Otherwise the comparison is not needed for this change, and it is not a
missing check.

- A value that differs between the copies is a real problem. The agent and
  the script are working to different rules.
- A date that differs while the values match is updated in both copies, after
  the values are checked against the source, as part of the same approved
  change. Outside such a change it is a planned change of its own.

### Permission Lines

The `permission-lines` check compares permission lines, as `SKILL.md` defines
them, against a baseline.

```text
baseline             ──────────►  compare with --base <path>
no baseline, git     ──────────►  compare with the last commit
no baseline, no git  ──────────►  limited; Missing Checks decides
```

A file the baseline does not hold, such as a new file, is compared with an
empty file. Each of its permission lines is reported as added. A baseline that
cannot be read for a file makes the check `limited`, and the reason names that
file.

Pass the baseline with `--base` whenever one exists, under git as well.
Baseline in Evals says when the agent makes it and when the agent deletes it.
A copy made after the first change is not a baseline. The agent makes that
copy; the script never writes.

Without a baseline, under git, the check compares with the last commit. In
that case, do not commit before validation ends, for the reason Baseline
gives.

With neither git nor a baseline, the check is `limited` with the reason `no
baseline`, and Missing Checks decides the result. The script lists every current
permission line in the files it checks. Check those against the diff shown to
the user.

A permission line in a file the plan creates and names is covered by that
plan. Compare it with the planned content.

When the check compares with the last commit, flags caused by earlier
uncommitted changes are expected. Check each against
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

Before the first change of the work, copy the whole skill to a folder
outside the skill folder. That copy is the baseline. It serves the `--base`
of `permission-lines`, the evals, and an exact restore after
Abandon. Later changes in the same work do not copy again.

An exact restore puts back each file of the baseline that changed, and
deletes each file that the baseline does not hold.

After Accept, when a piece of outside content goes to Planning, keep the
baseline. The plan
started from that piece makes its own baseline, and keeps the old one only to
restore that piece. When that plan ends with Abandon, also offer to restore the
piece from the old baseline. Delete the old baseline when the last such plan
ends and every offer to restore a piece is answered. Otherwise, delete the
baseline when the work ends: the result is Passed or Limited, or the user chose
an ending after Failed and answered every restore offer.

Work that moves from Direct Drafting to Planning keeps the Direct Drafting
baseline.

Git HEAD at validation time is not a baseline. A commit made before validation
turns HEAD into the changed version, which is then compared with itself.

The same copy is the `--base` for `permission-lines`, under git as well.
Passing `--base` switches off the comparison with the last commit.

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
| Both pass | No effect |
| Changed version passes, baseline fails | No effect; the report notes the eval as fixed |
| Changed version fails, baseline passes | Failed: a regression |
| Both fail, rule touched | Failed |
| Both fail, rule not touched | An unrelated problem, as Validation describes |
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
decision is required; otherwise return to planning. Once validation has
started, continuing never changes a permission line, or a line that bans or
limits an agent action, as Validation step 9 says.

**Implementation mismatch.** Correct it mechanically when that is possible.
Otherwise return to planning, through the Decision Prompt in Ending After
Failed. A correction that changes a permission line is not mechanical, as
Validation step 9 says. Content the brief or request did not ask for is not a
mismatch. It stays a Failed cause, and Ending After Failed asks about it.

Missing context during implementation is not a normal state. It means a check
failed earlier, the process failed, or something outside changed. Stop and
follow the matching path.

When a process failure happened after files were modified, stop modifying,
identify what changed after the last reliable state, and do not silently
revert it. Restore only when the restoration is exact and mechanical.
Otherwise take recovery through planning.

A blocked state does not end or suspend the workflow.

## Final Integrity Check

For a substantial rewrite, run this check twice: before the Approval Brief,
and after application. When unsure whether a rewrite is substantial, run it.
Other changes skip this check. After application, apply only a suggestion
that the approved brief already covers. A suggestion outside the approved
scope goes to Planning.

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
Safety        Unrelated safety findings, with file and line
Result        Passed, Limited or Failed, with cause lines and any ending
Checks        What was actually checked
Findings      What each check found, including Validation steps 1 to 3 and
              the behaviour tests, and the judgement on each
Evals         Each eval's result on both versions, and any that did not run
Coverage      Every accepted decision: not found first, then found, with its quoted line
Limitations   What could not be checked, and why
```

A decision whose owner file does not exist is listed as "owner file missing",
which counts as not found.

Report the result first, after any Safety line. A report that describes the
checks and leaves the result to be inferred makes the reader do the work the
report exists to do.

When the result is Failed, the Result line names each report line that holds
a Failed cause, such as `Failed: Findings, Coverage`. After an ending, it adds
the ending: `Failed: Coverage; ended: Failed accepted`.

Omit a line that has nothing in it, except Result.
