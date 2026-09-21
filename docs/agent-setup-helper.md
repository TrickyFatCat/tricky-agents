# agent-setup-helper

This skill helps you design, review, change and validate agent skills and
`AGENTS.md` files.

Its defining behaviour is a gate. Some changes it will not make until you
approve a written plan, and it decides that from the change itself rather than
from how you asked for it.

This document describes the shape of the skill rather than its rules. For the
exact wording of a rule, open `skills/agent-setup-helper/SKILL.md`. That file
is the authority, and this one is a map.

## Modes

The mode decides what the skill may do. It comes from what you want to do, not
from the topic you are discussing.

| Mode            | You get it when                                 | May change files        |
| --------------- | ----------------------------------------------- | ----------------------- |
| Direct answer   | You ask a conceptual or factual question        | No                      |
| Discussion      | You talk design and there is nothing to look at | No                      |
| Review          | You give it an artefact to assess               | No                      |
| Direct Drafting | You ask for a clear change that opens no gate   | Yes, and shows the diff |
| Planning        | A gate opens, or you ask to plan                | Only after you approve  |

Review and Discussion differ by whether something exists to look at. "What do
you think of this reference?" with the file attached is Review. "Should this
mode exist at all?" is Discussion.

A mixed request such as "review this and fix the worst part" starts in Review.
It moves to Planning when work on a finding actually begins.

## What Makes It Stop And Ask

Planning starts on its own when a change is large enough to need approval
first. These are the triggers.

- Creating, deleting, renaming or splitting a file.
- Changing a trigger, a permission or a routing rule.
- Touching more than one file.
- Changing a line that contains **must**, **never**, **only** or **ask**.
- Asking it to plan.

Anything else is edited directly and shown to you as a diff.

### Two That Are Easy To Trip

The last two triggers catch changes that feel small.

Touching a second file opens the gate even when both edits are trivial. So
does editing a line that happens to contain one of the four words, even if the
words are not the part you are changing.

### Temporary Files

A working file created outside the skill folder does not open a gate. A file
created inside the skill folder always does.

## The Nine References

The skill loads a reference when the work needs it, and several can be loaded
at once. The last column is what to check when you are wondering whether
something is allowed to change a file.

| Reference                  | Loads when                                         | May authorise a change  |
| -------------------------- | -------------------------------------------------- | ----------------------- |
| `planning.md`              | A gate opens                                       | Not before approval     |
| `change-integrity.md`      | Approval is given                                  | Only the approved scope |
| `review.md`                | Review mode                                        | Never                   |
| `authoring-guidance.md`    | Designing or reviewing a skill or reference        | Never                   |
| `agents-md.md`             | The artefact is an `AGENTS.md`                     | Never                   |
| `architecture-analysis.md` | A skill gains, loses, splits or merges a reference | A stage inside Planning |
| `corner-case-discovery.md` | A new skill, or a change to a trigger or must-line | A stage inside Planning |
| `skill-spec.md`            | Creating a skill, or changing frontmatter          | Never                   |
| `safety.md`                | Any create, change, review, install or update      | Findings only           |

`architecture-analysis.md` and `corner-case-discovery.md` are stages inside
Planning rather than separate modes. They run before you see a brief, which is
why a new skill takes longer to reach approval than a one-line edit.

### Behavioural Or Static

`corner-case-discovery.md` only loads for an `AGENTS.md` that is behavioural.

An `AGENTS.md` is behavioural when it defines workflows, interaction
behaviour, decision ownership or state transitions. It is static when it
records paths, commands, conventions or constraints and nothing more.

Length does not decide this. A long list of paths is static, and one sentence
about when to ask you is behavioural.

## The Validation Script

`scripts/check.py` reports. It decides nothing and writes nothing.

Run it against a skill folder:

```bash
python3 skills/agent-setup-helper/scripts/check.py all <skill-dir>
```

It takes any Python 3.11 or newer.

| Subcommand         | What it checks                                                  |
| ------------------ | --------------------------------------------------------------- |
| `spec`             | Frontmatter fields and types                                    |
| `routes`           | References exist, are named, and links resolve inside the skill |
| `size`             | `SKILL.md` lines, characters, and a token estimate              |
| `permission-lines` | Changed lines containing must, never, only or ask               |
| `safety`           | Pattern matches from `references/safety.md`                     |
| `all`              | Every check above, in one report                                |

| Exit | Meaning                                               |
| ---- | ----------------------------------------------------- |
| 0    | Every check passed                                    |
| 1    | At least one check has findings                       |
| 2    | Usage error, Python too old, or a check could not run |
| 3    | No findings, and at least one check was limited       |

Output is JSON on stdout, and diagnostics go to stderr.

### When A Check Is Limited

`permission-lines` needs a baseline to compare against. Outside a repository,
or on a file with no committed version, it reports every rule-bearing line as
unbaselined rather than telling you what changed.

`spec` needs PyYAML to parse frontmatter. Without it that one check reports
Limited and every other check still runs.

## Safety Scanning

`safety.md` loads whenever an `AGENTS.md` or a skill is created, changed,
reviewed, installed or updated. It carries five pattern groups.

| Group | Covers                             |
| ----- | ---------------------------------- |
| S1    | Instruction manipulation           |
| S2    | Hidden content                     |
| S3    | Data leaving the machine           |
| S4    | Privilege and destruction          |
| S5    | Supply chain, persistence, secrets |

Two rules change what you have to do with the result.

A pattern match is a finding for review, never a verdict. A clean scan is
evidence, not proof. Expect matches on text that forbids a behaviour, because
the pattern cannot tell the difference.

A third-party artefact is read and scanned in full before anything runs, and
you approve it. That repeats on every update, not just the first install.
