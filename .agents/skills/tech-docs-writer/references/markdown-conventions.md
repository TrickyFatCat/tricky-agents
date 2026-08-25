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

For bundled configuration documentation, avoid standalone installation or verification sections unless the user explicitly asks for them. Prefer official runtime paths such as `~/.config/...` in user-facing docs. Use repository-internal paths only when documenting source layout or maintainer workflow.

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

## Document Location

When a requested document is not found at the named path, do not silently substitute a similarly named generated or output copy.

Use this order:

1. Check the exact path or filename the user gave.
2. Search safe, likely project locations.
3. If there is one clear match, state the path before using it.
4. If there are multiple plausible matches, ask the user to choose.
5. If only generated/output copies are found, ask before treating one as authoritative.

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

## Editorial Markers

Use temporary editorial markers when the user adds editing feedback directly to a document. Recognize `REVIEW`, `TODO`, and `FIXME` markers in uppercase and lowercase.

Supported marker formats:

```markdown
> [!REVIEW]
> Comment text.

> [!review]
> Comment text.

> REVIEW
> Comment text.

> review
> Comment text.

REVIEW
Comment text.

review
Comment text.

REVIEW: Comment text.

review: Comment text.

<!-- REVIEW: Comment text. -->

<!-- review: Comment text. -->
```

The same formats apply to `TODO`/`todo` and `FIXME`/`fixme`.

Treat these markers as requests for analysis, not automatic permission to edit.

When editorial markers are present:

1. Analyze them in document order.
2. Map each marker to the nearest relevant heading.
3. Number them in the response while keeping the relevant section names.
4. Prepare proposed changes and wait for approval when required by active instructions.
5. Apply only approved changes.
6. Remove a marker after its request is resolved.
7. Keep unresolved markers in the document.
8. Report any editorial markers that remain.

Marker blocks continue until the next blank line, heading, or editorial marker unless the format clearly contains the whole comment on one line.

`REVIEW`, `TODO`, and `FIXME` markers are temporary editorial annotations when they appear in these marker-only formats. Reader-facing `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, and `CAUTION` callouts are documentation content and must not be interpreted as editing instructions.

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
