# agent-setup-helper

This skill helps you build and change agent skills and `AGENTS.md` files.

## Modes

This skill has such modes:

| Mode            | Trigger                                           | Can change files |
| --------------- | ------------------------------------------------- | ---------------- |
| Direct answer   | You ask about a concept or a fact                 | No               |
| Discussion      | You talk design with nothing to look at           | No               |
| Review          | You give it something to assess                   | No               |
| Direct Drafting | You ask for a clear change that needs no approval | Yes, with a diff |
| Planning        | You ask to plan, or a change needs approval       | After approval   |

### Review vs Discussion

Both start with you raising something. The difference is whether a file came
with it.

- **Review** — you attached something to assess, as in "what do you think of
    this reference?".
- **Discussion** — there is nothing to look at yet, as in "should this mode
    exist at all?".

Ask for both at once, as in "review this and fix the worst part", and it
starts in Review. It moves to Planning when work on a finding begins.

## What Needs Your Approval

The skill applies changes directly, and shows the diff.

However, some important changes require approval:

- Creating, deleting, renaming or splitting a file.
- Changing a trigger, a permission or a routing rule.
- Touching more than one file.
- Changing a line that contains **must**, **never**, **only** or **ask**.
- Asking it to plan.

### Why A One-Word Change Needs Approval

Two of those triggers catch edits that look tiny.

**Touching more than one file.** Two one-word edits in two files still count
as two files.

**Changing a line with must, never, only or ask.** The line counts even when
you changed a different word on it.

## References

The skill uses several references:

| Reference                  | Loads when                                 | Can change files    |
| -------------------------- | ------------------------------------------ | ------------------- |
| `planning.md`              | A change needs approval                    | After approval      |
| `change-integrity.md`      | You approve a plan                         | Only approved scope |
| `review.md`                | Review mode                                | No                  |
| `authoring-guidance.md`    | Designing or reviewing a skill             | No                  |
| `agents-md.md`             | The file is an `AGENTS.md`                 | No                  |
| `architecture-analysis.md` | A skill gains, loses or merges a reference | After approval      |
| `corner-case-discovery.md` | A new skill, or a changed trigger          | After approval      |
| `skill-spec.md`            | Creating a skill or changing frontmatter   | No                  |
| `safety.md`                | Any create, change, review or install      | No                  |

### New Skill Creation

> ℹ️ **Note**
>
> Creating a new skill takes longer than changing an existing one.

Two references run as extra stages before you see a plan:

- `architecture-analysis.md` — works out how many references the skill needs,
    and what each one owns.
- `corner-case-discovery.md` — finds the cases the rules do not cover yet.

They cost time up front. In exchange the skill arrives with its
responsibilities already separated, and with the gaps found before they reach
a rule.

## The Validation Script

`check.py` looks at a skill folder and tells you what is wrong with it. It
never changes a file.

Dependencies:

1. Python 3.11 or newer.
2. PyYAML. Without it the `spec` check is limited and the rest still run.

These checks are available:

| Check              | What it looks at                                  |
| ------------------ | ------------------------------------------------- |
| `spec`             | Frontmatter fields and types                      |
| `routes`           | References exist and links resolve                |
| `size`             | `SKILL.md` length against the limits              |
| `permission-lines` | Changed lines containing must, never, only or ask |
| `safety`           | Pattern matches from `safety.md`                  |
| `all`              | Everything above, in one report                   |

The script can return such exit codes:

| Exit | Meaning                                  |
| ---- | ---------------------------------------- |
| 0    | Everything passed                        |
| 1    | Something was found                      |
| 2    | Usage error, or the script could not run |
| 3    | Nothing found, but a check was limited   |

Run it against a skill folder:

```bash
python3 skills/agent-setup-helper/scripts/check.py all <skill-dir>
```

## Safety Scanning

The skill scans every text file it touches, scripts included, for potential
safety issues:

- Instruction manipulation
- Hidden content
- Data leaving the machine
- Privilege and destruction
- Supply chain, persistence and secrets

> ⚠️ **Warning**
>
> A clean scan is evidence, not proof.

The scan reads text, so it misses:

- An address built by joining strings, where no whole address appears.
- A harmful action described in innocent words.
- Code that only runs under a condition it cannot evaluate.

It also over-reports. A security tool uses dangerous patterns because that is
its subject, and documentation shows one in order to warn about it. A match is
something to look at, not a verdict.

A skill you did not write is scanned in full before it runs, and you approve
it. That repeats every time you update it.
