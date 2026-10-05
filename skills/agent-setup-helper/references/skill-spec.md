# Skill Specification Rules

Load this reference when creating a Skill, changing frontmatter or a
description, or adding scripts.

## Boundary

Sections, in order: Limits; Description Writing; Gotchas; Script Interface;
Sources and Fetch Dates; Update Check.

This file holds the published Agent Skills rules the skill applies. It does
not say when to plan a change, how to review one, or where content belongs.

It owns the limits, the frontmatter rules, progressive disclosure, description
writing and trigger testing, where gotchas go, the script interface, the
sources and the update check.

The limits and frontmatter rules below are duplicated in `scripts/check.py`.
Each source page carries its own fetch date. Change Integrity compares the two
copies only when a change touches them or their sources.

## Limits

| Rule | Value | Source page |
|---|---|---|
| `SKILL.md` length | Under 500 lines | Specification, agentskills Best Practices |
| `SKILL.md` size | Under 5,000 tokens | Specification, agentskills Best Practices |
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

Two rules come from Claude best practices and apply where Claude may load the
skill:

- `name` must not contain the reserved words "anthropic" or "claude";
- `description` must not contain XML tags, such as `<skill-dir>`.

`check.py` reports both as "Claude platform only" findings. Change Integrity
says how they are judged.

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

Give a file over 100 lines a list of its sections at the top, a guide from
Claude best practices. An agent may preview only the start of a long file, and
the list shows it the whole scope before it decides what to read.

## Description Writing

Four rules from the optimising-descriptions page, and one from Claude best
practices.

- Use imperative phrasing. Write "Use this skill when...", not "This skill
  does...".
- Describe what the user is trying to achieve, not how the skill works.
- Be pushy. Name the contexts where the skill applies, including ones where
  the user does not name the domain.
- Stay concise. A few sentences to a short paragraph.
- Never write "I" or "you". The description is injected into the agent's
  system prompt, where a first or second person reads as a speaker.
  "Use this skill when..." uses neither, so it meets both sources.

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

Reference a script by a path relative to the skill root, and tell the agent to
resolve it from the skill's base directory. The shell may start elsewhere,
such as the user's project, where a relative path fails.

Three more rules come from Claude best practices.

- Write paths with forward slashes, even for Windows. A backslash path fails
  on other systems.
- Give each constant a reason for its value: name its source, or say it was
  chosen, not measured. Never invent a reason; an agent cannot tune a value
  whose origin it cannot see.
- Name an MCP tool the way the target harness writes it, server and tool
  together. The page writes `ServerName:tool_name`; Claude Code writes
  `mcp__server__tool`. A bare tool name may not resolve when several servers
  are loaded.

## Sources and Fetch Dates

Every rule above comes from these pages.

Fetched 2026-09-20:

- https://agentskills.io/home
- https://agentskills.io/specification
- https://agentskills.io/skill-creation/best-practices (agentskills Best
  Practices)
- https://agentskills.io/skill-creation/optimizing-descriptions
- https://agentskills.io/skill-creation/using-scripts

Fetched 2026-10-01:

- https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
  (Claude best practices)

## Update Check

Check these pages for changes when creating a Skill, or when the user asks.
Skip the check when there is no web access, and say that the rules are
unverified.

Report what changed. Do not apply a change to any file as part of the check.
A changed limit, a changed frontmatter rule or a new fetch date is a planned
change, because it updates this file and `scripts/check.py` together. Change a
date only after checking its values against the source.
