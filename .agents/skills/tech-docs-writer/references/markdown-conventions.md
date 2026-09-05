# Markdown Conventions

Read this reference when creating or editing human-facing Markdown documentation.

<!--toc:start-->

- [Precedence](#precedence)
- [Portable Baseline](#portable-baseline)
- [Titles and Headings](#titles-and-headings)
- [Table of Contents](#table-of-contents)
- [Renderer-Aware Syntax](#renderer-aware-syntax)
- [Callouts](#callouts)
- [Section Structure](#section-structure)
- [Frontmatter and Prose](#frontmatter-and-prose)
- [Document Location](#document-location)
- [Section Introductions](#section-introductions)
- [Editorial Markers](#editorial-markers)
- [Links](#links)
- [Markdown Formatting](#markdown-formatting)

<!--toc:end-->

## Precedence

Apply documentation requirements in this order:

1. Active project instructions and explicit user requirements.
2. Established conventions in the target document and nearby authoritative documentation.
3. Confirmed renderer or publishing-system behavior.
4. Portable Writer defaults in this reference.

Ask when higher-priority sources conflict materially. Do not edit project instructions without explicit approval.

Accept project-local documentation guidance in any clear form. Do not require a dedicated configuration schema, template, filename, or separate contract artifact.

## Portable Baseline

When the renderer is unknown, prefer Markdown constructs with broad CommonMark support:

- ATX headings.
- Paragraphs and blockquotes.
- Ordered and unordered lists.
- Fenced code blocks with an accurate language when known.
- Descriptive inline and reference links.
- Inline code for literal names and short syntax.

Treat tables, task lists, callouts, wikilinks, heading attributes, raw HTML, and generated TOC markers as renderer or project extensions. Use them only when the destination, existing document, or user requirement supports them.

## Titles and Headings

Use Markdown ATX headings when there is no table of contents or when the heading should appear in Markdown-derived navigation:

```markdown
# Tool or Document Name

## Section
```

When a visible heading should be intentionally omitted from Markdown-derived navigation and the confirmed renderer preserves raw HTML, use a paired HTML heading:

```html
<h1>Tool or Document Name</h1>
<h2>Visible section omitted from the Markdown TOC</h2>
```

`<h1 />` and `<h2 />` are discussion shorthand only. Never use self-closing heading syntax as a copyable document pattern.

Keep headings:

- Concise.
- Descriptive.
- In a valid hierarchy.
- Free of backticks and inline code formatting when practical.
- Stable enough that existing links do not change unnecessarily.

Follow established local heading syntax before changing a document. Validate raw HTML heading behavior in the intended renderer and output format.

## Table of Contents

Add a table of contents when it materially improves nonlinear navigation or helps readers resume work. Do not require one solely because a document crosses a line or heading threshold; use size and section count as prompts to reconsider navigation.

Reconsider TOC need after substantial structural edits and during the final pass. A document that began without useful navigation may need it after sections are added, split, renamed, or reordered. Length and heading count remain review signals, not universal thresholds.

Prefer the established project or renderer mechanism. A renderer may generate navigation automatically, use configuration, filter headings, or require document markers.

When the document uses generated markers, preserve them:

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
- Include headings selected by the established navigation mechanism.
- Exclude paired HTML headings only when omission is intentional.
- Keep link text identical to the visible heading text when the generator permits it.
- Update entries when included headings are added, removed, renamed, or reordered.
- Validate anchors with the target renderer or generator instead of assuming one global slug algorithm.
- Do not remove or replace markers during formatting.
- Do not add a separate `Table of Contents` heading unless the project convention requires it.

Do not repeat the full table of contents inside a section. Use a short linked section map only when readers must choose between meaningful groups.

## Renderer-Aware Syntax

Confirm the target renderer before relying on extensions.

Common profile choices include:

- GitHub or GFM: tables, task lists, and GitHub alerts when they improve the document.
- Obsidian: supported callouts, wikilinks, embeds, and raw HTML when the vault convention uses them.
- Static-site generators: native frontmatter, heading attributes, TOC controls, and plugins documented by that generator.
- Unknown or mixed destinations: portable baseline first, with extensions only when graceful fallback is acceptable.

Prefer native TOC configuration or heading filters before raw HTML omission when the renderer offers a clear supported control. Preserve established project behavior instead of converting syntax merely to match another profile.

## Callouts

Follow established project callout conventions first. For GitHub or renderer-neutral Markdown, use GitHub-supported alerts when emphasis materially improves comprehension:

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

Use ordinary prose when information does not need special emphasis. Prefer the most specific semantic type and keep warnings or cautions next to the command, option, or workflow they affect.

Preserve intentional custom callouts. When their intent is unclear, ask whether they are renderer-specific and get approval before converting, removing, or replacing them. Validate callout syntax against the intended renderer.

Reader-facing `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, and `CAUTION` callouts are documentation content. Do not interpret them as editing instructions.

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

Use [documentation-modes.md](documentation-modes.md) to select and adapt the structure. For maintainer references, personal notes, or dotfiles documentation, use a compact structure and omit obvious sections. Do not force tutorial-style requirements or onboarding into a concise reference.

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
- When adjacent output examples repeat most of the same context, use one representative full example and focused snippets only for meaningful variants.
- Keep normal states, expected omissions, and feature-specific messages with the relevant feature. Keep a Troubleshooting item only when symptom-led diagnosis, recovery steps, or cross-feature context adds reader value.

## Frontmatter and Prose

When a document uses frontmatter, do not repeat lifecycle status, dates, scope fields, task IDs, or other obvious metadata in prose unless the prose adds interpretation, reasoning, or a decision that metadata cannot express.

Preserve readable summaries that add meaning. Follow project-local metadata conventions rather than imposing a universal schema.

## Document Location

When a requested document is not found at the named path, do not silently substitute a similarly named generated or output copy.

Use this order:

1. Check the exact path or filename the user gave.
2. Search safe, likely project locations.
3. If there is one clear match, state the path before using it.
4. If there are multiple plausible matches, ask the user to choose.
5. If only generated or output copies are found, ask before treating one as authoritative.

## Section Introductions

Start a major section with one or two short sentences when readers need orientation before a table, list, or group of subsections.

An introduction can:

- Explain what the section helps the reader do.
- Identify when it is relevant.
- Link to child sections when readers must choose a path.

Do not add introductory prose only to satisfy a template.

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

Discover markers with a broad search before classifying their exact syntax:

1. Confirm the exact document path.
2. Search case-insensitively for the whole-word markers `review`, `todo`, and `fixme`, for example with `rg -n -i '\b(review|todo|fixme)\b' <document>`.
3. Inspect each match in context to distinguish editorial markers from ordinary prose.
4. If the user says markers exist but the search returns none, recheck the document path and read likely sections before concluding that no markers are present.

Do not rely on a strict marker-format regular expression as the only discovery pass.

Treat these markers as requests for analysis, not automatic permission to edit.

When editorial markers are present:

1. Analyze them in document order.
2. Map each marker to the nearest relevant heading.
3. Number them in the response while keeping the relevant section names.
4. Prepare proposed changes and wait for approval when required by active instructions.
5. Apply only approved changes with targeted, marker-scoped edits that preserve unreviewed content.
6. Rewrite the whole document only when the approved request requires broad restructuring.
7. Remove a marker after its request is resolved.
8. Keep unresolved markers in the document.
9. Repeat the broad search after formatting and report any editorial markers that remain.

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
- Renderer-specific syntax still works in the intended destination.
