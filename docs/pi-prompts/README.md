<h1>Pi Prompt Templates</h1>

## Overview

This directory documents the global Pi prompt templates stored in this repository.

The actual prompt templates live under:

```text
.pi/agent/prompts/
```

They are exposed globally through the symlink:

```text
~/.pi/agent/prompts -> ~/Repos/agents/.pi/agent/prompts
```

After changing prompt templates, run `/reload` in Pi to refresh the available slash commands.

## Prompt Catalog

| Command        | Template file                      | Purpose                                         |
| -------------- | ---------------------------------- | ----------------------------------------------- |
| `/code-review` | `.pi/agent/prompts/code-review.md` | Start a teaching-oriented code review.          |
| `/doc-review`  | `.pi/agent/prompts/doc-review.md`  | Start a teaching-oriented documentation review. |

## Usage

Invoke a prompt by typing its slash command in Pi:

```text
/code-review
/doc-review
```

Each prompt accepts one optional focus argument. If no focus is provided, the prompt asks the agent to prioritize the highest-impact issues first.

## Command Reference

### Code Review

Use `/code-review` to start a teaching-oriented code review with the `code-reviewer` skill.

Syntax:

```text
/code-review [focus]
```

Supported focus values:

- `general` — broad review of everything important.
- `correctness` — bugs, logic errors, assumptions, and behavior mismatches.
- `architecture` — structure, boundaries, coupling, and design choices.
- `readability` — naming, clarity, organization, and ease of future maintenance.
- `edge cases` — empty input, malformed input, boundary values, missing files, and unusual states.
- `testing` — test coverage, test design, fixtures, and verification strategy.
- `performance` — slow paths, repeated work, memory use, and scalability concerns.
- `security` — unsafe inputs, secrets, permissions, injection risks, and data safety.
- `language idioms` — more natural or conventional use of the language or tool.

Examples:

Start a broad review and let the agent prioritize the most important issues:

```text
/code-review
```

Review only likely correctness problems:

```text
/code-review correctness
```

Review readability and maintainability concerns:

```text
/code-review readability
```

Review whether the code follows language conventions:

```text
/code-review "language idioms"
```

After invoking the prompt, fill in the project, language or tool, goal, known issues, and files or pasted code to review.

### Documentation Review

Use `/doc-review` to start a teaching-oriented documentation review with the `documentation-reviewer` skill.

Syntax:

```text
/doc-review [focus]
```

Supported focus values:

- `general` — broad review of everything important.
- `structure` — section order, headings, navigation, and scanability.
- `audience` — reader assumptions, prerequisites, terminology, and context.
- `onboarding` — first-run flow, quick start, setup sequence, and path to success.
- `examples` — command examples, expected output, placeholders, and realism.
- `troubleshooting` — symptoms, checks, likely causes, and recovery guidance.
- `safety` — destructive commands, credentials, privileges, persistent changes, and rollback notes.
- `language` — clarity, concision, tone, grammar, and unexplained jargon.
- `markdown` — formatting, tables, lists, code fences, links, and heading quality.
- `maintainability` — duplicated content, stale references, and update burden.

Examples:

Start a broad documentation review and let the agent prioritize the most important issues:

```text
/doc-review
```

Review document structure and navigation:

```text
/doc-review structure
```

Review the first-time reader experience:

```text
/doc-review onboarding
```

Review safety notes and rollback guidance:

```text
/doc-review safety
```

After invoking the prompt, fill in the project, document type, audience, reader goal, known issues, and documentation files or pasted content to review.

## Maintenance Notes

Prompt template filenames become slash command names. For example:

```text
.pi/agent/prompts/code-review.md -> /code-review
```

Keep prompt templates concise. Put detailed reusable review behavior in skills, not in prompt templates:

- `code-reviewer` defines code review behavior.
- `documentation-reviewer` defines documentation review behavior.

Do not place README files inside `.pi/agent/prompts/`. Pi discovers `*.md` files in that directory as prompt templates, so a README there could become an unintended slash command.
