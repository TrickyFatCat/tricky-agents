# Markdown Conventions

Read this reference when creating or editing human-facing Markdown documentation.

Preserve established project conventions when they differ from these defaults, unless the user approves a style change.

## Title and Headings

Use one HTML title as the first heading:

```markdown
<h1>Tool or Document Name</h1>
```

Use Markdown `##` and deeper headings after the title.

Keep headings:

- Concise.
- Descriptive.
- Free of backticks and inline code formatting.
- Stable enough that existing links do not change unnecessarily.

## Table of Contents

When a document is long enough to need navigation, generate the table of contents from its Markdown headings.

Use these markers:

```markdown
<!--toc:start-->

- [Overview](#overview)
- [Command Reference](#command-reference)
  - [Client Lookup](#client-lookup)

<!--toc:end-->
```

Rules:

- Preserve existing `<!--toc:start-->` and `<!--toc:end-->` markers.
- Place generated entries between the markers.
- Do not add the first `<h1>` title to the table of contents.
- Include relevant `##` and deeper Markdown headings.
- Keep link text identical to the visible heading text.
- Update entries when headings are added, removed, renamed, or reordered.
- Do not remove or replace the markers during formatting.
- Follow a project-specific TOC convention when one is already established.

Do not add a separate `## Table of Contents` heading unless the project uses one.

## Section Structure

Prefer a predictable, task-oriented order when it fits:

1. Overview.
2. Requirements or location, when needed.
3. Quick Start or Quick Examples.
4. Configuration or setup.
5. Common usage.
6. Command or API reference.
7. Advanced details.
8. Troubleshooting.
9. Useful or related links.

For maintainer references, personal notes, or dotfiles documentation, use a compact structure and omit obvious sections. Do not force tutorial-style requirements or onboarding into a concise reference.

Place information where readers need it:

- Defaults before optional setup paths.
- Safety warnings beside risky commands.
- Option explanations beside relevant syntax or examples.
- Detailed mappings and implementation notes after common usage.
- Troubleshooting after normal behavior has been shown.

Avoid redundant structure:

- Do not add a subsection that only repeats its parent heading.
- Merge one-paragraph sections unless the heading improves navigation.
- Add related links only when they provide useful navigation.
- Do not repeat filenames or companion tools in multiple ending sections without a reader need.

## Section Introductions

Start a major section with one or two short sentences when readers need orientation before a table, list, or group of subsections.

An introduction can:

- Explain what the section helps the reader do.
- Identify when it is relevant.
- Link to child sections when readers must choose a path.

Do not repeat the full table of contents inside a section. Use a short linked section map only when it helps readers choose between meaningful groups.

## Callouts

Use GitHub-supported callouts when information needs emphasis:

```markdown
> [!NOTE]
> Useful information readers should know.

> [!TIP]
> A helpful way to work more effectively.

> [!IMPORTANT]
> Information required for success.

> [!WARNING]
> Information needed to avoid a likely problem.

> [!CAUTION]
> A risk or negative consequence readers should avoid.
```

Prefer the most specific callout type. Keep warnings next to the command, option, or workflow they affect.

Do not invent custom callout labels unless the renderer or project convention requires them. Ask before converting existing custom callouts when their intent is unclear.

## Editorial Review Comments

Use a temporary `REVIEW` callout when the user adds editing feedback directly to a document:

```markdown
> [!REVIEW]
> Shorten this explanation and mention the main command.
```

Treat these comments as requests for analysis, not automatic permission to edit.

When review comments are present:

1. Analyze them in document order.
2. Number them in the response while keeping the relevant section names.
3. Prepare proposed changes and wait for approval when required by active instructions.
4. Apply only approved changes.
5. Remove a comment after its request is resolved.
6. Keep unresolved comments in the document.
7. Report any review comments that remain.

`REVIEW` callouts are temporary editorial annotations. Reader-facing `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, and `CAUTION` callouts are documentation content and must not be interpreted as editing instructions.

## Links

Use descriptive link text rather than bare URLs when practical.

For a related-document list, add a short reason to open each local document when the filename alone is not enough:

```markdown
- [Nushell Configuration](./README.md) — config layout and module registration.
```

Do not add a links section that only repeats resources already introduced elsewhere.

## Markdown Formatting

After formatting, confirm:

- The title and heading levels are intact.
- TOC markers remain in place.
- TOC entries match current headings.
- Tables remain readable.
- Callouts still have valid syntax.
- Code-fence languages are correct.
- Local links and relative paths still make sense from the document location.
