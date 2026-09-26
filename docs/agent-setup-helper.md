# agent-setup-helper

This skill helps you design, change, review and safety-check agent skills and
`AGENTS.md` files. It also checks a third-party skill before you install or
update it.

You do not need to name it. The agent loads it when you ask about a skill, an
`AGENTS.md`, "my skill", "agent instructions" or a "rules file".

It is not for running the task another skill exists for, or for writing
application code.

## Modes

The skill works in one of five modes. It picks the mode from what you ask for,
not from the topic.

| Mode            | Your request                                 | Files                       |
| --------------- | -------------------------------------------- | --------------------------- |
| Direct Answer   | A question about a concept or a fact         | Never change                |
| Discussion      | Design talk, with no file to assess          | Never change                |
| Review          | A file to assess                             | Never change                |
| Direct Drafting | A clear change that needs no approval        | Change, with the diff shown |
| Planning        | A change that needs approval, or "plan this" | Change only after approval  |

A vague request such as "improve this" also starts Review. The
[Approval](#approval) section lists the changes that need approval.

When your intent is unclear in a way that changes the result, the skill asks
before it acts.

**Example**

- "What is a reference?" is Direct Answer.
- "Should this skill have a Discussion mode at all?" is Discussion.
- "What do you think of `review.md`?", with the file named, is Review.
- "Fix the typo on line 12 of `review.md`" is Direct Drafting, when that line
    has no **must**, **never**, **only** or **ask**.
- "Add a reference for templates" is Planning, because it creates a file.

**Mixed Requests**

A request such as "review this and fix the worst part" starts in Review. The
skill moves to Planning when work on a finding begins. This holds even for a
finding as small as a typo.

## Approval

A change waits for your approval when it will:

- create, delete, rename or split a file;
- change a trigger, a permission or a routing rule, which is a line in
    `SKILL.md` that sends a kind of work to the reference that owns it;
- touch more than one file;
- change a line that contains **must**, **never**, **only** or **ask**.

A request to plan also goes through approval. The skill applies every other
change directly and shows you the diff.

The skill judges a change by its effect, not by its size.

**Needs Approval**

- Adding a reference for templates.
- A one-word typo fix in a line that starts "Never edit".
- Two one-word edits in two files.
- A scratch file created inside the skill folder.

**No Approval**

- A typo fix in a line with no **must**, **never**, **only** or **ask**.
- A formatting fix in one reference.
- A temporary working file outside the skill folder, such as the register.

Future agents load every file inside the skill folder. A file outside it is
disposable.

### Drafting Stops

A Direct Drafting edit can turn out to need approval halfway. This happens
when:

- the edit reaches a change from the list above;
- `check.py` flags a **must**, **never**, **only** or **ask** line that this
    edit changed.

The skill then stops and moves to Planning. It does not report the edit as
complete.

### Valid Approval

Only two answers approve a plan:

- accepting the [Approval Brief](#approval-brief), the summary that ends
    planning;
- asking the skill to apply it.

None of these approve a plan:

- the end of a discussion;
- a change of topic;
- agreeing that a problem exists;
- silence;
- approving a different plan or item.

After approval, the skill applies the change at once. It does not ask a second
time.

When the agent has a plan mode, the skill uses it for approval. It enters plan
mode itself, or stays in it when plan mode is already on. The brief then
reaches you as the plan-mode approval prompt, the approval step your agent
already uses. Without a plan mode, the skill shows the Approval Brief in the
reply and waits.

If you change the plan after the brief, planning starts again and the old brief
no longer counts. If you reject the brief, the work ends.

## Planning

Planning settles every open decision before the skill writes anything. An open
decision is a choice between outcomes that differ in a way that matters. You
choose an option, accept the skill's proposal, or hand the decision to the
skill.

When planning starts, the skill:

1. Names the reason planning started, in one line.
2. Lists the open decisions in a register.
3. Puts one decision to you at a time.
4. Runs extra [design checks](#design-checks) for some changes.
5. Shows the Approval Brief and asks one approval question.

### Register

The register is the plan. It lists one decision per row, and an arrow marks
the decision you are on. Each row shows:

- the decision ID, never reused or renumbered;
- the status;
- the rule;
- the file that will hold the rule.

```text
    A01  Accepted  Discussion is the default for design talk   SKILL.md
→   A02  Open      Which file owns the safety patterns         —
    A03  Blocked   Pattern format, waits for A02                —
```

A replaced decision stays in the register, so you can see why the current
rule looks the way it does.

The skill always shows the register in the conversation. It saves a copy where
you ask. Otherwise, when the agent can write files, it saves a temporary copy
outside the skill folder.

**Decision Log**

Beside the register, the skill keeps `log.md`. It holds:

- the reason for each decision;
- the rejected options;
- scenario tests that are not High severity.

The register and the log are temporary. The finished skill does not depend on
them.

**Statuses**

A decision has one of these statuses:

| Status     | Meaning                                        |
| ---------- | ---------------------------------------------- |
| Open       | Not decided yet                                |
| Proposed   | Proposed to you, waiting for your answer       |
| Accepted   | Decided, by you or by the skill on your behalf |
| Deferred   | Postponed, and outside this approval           |
| Blocked    | Waits for another decision, named by its ID    |
| Superseded | Replaced by a newer rule. The row stays        |

A decision can be deferred only when the change does not depend on it.
The Approval Brief lists deferred decisions. Deferred work does not come back
when planning ends. Returning to it later starts a new plan.

### Decision Prompt

Each decision reaches you in the same shape, with one question at the end:

- **Decision Register** — only when it changed.
- **Current issue** — one row, with its ID.
- **Proposal** — what changes.
- **Risk / Trade-Off** — what could go wrong.
- **Next Decision** — one question.

**Example**

The register did not change, so this prompt leaves it out.

```text
Current issue      A02  Which file owns the safety patterns
Proposal           references/safety.md holds them. check.py reads them there.
Risk / Trade-Off   A skill that holds its own patterns could weaken its own scan.
Next Decision      Keep the patterns in safety.md?
```

### Delegation

You can hand a decision to the skill. Say so, and say which decision. The
skill then makes that decision, and it becomes Accepted.

**Example**

"You decide which file owns the safety patterns" hands over one decision.

**Not Delegation**

These requests do not hand over a decision:

- "improve this";
- "fix this";
- "make it better";
- "use your judgment".

When the scope you handed over is unclear, the skill takes the narrower one.
You still approve the whole plan through the Approval Brief.

A recommendation from the skill approves nothing and changes nothing in the
plan.

### Conflicts

Rules come from four levels. Each level may narrow the one above it:

1. The safety rules in your global agent instructions. Nothing overrides them.
2. A local `AGENTS.md` may narrow the other global rules, within its scope.
3. A skill may narrow the local `AGENTS.md`, within its task.
4. A reference has the authority of the `AGENTS.md` or skill that owns it.

When a narrower rule conflicts with a broader one, and nothing shows the
conflict was intended, the skill asks you. It does not let the narrower rule win
only because it is narrower.

### Design Checks

For some changes, the skill runs two extra checks inside Planning, before you
see the brief. Each gives you decisions to approve, not file changes. When both run, architecture analysis
comes first.

**Architecture Analysis**

Architecture analysis decides which file owns each piece of content. It runs
for:

- a new skill with several references;
- a change that adds, removes, splits or merges a reference.

**Corner-Case Discovery**

Corner-case discovery finds what a person could say or do next that the rules
do not handle. It shows you one concrete case at a time, so each new rule is tested against the rules
before it. It runs for:

- a new skill or behavioural `AGENTS.md`;
- a change to a trigger, a permission or a routing rule;
- a change to a line that contains **must**, **never**, **only** or **ask**.

An `AGENTS.md` is behavioural when it defines workflows, how the agent
interacts with you, who owns a decision, delegation, or how work moves from
one state to the next. One that only
records paths, commands, conventions or constraints is static. Length does not
decide it.

Each case the skill accepts becomes a scenario test. A test names the
trigger, what the agent must do, what it must not do, and the file that holds
the rule.

A case can have High severity, as [Reviews](#reviews) defines it. Its test then
goes into `tests/behaviour.md` in the skill folder. The brief lists that file,
with the proposed tests for you to approve.

### Single Plan

Only one plan is active at a time. If you raise unrelated work that needs
planning while planning is under way, the skill asks you to choose:

- continue the current plan;
- discard it.

It never opens a second plan. A short question that needs no planning gets a
short answer, and the skill returns to the same step.

During planning, the skill discards a plan only when you tell it to discard,
cancel or abandon it. A change of topic, silence or disagreement does not discard it.

### Approval Brief

The brief is the last step of planning. It has these parts, in this order:

1. **Change** — what will change, and the main effect.
2. **Scope** — what is affected, and what is kept.
3. **Files** — each file to create, modify or delete, with the IDs of the
    decisions it carries.
4. **Deferred** — postponed decisions, when there are any.
5. **Validation** — how the skill will check the change.

The brief ends with one approval question and nothing after it.

## Validation

After it applies an approved plan, the skill checks the result and reports it
in this shape:

```text
Result        Passed, Limited or Failed
Checks        What was actually checked
Findings      What the script reported, and the judgement on each
Coverage      Accepted decisions not found in their file, or "none"
Limitations   What could not be checked, and why
```

The result is one of three:

| Result  | Meaning                                                         |
| ------- | --------------------------------------------------------------- |
| Passed  | Required checks ran, no blocking problem                        |
| Limited | A check could not run, and its absence cannot change the result |
| Failed  | A blocking problem prevents completion                          |

A missing check that could change the result makes it Failed, not Limited.

The skill turns each `check.py` [status](#output) into part of the result:

- `pass` counts toward Passed.
- `limited` makes the result Limited, with the reason the script gives.
- `error` means the check did not run. The skill treats it as Limited and says
    why.
- `findings` are judged one by one. A finding the skill judges blocking makes
    the result Failed.

> ⚠️ **Warning**
>
> A Limited result can hide a check that errored, including the safety scan.

Read the Limitations line of the report. The skill's rules do not settle when
an errored check makes the result Failed instead.

Failed does not end the work, and it does not undo the change by itself. The
skill never undoes a change silently. It fixes a file that does not match the
plan when the fix is mechanical. It restores a file only when it can put back
exactly what was there before. Any other recovery goes through Planning.

**Coverage**

Each accepted decision must appear in the file its register row named. A
decision the skill cannot find there fails validation. Either the rule was lost
or the file was wrong, and both need you.

When validation finds an unrelated problem, the skill does not fix it inside
this change. It raises the problem only when it matters now.

## Reviews

> ℹ️ **Note**
>
> A review gives you findings and changes no file.

Asking the skill to fix a finding starts Planning, as
[Mixed Requests](#modes) describes.

Each finding has a severity. Severity is about what an agent does with the
rule, not how the rule reads.

| Severity  | Meaning                                     |
| --------- | ------------------------------------------- |
| 🔴 High   | An agent would act wrongly or unsafely      |
| 🟡 Medium | Two reasonable agents could act differently |
| 🟢 Low    | Correct, but costly to read or maintain     |

A badly worded rule that still gives one behaviour is Low.

A finding can also carry a label for the kind of problem:

| Label                | Meaning                                              |
| -------------------- | ---------------------------------------------------- |
| Gap                  | A behaviour the skill needs is undefined             |
| Unknown              | A fact about the agent or environment is unavailable |
| Risk                 | The rule works, but can misfire                      |
| Non-Viable           | A confirmed blocker stops the rule working           |
| Insufficient Context | The given material is not enough to assess           |

The label goes beside the severity, when one applies. A review also uses
Insufficient Context for a part it could not assess, such as a reference that
was not supplied.

A note that is not a problem carries a status instead: `✅ Accepted`,
`✅ Pass`, `🟢 Optional polish` or `⛔ Declined`. The skill's rules name these
statuses but do not define them.

## Safety Scanning

The skill scans `SKILL.md`, `AGENTS.md`, references and scripts. It scans when
it creates, changes, reviews, installs or updates a skill or an `AGENTS.md`.

`check.py` runs the patterns on a skill folder only, because it needs a
`SKILL.md`. The skill's rules do not say how an `AGENTS.md` on its own is
scanned.

The scan looks for five groups of problems:

| Group | Name                               | Looks for                                                   |
| ----- | ---------------------------------- | ----------------------------------------------------------- |
| S1    | Instruction manipulation           | Text that moves authority away from you                     |
| S2    | Hidden content                     | Instructions a human reviewer cannot see                    |
| S3    | Data leaving the machine           | Reading a secret, or sending data out                       |
| S4    | Privilege and destruction          | Wider access, or actions that cannot be undone              |
| S5    | Supply chain, persistence, secrets | Fetched code, changes that outlive the session, credentials |

Each group holds numbered patterns, such as `S1-08`. The full list is in
[`safety.md`](../skills/agent-setup-helper/references/safety.md).

> ⚠️ **Warning**
>
> The scan does not prove that a file is safe, and it misses some problems.

`check.py` matches patterns one line at a time. It misses:

- a web address built by joining strings, so the full address never appears;
- a harmful action described in innocent words;
- code that runs only under a condition the scan cannot evaluate;
- a phrase split across two lines.

It skips a file over 1 MB and reports the `safety` check as `limited`.

It also flags safe lines:

- security tools, which use dangerous patterns as their subject;
- documentation that shows a dangerous pattern to warn about it;
- other pattern files. The scan skips only the pattern file it uses,
    `safety.md` by default.

**Example**

`code-comments` has the line "Hide the comment." in its `SKILL.md`. The scan
flags it as `S1-08`, "An instruction to hide something". The line is a step in a
test: hide a comment, then check whether the code still reads clearly. It is
safe.

**Reading**

A match is a line for you to read, not a verdict. The skill still reads every
file in full, and you still approve.

Some problems have no pattern. The skill looks for them by reading:

- wording that steers the agent to one package, domain or service;
- a file that sends the conversation or project files somewhere;
- a request to put secrets in the agent's reply;
- access wider than the task needs, such as shell access in a formatting skill.

### Third-Party Skills

The skill treats a third-party skill or `AGENTS.md` as unreviewed until you say
otherwise.

1. The skill reads every file and runs the scan.
2. It reports what it found, including a clean result.
3. You approve, or you do not. Nothing third-party runs before approval.

The skill repeats all three steps on every update. A safe version tells you
nothing about the next one.

### External Libraries

The skill proposes an external library only when the standard library cannot
do the job. Without web access, it proposes none.

Before it proposes one, it checks:

- **Source** — the package on its index, its repository, and that the name
    matches the project.
- **Maintenance** — recent releases, and whether the project is active.
- **Licence** — OSI-approved and compatible with the work.
- **Dependencies** — the full tree, checked against the OSV database.
- **Pin** — an exact version, with hashes, installed from wheels.

Each result comes with its source and the date it was fetched. You approve.
The skill checks again on every version change.

A name close to a popular package is the finding that matters most. It is the
one a quick reading misses.

## Validation Script

`check.py` checks a skill folder and prints a JSON report.

> ℹ️ **Note**
>
> `check.py` never writes a file.
> The skill runs it after it applies an approved plan, and after Direct
> Drafting. You can run it yourself.

### Requirements

- Python 3.11 or newer.
- PyYAML, optional. Without it, the `spec` check reports `limited` and the
    other checks run as normal.

To install PyYAML at the pinned version and hashes, run this from
`skills/agent-setup-helper` in this repository:

```bash
pip install --require-hashes --only-binary=:all: -r scripts/requirements.txt
```

The pinned wheels cover CPython 3.11 to 3.14 on Linux x86_64 and Windows
x86_64.

On a Python marked as externally managed, pip refuses to install outside a
virtual environment. Create one outside the skill folder, install into it, and
run `check.py` with that environment's `python`. Inside the skill folder, the
scan would read every file in it.

### Usage

To run every check, run this from the root of this repository:

```bash
python3 skills/agent-setup-helper/scripts/check.py all <skill-dir>
```

The folder must contain a `SKILL.md`. Replace `all` with one check name to run
only that check:

| Check              | What it checks                                                 |
| ------------------ | -------------------------------------------------------------- |
| `spec`             | Frontmatter fields and types                                   |
| `routes`           | References exist and are named; links resolve inside the skill |
| `size`             | `SKILL.md` lines, characters, and a token estimate             |
| `permission-lines` | Changed lines containing must, never, only or ask              |
| `safety`           | Pattern matches from `references/safety.md`                    |
| `all`              | Every check above, in one report                               |

`size` reports a finding when `SKILL.md` is over 500 lines or 5,000 tokens. It
also reports a finding when `SKILL.md` is within 10% of either limit. The token count is an estimate:
characters divided by 4.

### Flags

These flags are optional:

| Flag                | Effect                                   |
| ------------------- | ---------------------------------------- |
| `--base <path>`     | Baseline copy for `permission-lines`     |
| `--files <path>...` | Limits `permission-lines` to these files |
| `--patterns <path>` | Safety pattern file for `safety`         |

The script also refuses:

- `--base` when the folder is inside the skill folder;
- `--files` when a file is outside the skill folder;
- `--patterns` when the file is inside the skill folder, unless it is the
    default.

`--base` takes a folder with the same layout as the skill folder. A checked
file with no copy there makes the check `limited`. Copy the whole skill, or
pass `--files` with the files you copied. `--files` takes paths relative to the
skill folder.

The default pattern file is the script's own `references/safety.md`. The
`--patterns` refusal stops a skill from supplying the patterns used to check
it.

### Permission Lines

`permission-lines` lists each must, never, only or ask line that was added,
changed or removed. It compares against the first baseline that applies:

```text
--base <path>         →  that folder
the skill is in git   →  the last commit of the checked skill's repository
neither               →  limited: lists every current must, never, only or ask line
```

A removed or reworded line is listed too, because the new wording may contain
none of the four words. A file with no copy in the baseline makes the check
`limited`.

The git baseline is the last commit, so the check also lists changes you made
earlier and did not commit. The skill compares each flag with the diff it
showed you. Flags from those earlier changes do not stop an edit.

### Output

The report is JSON on stdout. Error messages go to stderr. The report holds
`tool`, `spec_date`, `spec_url`, `skill`, and a `results` list with one entry
per check.

Each check in the report has a `status`:

| Status     | Meaning                                       |
| ---------- | --------------------------------------------- |
| `pass`     | No findings                                   |
| `findings` | At least one finding, listed under `findings` |
| `limited`  | Ran only in part. `reason` says why           |
| `error`    | Could not run. `reason` says why              |

A finding is not a failure. The skill judges each one during validation.

A check shows at most 50 findings. `total` gives the full count, and
`truncated` is `true` when some were left out.

**Example**

This is the `safety` result from `check.py all skills/code-comments`, trimmed.
The full entry also has `pattern_file` and `pattern_counts`.

```json
{
  "check": "safety",
  "status": "findings",
  "reason": null,
  "total": 1,
  "truncated": false,
  "findings": [
    {
      "id": "S1-08",
      "file": "SKILL.md",
      "line": 56,
      "message": "An instruction to hide something"
    }
  ]
}
```

### Exit Codes

The exit code sums up the whole report:

| Code | Meaning                                             |
| ---- | --------------------------------------------------- |
| 0    | Every check passed                                  |
| 1    | At least one check has findings                     |
| 2    | Usage error, Python too old, or a check has `error` |
| 3    | No findings, but at least one check was limited     |

When checks differ, 2 comes before 1, and 1 comes before 3. A report with an
`error` and a finding exits 2. A `limited` check that also lists findings
gives 1.
