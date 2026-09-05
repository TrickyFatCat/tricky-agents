---
name: tech-docs-writer
description: Use when writing or editing human-facing Markdown documentation for tools, scripts, command-line workflows, setup steps, usage guides, troubleshooting notes, and project documentation. Applies source-backed drafting, renderer-aware Markdown, approved formatting, and post-format validation.
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

| Reference                                                                | Read when                                                                                                                                 |
| ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| [references/documentation-modes.md](references/documentation-modes.md)   | Selecting or adapting tutorial, how-to, reference, explanation, troubleshooting, maintainer, README, or personal-documentation structure. |
| [references/markdown-conventions.md](references/markdown-conventions.md) | Creating or editing Markdown, including headings, TOCs, callouts, editorial markers, links, and renderer-aware syntax.                    |
| [references/command-reference.md](references/command-reference.md)       | Documenting commands, scripts, options, arguments, output, side effects, validation, or extension contracts.                              |

For command-oriented Markdown documentation, read all three references.

For Review, Audit, or proposal artifacts, use `audit-workflow` for shared structure, lifecycle, persistence, and approval-boundary mechanics. Tech Docs Writer remains responsible for reader-focused drafting and editing, source validation, Markdown conventions, and post-format checks. Do not load Audit Workflow for ordinary documentation.

## Workflow

Use this workflow unless the task needs a smaller review-only pass:

1. Read active project instructions and identify storage, formatting, renderer, and validation rules. Treat clear project-local rules as authoritative over reusable Writer defaults.
2. Identify the document mode and intended reader.
3. Inspect the current document, source files, help metadata, and relevant call sites.
4. Separate verified behavior from assumptions and open questions.
5. Plan the reader journey and choose the smallest useful structure.
6. Draft or edit with reader tasks, safety, and source accuracy in mind.
7. Compare documented behavior against the current source.
8. Review the whole document before polishing local prose.
9. Reconsider whether the current structure needs a table of contents.
10. Format the intended Markdown file under the approved formatter contract.
11. Re-read the modified sections and perform the post-format checks.
12. Report files changed, validation performed, and anything not tested.

Ask clarifying questions when audience, platform, version, safety, or intended document mode changes the result.

Accept project-local documentation guidance in any clear form. Do not require a dedicated configuration schema, template, filename, or separate contract artifact.

When the user explicitly asks to establish documentation formatting, offer a short human-readable section in the relevant local `AGENTS.md`. Explain the proposed fields and wait for approval before editing project instructions. When current rules are unclear or conflicting, ask only about choices that materially affect the document.

## Structural Planning and Review

For substantive documentation, plan before drafting:

1. Confirm the primary reader, goal, and document mode.
2. Map each planned section to one responsibility.
3. Order prerequisites, actions, outcomes, and recovery information along the reader's path.

Before formatting, re-read the document as one reader journey:

1. Check progression, transitions, dependencies, point-of-need placement, duplication, mixed modes, audience boundaries, and the ending.
2. Check terminology, complexity, density, abstraction, repetition, and tone where they affect reader success.
3. Fix whole-document structure before polishing local prose.
4. Reconsider navigation after sections are added, split, renamed, or reordered.

Scale both passes to the task. Do not turn every dimension into a mandatory section or finding, and do not impose one universal document template.

## Document Mode

Identify the mode from the user's request and the existing document. Read [references/documentation-modes.md](references/documentation-modes.md) to select or adapt the detailed structure.

Common modes include tutorial, how-to, reference, explanation, troubleshooting, maintainer, README, and personal documentation. Choose one primary reader need rather than blending every mode into one document.

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

Follow active project formatter requirements first. When the project does not name a formatter, use the global Markdown helper only on the intended writable document:

```bash
~/.agents/scripts/format-markdown.sh path/to/document.md
```

Before promising formatted output, confirm that the target is writable and that the approved helper and formatter are available and applicable.

- If formatting is required but unavailable, stop and report the blocker.
- If the artifact contract permits unformatted delivery, perform the manual Markdown checks and disclose that formatting was not performed.

Do not format read-only source material, including files under `input/` or `linked-input/`. Never install, substitute, or reconfigure a formatter without approval.

## Post-Format Validation

After formatting:

1. Re-read the modified sections.
2. Reconsider TOC need using the document's current size, structure, and navigation demands.
3. When a TOC is present, confirm its markers, entries, headings, and renderer-specific anchors remain valid.
4. Confirm tables, callouts, code fences, local links, and relative paths remain valid.
5. Compare documented commands and behavior with the current source.
6. Confirm names, signatures, defaults, return values, effects, and examples are still accurate.
7. Report checks that were not performed or behavior that was not tested.

Formatting is not validation. Do not report a document as verified solely because the formatter succeeded.

## Final Checklist

**Content and structure**

- [ ] The document mode, intended reader, and reader goal are clear.
- [ ] The structure supports the reader journey without duplicated responsibilities.
- [ ] Source-backed claims match current files or authoritative documentation.
- [ ] Commands, options, inputs, outputs, defaults, and side effects are accurate.
- [ ] Examples are relevant, copyable, and safely testable where possible.

**Safety and delivery**

- [ ] Warnings appear beside risky actions.
- [ ] TOC need was reconsidered; headings, markers, tables, callouts, code fences, and links are valid.
- [ ] New or removed public commands are reflected in command references.
- [ ] The intended file was formatted, or an allowed fallback and its manual checks were disclosed.
- [ ] Modified sections were re-read, and anything not tested was reported.
