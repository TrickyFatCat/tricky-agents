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

Each prompt accepts an optional focus argument:

```text
/code-review correctness
/doc-review structure
```

If no focus is provided, the prompt asks the agent to prioritize the highest-impact issues first.

## Maintenance Notes

Prompt template filenames become slash command names. For example:

```text
.pi/agent/prompts/code-review.md -> /code-review
```

Keep prompt templates concise. Put detailed reusable review behavior in skills, not in prompt templates:

- `code-reviewer` defines code review behavior.
- `documentation-reviewer` defines documentation review behavior.

Do not place README files inside `.pi/agent/prompts/`. Pi discovers `*.md` files in that directory as prompt templates, so a README there could become an unintended slash command.
