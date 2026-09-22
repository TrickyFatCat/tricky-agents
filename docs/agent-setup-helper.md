# agent-setup-helper

This skill helps you design, change and review agent skills and `AGENTS.md`
files. It also safety-checks them, including a third-party skill before you
install it.

A reference is a file the skill loads only when a task needs it.

## Modes

| Mode            | Trigger                                                          | Can change files |
| --------------- | ---------------------------------------------------------------- | ---------------- |
| Direct Answer   | You ask about a concept or a fact                                | No               |
| Discussion      | You discuss design without naming a file                         | No               |
| Review          | You name or attach a file to assess, or ask to "improve" it      | No               |
| Direct Drafting | You ask for a clear change that needs no [approval](#approval)   | Yes, with a diff |
| Planning        | You ask to plan, or a change needs approval                      | After approval   |

**Example**

- "Fix the typo on line 12 of `review.md`" is Direct Drafting. The skill edits
  the line and shows the diff.
- "Add a reference for templates" is Planning, because it creates a file.

### Mode Choice

The skill uses one test to choose between Review and Discussion: did you name
or attach a specific file?

- **Review** — you named or attached a file. "What do you think of this reference?"
- **Discussion** — you did not. "Should this mode exist at all?"

If you ask for both at once, for example "review this and fix the worst part",
the skill reviews first. When work on a fix begins, it moves to Planning and
asks for approval before it changes anything.

## Approval

The skill applies most changes directly and shows the diff. These changes need
approval first:

- Creating, deleting, renaming or splitting a file.
- Changing a trigger, a permission or a routing rule.
- Touching more than one file.
- Changing a permission line.

A permission line is a line that contains **must**, **never**, **only** or
**ask**. Asking the skill to plan also goes through approval.

### Small Changes

The skill judges a change by its effect, not by its size.

**Example**

- A typo fix in a line that begins "Never edit…" needs approval, because
  **never** makes it a permission line.
- Two one-word edits in two files need approval for a different reason: they
  touch more than one file.

If the skill finds such a change while it is already editing, it stops and
moves to Planning.

## References

| Reference                  | Loads when                                                                                                   | What it may do                          |
| -------------------------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------- |
| `planning.md`              | A change needs approval                                                                                      | Plans; no file changes before approval  |
| `change-integrity.md`      | You approve a plan                                                                                           | Applies and validates the approved scope |
| `review.md`                | You ask for a review                                                                                         | Reports; never authorises a change      |
| `authoring-guidance.md`    | The skill designs or reviews a skill, reference or template                                                  | Knowledge only                          |
| `agents-md.md`             | The file is an `AGENTS.md`                                                                                   | Knowledge only                          |
| `architecture-analysis.md` | A new skill with several references, or a change that adds, removes, splits or merges a reference            | A stage inside Planning                 |
| `corner-case-discovery.md` | A new skill or behavioural `AGENTS.md`, or a change to a trigger, permission, routing rule or permission line | A stage inside Planning                 |
| `skill-spec.md`            | The skill creates a skill, changes frontmatter or a description, or adds scripts                             | Knowledge only                          |
| `safety.md`                | The skill creates, changes, reviews, installs or updates a skill or `AGENTS.md`                              | Findings for you to review              |

"Knowledge only" means the reference holds rules the skill reads. It changes
nothing by itself.

A behavioural `AGENTS.md` defines workflows, decisions, or when to ask you. A
file that only lists paths and commands is not behavioural.

### Planning Stages

Two references add extra stages to Planning, before you see a plan:

- `architecture-analysis.md` — works out how many references the skill needs,
    and what each one owns.
- `corner-case-discovery.md` — finds the cases the rules do not cover yet.

They produce decisions for you to approve, not file changes. They run for a new
skill and for the changes named in the table above.

This takes more time at the start. In return, each reference has one clear job,
and missing cases are found before any rule is written.

## Safety Scanning

The skill scans `SKILL.md`, `AGENTS.md`, references and scripts for safety
problems in five areas:

- Instruction manipulation — text that moves authority away from you.
- Hidden content — instructions a human reviewer cannot see.
- Data leaving the machine — reading a secret, or sending one out.
- Privilege and destruction — actions that widen what a file may do, or cannot
  be undone.
- Supply chain, persistence and secrets — fetching code, outliving the session,
  or carrying credentials.

> ⚠️ **Warning**
>
> The scan catches some problems, not all of them.

The scan reads text, so it misses:

- A web address built by joining strings, so the full address never appears.
- A harmful action described in innocent words.
- Code that only runs under a condition the scan cannot evaluate.

It also flags safe lines. A pattern cannot see the difference between a line
that does something and a line that forbids it.

**Example**

`tech-docs-writer` has the line "Never record an assumption silently". The scan
flags it under instruction manipulation, as an action hidden from review, even
though the line forbids exactly that.

The scan gives you a list of lines to check, not a verdict. Read each match
yourself before you act on it.

### Third-Party Skills

The skill treats a third-party skill or `AGENTS.md` as unreviewed until you say
otherwise.

1. It reads every file and runs the scan.
2. It reports what it found, including a clean result.
3. You approve, or you do not. Nothing third-party runs before that.

It repeats all three steps on every update.

## Validation Script

`check.py` looks at a skill folder and reports what is wrong with it. It never
changes a file.

The skill runs it after it applies an approved plan, and after Direct Drafting.
You can also run it yourself.

### Requirements

- Python 3.11 or newer.
- PyYAML. Without it, the `spec` check cannot read the frontmatter and reports
  Limited. The other checks run as normal.

### Usage

Run it from the repository root:

```bash
python3 skills/agent-setup-helper/scripts/check.py all <skill-dir>
```

It prints a JSON report.

### Checks

| Check              | What it looks at                                  |
| ------------------ | ------------------------------------------------- |
| `spec`             | Frontmatter fields and types                      |
| `routes`           | References exist and links resolve                |
| `size`             | `SKILL.md` length against the limits              |
| `permission-lines` | Permission lines changed since the last commit    |
| `safety`           | Pattern matches from `safety.md`                  |
| `all`              | Everything above, in one report                   |

`permission-lines` compares against the last commit, or against a copy you
pass with `--base`. With neither, it reports Limited.

### Exit Codes

| Exit | Meaning                                              |
| ---- | ---------------------------------------------------- |
| 0    | Every check passed                                   |
| 1    | A check found a problem                              |
| 2    | Usage error, Python too old, or a check could not run |
| 3    | No problems found, but a check was limited           |

A limited check ran only in part, for example `spec` without PyYAML.
