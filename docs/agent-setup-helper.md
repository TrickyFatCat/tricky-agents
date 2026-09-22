# agent-setup-helper

This skill helps you build and change agent skills and `AGENTS.md` files.

## Modes

This skill has these modes:

| Mode            | Trigger                                           | Can change files |
| --------------- | ------------------------------------------------- | ---------------- |
| Direct answer   | You ask about a concept or a fact                 | No               |
| Discussion      | You talk design with nothing to look at           | No               |
| Review          | You give it something to assess                   | No               |
| Direct Drafting | You ask for a clear change that needs no approval | Yes, with a diff |
| Planning        | You ask to plan, or a change needs approval       | After approval   |

### Review vs Discussion

Review and Discussion are told apart by one thing: whether you named or
attached a specific file.

- **Review** — you have a file in mind. "What do you think of this reference?"
- **Discussion** — you do not. "Should this mode exist at all?"

Ask for both at once, as in "review this and fix the worst part", and the skill
reviews first. It asks for approval before it changes anything.

## What Needs Your Approval

The skill applies changes directly, and shows the diff.

However, some important changes require approval:

- Creating, deleting, renaming or splitting a file.
- Changing a trigger, a permission or a routing rule.
- Touching more than one file.
- Changing a line that contains **must**, **never**, **only** or **ask**.
- Asking it to plan.

### Small Changes

> ℹ️ **Note**
>
> A small change can still need approval.

The skill judges a change by its effect, not by its size. Editing a line that
begins "Never edit…" needs approval even for a typo, because those four words
carry permissions and the line sets a rule. Two one-word edits in two files
need approval for the same reason, because they are still two files.

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

It runs these checks:

| Check              | What it looks at                                  |
| ------------------ | ------------------------------------------------- |
| `spec`             | Frontmatter fields and types                      |
| `routes`           | References exist and links resolve                |
| `size`             | `SKILL.md` length against the limits              |
| `permission-lines` | Changed lines containing must, never, only or ask |
| `safety`           | Pattern matches from `safety.md`                  |
| `all`              | Everything above, in one report                   |

It returns these exit codes:

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
> The scan does not guarantee safety and only helps to catch some issues.

The scan reads text, so it misses:

- An address built by joining strings, where no whole address appears.
- A harmful action described in innocent words.
- Code that only runs under a condition it cannot evaluate.

It also over-reports, because a pattern cannot tell doing something from
forbidding it.

**Example**

`tech-docs-writer` has the line "Never record an assumption silently". The scan
flags it as an action being hidden, even though the line forbids exactly that.

The scan gives you a list of candidates, not a verdict. Read each match
yourself before you act on it.
