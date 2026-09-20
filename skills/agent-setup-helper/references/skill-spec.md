# Skill Specification Rules

Load this reference when creating a Skill, changing frontmatter or a
description, or adding scripts.

## Boundary

This file holds the published Agent Skills rules the skill applies. It does
not say when to plan a change, how to review one, or where content belongs.

The limits below are duplicated in `scripts/check.py` as constants. Both
copies carry a fetch date. When the two dates differ, Change Integrity reports
a finding.

## Limits

| Rule | Value | Source page |
|---|---|---|
| `SKILL.md` length | Under 500 lines | Specification, Best Practices |
| `SKILL.md` size | Under 5,000 tokens | Specification, Best Practices |
| `description` | 1 to 1,024 characters | Specification |
| `name` | 1 to 64 characters | Specification |
| `compatibility` | 1 to 500 characters, when present | Specification |

The line and token limits are a recommendation, not a hard rule. The
`description` limit is hard: the specification calls it an enforced limit.

### Frontmatter Fields

`SKILL.md` must open with YAML frontmatter.

| Field | Required | Constraint |
|---|---|---|
| `name` | Yes | Lower-case letters, digits and hyphens only |
| `description` | Yes | Non-empty, at most 1,024 characters |
| `license` | No | A licence name, or a bundled licence file name |
| `compatibility` | No | At most 500 characters; environment requirements |
| `metadata` | No | A map from string keys to string values |
| `allowed-tools` | No | Space-separated tool list; experimental |

The `name` field has four further rules. It must not start with a hyphen, must
not end with a hyphen, must not contain two hyphens in a row, and must match
the name of the folder that holds the file.

### Progressive Disclosure

The agent loads a skill in three stages: `name` and `description` at startup,
the whole `SKILL.md` body on activation, and other files only when the
instructions call for them.

Two things follow. Keep `SKILL.md` to what the agent needs on every run, and
tell the agent *when* to load each other file.

```text
Useful:  Read references/api-errors.md when the API returns a non-200 status.
Useless: See references/ for details.
```

Keep file references one level deep from `SKILL.md`. Avoid chains of
references that load each other.

## Description Writing

Four rules from the optimising-descriptions page.

- Use imperative phrasing. Write "Use this skill when...", not "This skill
  does...".
- Describe what the user is trying to achieve, not how the skill works.
- Be pushy. Name the contexts where the skill applies, including ones where
  the user does not name the domain.
- Stay concise. A few sentences to a short paragraph.

### Trigger Testing

A description is untested until it has been run against queries.

- Write about 20 queries, 8 to 10 that should trigger and 8 to 10 that should
  not.
- Make the negatives near misses. A query that shares keywords but needs
  something else tests precision; an unrelated query tests nothing.
- Run each query about 3 times and take the trigger rate, because the result
  varies between runs. A rate above 0.5 counts as triggered.
- Split the queries about 60 per cent train and 40 per cent validation. Use
  only train failures to guide a rewrite, and pick the best version by its
  validation pass rate.

Do not add keywords taken from a failed query. That fits the description to
the test set rather than to the category the query stands for.

## Gotchas

Keep a gotchas section in `SKILL.md`, not in a reference. A gotcha is an
environment-specific fact that defeats a reasonable assumption, so the agent
needs it before it meets the situation and may not recognise the trigger in
time to load a file.

Build the section from real corrections. When the agent makes a mistake the
user has to correct, the correction belongs there.

## Script Interface

A bundled script is run by an agent that reads its output to decide what to do
next. Seven rules follow from that.

- Never prompt. Agents run in non-interactive shells, so a prompt hangs for
  ever. Take input through flags, environment variables or stdin.
- Support `--help`, and keep it short. It is how the agent learns the
  interface, and it competes for context with everything else.
- Put structured data on stdout and diagnostics on stderr, so the agent can
  parse one without the other.
- Use distinct exit codes for distinct failures, and document them in
  `--help`.
- Write errors that say what was wrong, what was expected, and what to try.
- Keep output predictable in size. Harnesses truncate long output, and the
  lost part is often the part that mattered.
- Offer a dry run for anything destructive, and be safe to run twice.

Reference a script by a path relative to the skill root. The agent runs
commands from there.

## Sources and Fetch Dates

Fetched 2026-09-20. Every rule above comes from these five pages.

- https://agentskills.io/home
- https://agentskills.io/specification
- https://agentskills.io/skill-creation/best-practices
- https://agentskills.io/skill-creation/optimizing-descriptions
- https://agentskills.io/skill-creation/using-scripts

## Update Check

Check these pages for changes when creating a Skill, or when the user asks.
Skip the check when there is no web access, and say that the rules are
unverified.

Report what changed. Do not apply a change to any file as part of the check.
A changed limit is a planned change, because it updates this file and the
constants in `scripts/check.py` together.
