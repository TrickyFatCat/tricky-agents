---
name: tech-docs-writer
description: Use when writing or reviewing human-facing Markdown documentation for tools, scripts, command-line workflows, setup steps, usage guides, troubleshooting notes, and project documentation. Includes an optional AI Notice when requested or required, and automatically formats generated Markdown with dprint.
---

# Technical Documentation Writer

Use this skill to write clear, practical Markdown documentation for humans who need to understand, install, configure, run, or troubleshoot tools and scripts.

## Goal

Create documentation that helps a human reader:

- Understand what the tool or script does
- Know when they should use it
- Install or prepare required dependencies
- Run it successfully
- Understand inputs, outputs, and side effects
- Troubleshoot common problems
- Safely avoid destructive mistakes

## Optional AI Notice

When requested, add a short AI notice near the top of the document explaining that AI assistance was used during drafting or editing.

Use an AI notice only when the user asks for it, the project requires it, or transparency is appropriate.

Recommended placement: directly below the title or overview.

Recommended wording:

```markdown
> **AI Notice:** This <type> and documentation were created with AI assistance. Test and review before using in your environment.
```

Replace `<type>` contextually with the kind of artifact being documented, such as `script`, `software`, `tool`, `workflow`, or `configuration`.

Do not imply that AI fully verified commands, paths, or procedures unless that testing actually happened.

## Table of Contents Rule

When the documentation should include a table of contents, generate it from the document's Markdown headers.

Rules:

- The first header must be written as an HTML `<h1></h1>` heading instead of Markdown `#` syntax.
- Exclude the first `<h1></h1>` heading from the table of contents.
- Include subsequent `##` and deeper Markdown headings in the table of contents.
- Keep headers concise.
- Do not use backticks/code formatting in headers.
- Keep table of contents link text identical to the visible heading text.

Example:

```markdown
<h1>Tool or Script Name</h1>

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Usage](#usage)
```

## Common Document Structure

Prefer a predictable, task-oriented structure. Start with the reader's immediate goal, then move from setup and everyday usage into detailed reference material.

Use this general order when it fits the document:

1. Title: one `<h1></h1>` heading that names the tool, script, workflow, or project.
2. Table of contents: include when the document is long enough to need navigation.
3. AI Notice: include only when requested or required.
4. Overview: explain what the document covers and who it is for.
5. Requirements: list required software, permissions, files, services, or environment variables.
6. Quick Start: provide the shortest safe working example.
7. Configuration or Setup: explain required setup steps and persistent configuration.
8. Common Usage: show the main tasks users are likely to perform.
9. Command or API Reference: document options, arguments, inputs, and outputs.
10. Details or Advanced Usage: include implementation notes, mappings, integrations, or edge cases.
11. Troubleshooting: list common symptoms, causes, and checks.
12. Safety Notes: use a standalone section only for cross-cutting risks that apply to the whole document.
13. Related Documentation: include only when it adds useful navigation beyond what is already introduced.

Keep optional or advanced material after the main usage path so the document does not feel overwhelming.

When a setup or configuration section has multiple paths, order them by reader priority rather than implementation order. Prefer:

1. Required or default configuration that affects later commands.
2. Regular or global setup for daily use.
3. Local, one-off, or script-specific setup.

Use concise path labels such as `Default Terminal`, `Global Use`, and `Local Use` instead of vague labels such as `Load Module` or longer verb phrases when the shorter name is clear.

## Section Placement and Redundancy

Place information where the reader needs it most:

- Put setup details in Setup or Configuration.
- Put defaults and persistent settings before optional setup paths when they affect later commands.
- Put safety warnings near the risky command, option, or workflow.
- Put workflow-related option explanations near usage examples when they help the reader act.
- Put terminal, version, platform, and compatibility caveats near the relevant support section.
- Keep support/reference sections focused on compatibility lists, mappings, default behavior, and caveats.
- Put detailed mappings, option tables, implementation notes, and extension instructions after quick start and common usage.
- Put troubleshooting near the end after the reader has seen normal usage.

Avoid redundant structure:

- Do not add a subsection that only repeats its parent section name.
- If a section contains only one short paragraph or list, merge it into the parent section unless the heading improves navigation.
- Do not add Related Files or Related Documentation sections unless they provide new, useful navigation.
- If filenames, scripts, or companion tools are already introduced in the overview, setup, or usage sections, do not repeat them at the end.

Prefer inline safety notes. Use a standalone Safety Notes section only when several risks apply across the whole tool and would be repeated too often inline.

## Section Introductions

Start each major section with a concise entry explanation before listing commands, tables, or subsections.

A good section introduction should:

- Explain what the section helps the reader decide or do.
- Mention when the section is relevant.
- Link to relevant child sections when the section has multiple paths or choices.
- Point to related later sections when it helps the reader continue, such as Common Usage or Command Reference.
- Stay short; usually one or two paragraphs is enough.

Do not repeat the full table of contents inside section introductions. Use links only when they help the reader choose the next relevant subsection.

Avoid repetitive phrasing such as `Use this section...`. Prefer natural wording, for example:

```markdown
The following reference lists command syntax, available options, and default behavior.
```

## Instruction Style

Prefer instruction-first wording over prose-heavy explanations.

For setup, usage, configuration, and troubleshooting sections:

- Use short action-oriented sentences.
- Use ordered lists when steps must happen in sequence.
- Use bullet lists when explaining choices, modes, or related options.
- Use concise subsection names such as `Default Terminal`, `Global Use`, and `Local Use` when the meaning is clear.
- Avoid long paragraphs that mix multiple instructions, choices, or caveats.
- Avoid redundant details already covered in reference sections unless they are critical at the point of action.

## Linked Input References

When a documentation task uses recurring local references from `linked-input/`, inspect the top-level symlinks first:

```bash
bash scripts/list-linked-input.sh
```

This lists available links without recursively following their targets. Read specific referenced files only when they are relevant to the task, and do not format or modify files under `linked-input/` or their symlink targets.

## GitHub Markdown Callouts

Use GitHub-supported Markdown callouts when a note, tip, warning, or risk needs to stand out.

Supported callout types:

```markdown
> [!NOTE]
> Useful information that readers should know.

> [!TIP]
> Helpful advice for doing something better or more easily.

> [!IMPORTANT]
> Key information readers need to achieve their goal.

> [!WARNING]
> Urgent information readers need to avoid problems.

> [!CAUTION]
> Risks or negative outcomes readers should avoid.
```

Prefer the most specific supported callout type. Do not invent custom callout labels unless the target documentation renderer or project convention requires them.

When editing an existing document that uses custom or non-GitHub callouts, ask whether they are intentional and get approval before converting, removing, or replacing them.

## Examples

Make examples self-contained and order them by user priority.

Each example should include:

1. A concise sentence explaining what the example does.
2. The command or configuration snippet.
3. Expected output or an extra note only when it helps verify or understand the result.

Put the primary user action before diagnostic or inspection commands. Keep safe inspection commands nearby when they help users verify behavior before acting.

Avoid global legends for placeholder values when each example can explain its own context more clearly. Also remove obvious comments that repeat the heading or introductory sentence.

Use direct wording for known behavior. Say `does` instead of `may` when the behavior is known.

For passthrough options such as `--term-args`, `--extra-args`, `--raw`, or similar fields:

- Explain that values are tool-specific and should be checked against upstream help.
- Explain whether the option is repeatable.
- If repeated values override earlier values, warn users to pass all values in one list or one invocation.
- Show one flag.
- Show a flag with a value.
- Show several values in one list when the option accepts a list.
- Show passthrough flags combined with regular options or command arguments.

Only document edge cases such as repeated options, precedence rules, defaults, or version-specific quirks when they have been tested or are documented upstream.

Prefer examples that can be tested safely without side effects, such as dry-run, build, preview, or inspect commands.

## Extension Documentation

When documenting how to extend a tool, explain the extension contract before implementation snippets.

Include the relevant details before code examples:

- Required inputs or record fields.
- Expected return value or output shape.
- Where registration, dispatch, or discovery happens.
- How to test the new extension safely before using it in a real workflow.

## Output Organization

For this project, save user-facing documentation deliverables under `output/<task-slug>/` using a lowercase kebab-case task slug.

Use `README.md` for README deliverables, for example:

```text
output/preview-git-repo/README.md
output/terminal-registry/README.md
```

Do not save README deliverables under `notes/`. Use `notes/<task-slug>/` only for internal findings, reviews, summaries, and reference notes.

## Recommended Structure

Start from a minimal skeleton and add sections only when they help the reader:

```markdown
<h1>Tool or Script Name</h1>

> **AI Notice:** This <type> and documentation were created with AI assistance. Test and review before using in your environment.

## Overview

## Requirements

## Quick Start

## Configuration

## Common Usage

## Command Reference

## Troubleshooting
```

Optional sections can include Advanced Usage, Terminal Support, Detection Helpers, Extension Guide, Cleanup, or Related Documentation when they add useful information.

Prefer inline safety notes. Add a standalone Safety Notes section only for risks that apply across the whole document and would be repeated too often inline.

Add Related Documentation only when it provides useful navigation beyond files or tools already introduced earlier.

## Writing Principles

When writing human-facing documentation:

1. Start with the user's goal.
2. Use plain, direct, instruction-first language instead of prose-heavy explanations.
3. Avoid obvious comments that repeat headings or examples.
4. Explain commands before risky changes.
5. Prefer short, self-contained examples over long abstract descriptions.
6. Include expected output when it helps confirm success.
7. Do not assume the reader knows hidden context; define placeholders like `<input-file>` or `<output-dir>`.
8. Keep headers concise and do not use backticks/code formatting in headers.
9. Order setup paths by user priority: defaults first, regular/global setup second, local/one-off setup third.
10. Put primary usage before diagnostic or inspection commands, while keeping safe inspection commands nearby when useful.
11. Place safety notes next to the command, option, or workflow they affect.
12. Keep support sections focused on compatibility, mappings, default behavior, and caveats.
13. Explain extension contracts before implementation snippets.
14. Document repeatability and override behavior for list-style or passthrough options when known.
15. Avoid undocumented options, guessed behavior, redundant headings, and low-value ending sections.

## Formatting

Automatically format completed Markdown documents after creating or editing them.

In the Pi harness, resolve `script/format-md.sh` relative to this skill directory and run it with the `bash` tool on the intended output document:

```bash
bash .agents/skills/tech-docs-writer/script/format-md.sh path/to/document.md
```

The formatting script currently runs `dprint fmt` and modifies the target Markdown file in place. Run it only on intended generated or edited Markdown documents.

Do not run formatting on read-only source material such as files under `input/`.

If the script fails, report the error clearly instead of installing tools or changing unrelated files.

## Command Documentation Rules

For shell commands:

- Use fenced code blocks with `bash`.
- Explain what the command does.
- Mention whether it changes the system.
- Put safety notes directly next to commands or options that can modify files, launch processes, use credentials, access the network, or run user-provided commands.
- Include safer inspection commands before destructive commands when possible.

Example:

````markdown
Check whether the service is running:

```bash
systemctl status example.service
```

This command is read-only. It shows the service state and recent log messages.
````

## Review Checklist

Before finalizing documentation, check:

- [ ] Purpose, requirements, setup, and common usage are clear.
- [ ] Structure is task-oriented, non-redundant, and places details where readers need them.
- [ ] Setup paths are ordered by user priority when multiple paths exist.
- [ ] Major sections have concise introductions with useful links only when needed.
- [ ] Instructions use action-oriented lists instead of prose-heavy paragraphs where appropriate.
- [ ] Examples are self-contained, copy-pasteable, safely testable where possible, and ordered with primary usage before diagnostics.
- [ ] Commands, inputs, outputs, defaults, and risky behavior are explained near the relevant command or option.
- [ ] Passthrough/raw argument options document repeatability and include examples for one flag, flag with value, several values in one list, and combined usage when applicable.
- [ ] Troubleshooting covers likely failures.
- [ ] Headers are concise, consistent, and do not use backticks/code formatting.
- [ ] Markdown callouts use GitHub-supported types unless custom callouts are intentional and approved.
- [ ] Table of contents is included when required, generated from document headers, and excludes the first `<h1></h1>` heading.
- [ ] Extension sections explain required inputs, expected outputs, registration points, and safe testing before implementation snippets.
- [ ] Support sections stay focused on compatibility, mappings, default behavior, and caveats.
- [ ] AI Notice is included if requested or required.
- [ ] Document is formatted with `script/format-md.sh path/to/document.md` after final edits.
