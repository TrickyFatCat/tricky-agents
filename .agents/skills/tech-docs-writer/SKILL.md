---
name: tech-docs-writer
description: Use when writing or editing human-facing Markdown documentation for tools, scripts, command-line workflows, setup steps, usage guides, troubleshooting notes, and project documentation. Includes an optional AI Notice when requested or required, and automatically formats generated Markdown with dprint.
---

# Technical Documentation Writer

Use this skill to write clear, practical Markdown documentation for humans who need to understand, configure, run, maintain, or troubleshoot tools and scripts.

## Goal

Create documentation that helps readers:

- Understand what the tool or workflow does.
- Find the shortest relevant path to use it.
- Understand inputs, outputs, defaults, and side effects.
- Validate success and diagnose likely failures.
- Avoid unsafe or destructive mistakes.

Match the result to the document mode instead of forcing every document into a tutorial structure.

## Reference Files

Read the relevant references before drafting or editing:

| Reference                                                                | Read when                                                                                                    |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| [references/markdown-conventions.md](references/markdown-conventions.md) | Creating or editing Markdown, including headings, TOC markers, callouts, links, and section structure.       |
| [references/command-reference.md](references/command-reference.md)       | Documenting commands, scripts, options, arguments, output, side effects, validation, or extension contracts. |

For command-oriented Markdown documentation, read both references.

## Workflow

Use this workflow unless the task needs a smaller review-only pass:

1. Read active project instructions and identify storage or formatting rules.
2. Identify the document mode and intended reader.
3. Inspect the current document, source files, help metadata, and relevant call sites.
4. Separate verified behavior from assumptions and open questions.
5. Choose the smallest useful structure.
6. Draft or edit with reader tasks, safety, and source accuracy in mind.
7. Compare documented behavior against the current source.
8. Format the intended Markdown file.
9. Re-read the modified sections and perform the post-format checks.
10. Report files changed, validation performed, and anything not tested.

Ask clarifying questions when audience, platform, version, safety, or intended document mode changes the result.

## Document Mode

Identify the mode from the user's request and the existing document.

Common modes:

- Tutorial or onboarding guide: emphasize outcomes, prerequisites, ordered steps, expected output, and troubleshooting.
- Maintainer reference: emphasize concise structure, conventions, discoverability, extension points, and low-maintenance wording.
- Personal notes or dotfiles documentation: preserve owner preferences, compact reminders, and established local conventions.
- Command reference: emphasize complete syntax, arguments, options, defaults, returns, effects, errors, and examples.
- Troubleshooting guide: connect symptoms to safe diagnostics, likely causes, and recovery steps.

Do not impose tutorial requirements on personal documentation or maintainer references. Omit obvious requirements, setup, troubleshooting, or links when they do not help the intended reader.

When a recommendation depends on the mode, state the assumption.

## Source Validation

Treat the current implementation as the source of truth unless the project identifies another authority.

Before documenting behavior:

- Read the relevant source material.
- Inspect public or exported interfaces.
- Check current names, signatures, flags, defaults, and output shapes.
- Inspect direct call sites when they clarify intended usage.
- Use local help or upstream documentation for external behavior.
- Prefer read-only inspection, validation, dry-run, or mocked checks before state-changing commands.

Do not describe guessed behavior as verified. If behavior cannot be confirmed, label the limitation or ask the user.

For command documentation, follow the full validation process in [references/command-reference.md](references/command-reference.md), including the final exported-command inventory check.

## Document Structure

Start from the reader's immediate goal, then move from common use into detail.

A general-purpose document may use:

1. Title.
2. Table of contents when navigation is useful.
3. Optional AI notice.
4. Overview.
5. Requirements when they are not obvious.
6. Quick Start or Quick Examples.
7. Configuration or setup.
8. Common usage.
9. Command or API reference.
10. Advanced details or extension guide.
11. Troubleshooting.
12. Useful or related links when they add navigation.

Add only sections that help the intended reader. For personal or maintainer references, prefer a compact structure such as overview, location, validation, important settings, extension points, and related docs.

Order multiple setup paths by reader priority:

1. Required or default configuration.
2. Regular or global setup.
3. Local, one-off, or script-specific setup.

Use concise labels such as `Global Use` and `Local Use` when they are clearer than longer phrases.

## Placement and Style

Put information where readers need it:

- Setup details in setup or configuration.
- Defaults before optional paths when they affect later examples.
- Warnings beside risky commands or options.
- Compatibility and version caveats beside the relevant feature.
- Detailed mappings and implementation notes after common usage.
- Troubleshooting after normal behavior has been shown.

Write in plain, direct, instruction-first language:

- Use ordered lists for required sequences.
- Use bullets for choices or related facts.
- Keep paragraphs focused on one idea.
- Prefer direct wording for known behavior.
- Define non-obvious placeholders.
- Avoid redundant headings and repeated explanations.

Start major sections with a short introduction when readers need orientation before a table, list, or set of subsections. Do not add introductory prose only to satisfy a template.

Follow [references/markdown-conventions.md](references/markdown-conventions.md) for headings, TOC markers, callouts, links, and section maps.

## Examples

Make examples self-contained and order them by user value.

Start with the smallest realistic example. Add optional flags, edge cases, or diagnostics only when they help the reader complete or verify a task.

Each example should provide, when useful:

1. A concise explanation of its purpose.
2. A copyable command or configuration snippet.
3. Expected output, return shape, effect, or verification note.

Concise code comments can identify returns, output shapes, side effects, or fallbacks in dense reference blocks. Avoid comments that only repeat a heading or command name.

Prefer examples that can be tested safely, such as list, inspect, dry-run, preview, build, or validation commands.

For detailed command examples, passthrough options, and table conventions, follow [references/command-reference.md](references/command-reference.md).

## Safety

Explain risky operations before readers run them.

- Prefer inspection before modification.
- State important side effects.
- Put warnings beside destructive or state-changing commands.
- Avoid unreviewed remote-code execution, credential exposure, broad permission changes, or privileged commands when safer alternatives exist.
- Include rollback or cleanup guidance when a configuration change is persistent and reversal is not obvious.

Use a standalone Safety section only when risks apply across the whole document and would otherwise be repeated.

## Linked Inputs

When a task uses `linked-input/`, follow the active project's linked-input rules.

- Inspect only the specific linked files needed.
- Do not recursively scan broad linked directories without a reason.
- Do not format or modify linked inputs or their symlink targets.
- Use linked material only as read-only source context unless the user separately authorizes work on the target file.

## Optional AI Notice

Add an AI notice only when requested, required by the project, or otherwise explicitly appropriate.

Recommended wording:

```markdown
> **AI Notice:** This <type> and documentation were created with AI assistance. Test and review before using in your environment.
```

Replace `<type>` contextually. Do not imply that commands or procedures were fully tested unless they were.

## Storage

Follow active project instructions for output, reviews, notes, and persistent deliverables. Do not embed project-specific storage layouts in this reusable skill.

Ask before saving a deliverable when project instructions require approval.

## Formatting

Format completed Markdown after creating or editing it.

Resolve `script/format-md.sh` relative to this skill directory and run it only on the intended writable document:

```bash
bash /home/tricky-fat-cat/.agents/skills/tech-docs-writer/script/format-md.sh path/to/document.md
```

The script runs `dprint fmt` and modifies the target file in place.

Do not format read-only source material, including files under `input/` or `linked-input/`.

If formatting fails, report the error. Do not install tools or change unrelated files automatically.

## Post-Format Validation

After formatting:

1. Re-read the modified sections.
2. Confirm the title and heading hierarchy.
3. Confirm TOC markers remain and entries match current headings.
4. Confirm tables, callouts, code fences, local links, and relative paths remain valid.
5. Compare documented commands and behavior with the current source.
6. Confirm names, signatures, defaults, return values, effects, and examples are still accurate.
7. Report checks that were not performed or behavior that was not tested.

Formatting is not validation. Do not report a document as verified solely because the formatter succeeded.

## Final Checklist

Before finalizing, check:

- [ ] The document mode and intended reader are clear.
- [ ] The structure is useful and non-redundant.
- [ ] Source-backed claims match current files or authoritative documentation.
- [ ] Commands, options, inputs, outputs, defaults, and side effects are accurate.
- [ ] Examples are relevant, copyable, and safely testable where possible.
- [ ] Warnings appear beside risky actions.
- [ ] Headings, TOC markers, tables, callouts, code fences, and links are valid.
- [ ] New or removed public commands are reflected in command references.
- [ ] The intended Markdown file was formatted.
- [ ] Modified sections were re-read after formatting.
- [ ] Anything not tested is reported.
