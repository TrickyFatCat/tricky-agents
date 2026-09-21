# agent-setup-helper

This skill helps you build and change agent skills and `AGENTS.md` files.

It will not change a file that needs approval until you approve a plan. That is
the behaviour you notice first.

`SKILL.md` holds the exact rules. This page is a map.

## Modes

This skill has such modes:

| Mode            | You get it when                                   | Can change files  |
| --------------- | ------------------------------------------------- | ----------------- |
| Direct answer   | You ask about a concept or a fact                 | No                |
| Discussion      | You talk design with nothing to look at           | No                |
| Review          | You give it something to assess                   | No                |
| Direct Drafting | You ask for a clear change that needs no approval | Yes, with a diff  |
| Planning        | A change needs approval, or you ask to plan       | After you approve |

### Review Or Discussion

The difference is whether there is something to look at.

- "What do you think of this reference?", with the file attached, is Review.
- "Should this mode exist at all?" is Discussion.

Ask for both at once, as in "review this and fix the worst part", and it starts
in Review. It moves to Planning when work on a finding begins.

## What Needs Your Approval

Most changes it makes directly and shows you the diff. Some it will not touch
until you approve a plan.

The triggers are:

- Creating, deleting, renaming or splitting a file.
- Changing a trigger, a permission or a routing rule.
- Touching more than one file.
- Changing a line that contains **must**, **never**, **only** or **ask**.
- Asking it to plan.

### Why It Stopped For Something Small

Two of those triggers catch edits that feel tiny.

A second file always counts, even when both edits are one word. So does any
line containing must, never, only or ask, even when those words are not the
part you changed.

## References

The skill splits its rules across separate files and loads the ones the work
needs.

| Reference                  | Loads when                                 | Can change files    |
| -------------------------- | ------------------------------------------ | ------------------- |
| `planning.md`              | A change needs approval                    | After you approve   |
| `change-integrity.md`      | You approve a plan                         | Only approved scope |
| `review.md`                | Review mode                                | No                  |
| `authoring-guidance.md`    | Designing or reviewing a skill             | No                  |
| `agents-md.md`             | The file is an `AGENTS.md`                 | No                  |
| `architecture-analysis.md` | A skill gains, loses or merges a reference | After you approve   |
| `corner-case-discovery.md` | A new skill, or a changed trigger          | After you approve   |
| `skill-spec.md`            | Creating a skill or changing frontmatter   | No                  |
| `safety.md`                | Any create, change, review or install      | No                  |

### Why A New Skill Takes Longer

Two of those references are stages inside planning rather than modes of their
own, and they run before you see a plan.

`architecture-analysis.md` runs when a skill gains, loses or merges a
reference. `corner-case-discovery.md` runs for a new skill, and for an
`AGENTS.md` that describes behaviour.

An `AGENTS.md` describes behaviour when it says who decides something, or what
happens in what order. It is static when it lists paths, commands and
conventions. A long list of paths is static. One sentence about when to ask you
is not.

## The Validation Script

`check.py` looks at a skill folder and tells you what is wrong with it. It
never changes a file.

> ℹ️ **Note**
>
> The script needs Python 3.11 or newer, and PyYAML for the frontmatter check.

Run it like this:

```bash
python3 skills/agent-setup-helper/scripts/check.py all <skill-dir>
```

It can check:

- `spec` — frontmatter fields and types.
- `routes` — that references exist and links resolve.
- `size` — `SKILL.md` length against the limits.
- `permission-lines` — changed lines containing must, never, only or ask.
- `safety` — pattern matches from `safety.md`.
- `all` — everything above, in one report.

The script can return such exit codes:

| Exit | Meaning                                  |
| ---- | ---------------------------------------- |
| 0    | Everything passed                        |
| 1    | Something was found                      |
| 2    | Usage error, or the script could not run |
| 3    | Nothing found, but a check was limited   |

A limited check could not do its whole job. Without PyYAML, `spec` is the one
that reports it.

## Safety Scanning

The skill scans every skill and `AGENTS.md` it touches, looking for
instructions that could harm you.

It scans for:

- Instruction manipulation
- Hidden content
- Data leaving the machine
- Privilege and destruction
- Supply chain, persistence and secrets

A match is something to look at, not a verdict. Expect matches on text that
forbids the behaviour, because the pattern cannot tell the difference.

Anything from someone else is read and scanned in full before it runs, and you
approve it. That happens again on every update.
