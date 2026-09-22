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
- [Lists and Prose](#lists-and-prose)
- [Voice](#voice)
- [Tables](#tables)
- [Explaining a Rule](#explaining-a-rule)
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

A heading names what is inside the section. A reader who cannot tell from the heading what the section contains has to read the section to find out, which is the work the heading was there to save.

A heading covers everything in its section, not the most memorable part of it. A reader looking for the rest of the section scans past a heading that named something narrower.

**Example**

```text
Weak    Why A Missing Licence Fails The Build
Strong  Build Rejection Reasons
```

Do not put a count in a heading. The count changes and the heading goes stale.

A heading that joins two things with `or` asks the reader to choose one of them. Use `vs` when the section compares them instead.

A section heading in a reference or explanatory section is a short noun phrase. A step heading in a how-to guide or a tutorial is an imperative verb phrase, because the reader is scanning for the action they are about to take. A document title is neither, because it names the whole document, and an explanation's title may be the question it answers.

A clause has to be read as a sentence. A table of contents built from clauses gives the reader no column of nouns to skim, and its entries wrap.

```text
Clause                        Noun
How A Request Is Authorised → Request Authorisation
When Your Script Runs       → Script Timing
How Drift Gets Corrected    → Drift Correction
```

Keep a term the reader meets in the thing they touch: a command name, a flag, a config key, an error message, an interface label, or the project's glossary. That is the word they will search for. Replace a term that appears only in source or in internal design notes, and replace it with another noun rather than with a description of the section.

In a document that already exists, a heading changes only when it is wrong, not when a better one exists. A rename breaks inbound links and the reader's memory of where the section was.

The question a section answers is a planning note, not its heading.

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

A warning about a safety feature states what that feature does not cover, in explicit and plain words. "A clean scan is evidence, not proof" is too compressed to work as a warning; "the scan does not guarantee safety and only helps to catch some issues" says the same thing and lands.

A caveat belongs in one place. Repeating it further down the section reads as noise and weakens the first statement.

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

Use [document-modes.md](document-modes.md) to select and adapt the structure. For maintainer references, personal notes, or dotfiles documentation, use a compact structure and omit obvious sections. Do not force tutorial-style requirements or onboarding into a concise reference.

For bundled configuration documentation, avoid standalone installation or verification sections unless the user explicitly asks for them. Prefer official runtime paths such as `~/.config/...` in user-facing docs. Use repository-internal paths only when documenting source layout or maintainer workflow.

Describe the configuration, not one machine. Documentation is read on machines the writer never sees, so never state what happened on the machine it was written on, and never present a local absolute path as though it were general. Name the setting, file or environment variable that decides the outcome, and link to its authority.

```text
Wrong   On this machine the linter picked up ~/.config/lintrc.
Right   The linter reads the first config it finds, starting in the working
        directory and ending in ~/.config. See its configuration reference.
```

Naming where a tool looks is general. Asserting what one machine resolved is not.

Place information where readers need it:

- Defaults before optional setup paths.
- Safety warnings beside risky commands.
- Option explanations beside relevant syntax or examples.
- Detailed mappings and implementation notes after common usage.
- Troubleshooting after normal behavior has been shown.
- Limits beside the thing they limit, never gathered into a closing section.

A section that collects limits at the end separates each one from the material it qualifies, so the reader adopts an approach and learns where it fails afterwards. A caching guide that explains invalidation in one section and warns about stale reads in a closing list has already let the reader ship the bug.

Avoid redundant structure:

- Do not add a subsection that only repeats its parent heading.
- Do not restate in an entry what an index above it already said. When a list names each file and its role, the block explaining that file does not repeat the role.
- Do not explain what the reader can see from the document itself.
- Merge one-paragraph sections unless the heading improves navigation.
- Add related links only when they provide useful navigation.
- Do not repeat filenames or companion tools in multiple ending sections without a reader need.
- When adjacent output examples repeat most of the same context, use one representative full example and focused snippets only for meaningful variants.
- Keep normal states, expected omissions, and feature-specific messages with the relevant feature. Keep a Troubleshooting item only when symptom-led diagnosis, recovery steps, or cross-feature context adds reader value.

## Lists and Prose

A sentence that announces a count and then enumerates it in clauses is a list written as prose. Convert it. This holds at any count: two items packed into one sentence is the same defect as five.

```text
Weak    `global/` holds three files. Two are yours to edit, one is built
        from them.

Strong  `global/` holds:

        - `machine-rules.md` — hand-edited
        - `personal-rules.md` — hand-edited
        - `global-agents.md` — generated from the other two
```

The signals are a number word, a phrase such as "two kinds of thing", or a sentence whose second half exists only to split what the first half counted.

A sentence that lists three or more actions in order is a numbered list, even with no number word. The reader follows steps by position, and a sentence hides where one step ends.

```text
Weak    The pipeline builds the game, runs the tests, and publishes the build
        to the store.

Strong  The pipeline:

        1. Builds the game.
        2. Runs the tests.
        3. Publishes the build to the store.
```

Follow the list with the per-item explanation when each item needs one. The list is the index; the blocks below it carry the detail.

Keep prose for reasoning, cause, consequence and trade-off, where the connection between sentences is the content.

## Voice

A sentence in documentation tells the reader something. A sentence that tells a
tool what to do belongs in that tool's own rules, not in the document about it.

The defect hides wherever the documented subject has rules of its own, because
an imperative copied across from those rules still reads as ordinary prose.

**Example**

```text
Weak    So read each match before acting on it.
Strong  The scan gives you a list of candidates, not a verdict. Read each
        match yourself before you act on it.
```

A rule names who performs it. Where the document and its subject can both act,
an unattributed rule leaves the reader deciding which one it means, and it does
nothing for them until they do.

Name one concept with one term. Define it where it first appears, and use the
same word every time after. A second word for the same thing makes the reader
ask whether there are two things.

```text
Weak    Join a session from the lobby. The match starts when the room is full.
Strong  Join a match from the lobby. The match starts when it is full.
```

Lead with what the reader gets or does, then the mechanism behind it. A rule
stated as the subject's internal logic does not tell the reader why it matters
to them.

```text
Weak    Without a save slot the game cannot store progress, so it does not
        start.
Strong  Choose a save slot so the game can keep your progress.
```

Write for a reader whose first language may not be English.

- One idea per sentence. A rule and its reason are two sentences.
- No idioms. "Stops short" becomes "does not reach".
- Jargon is a term. Define it in one line where it first appears, as above.

A native reader loses nothing from plain wording. A reader working in a second
language has to translate an idiom before they can use the sentence.

**Example**

```text
Weak    The cap keeps the spawner honest, since a runaway wave tanks the
        frame rate.
Strong  The spawner creates at most eight enemies at a time. More enemies
        than that lower the frame rate.
```

## Tables

Always put one short sentence before a table. The sentence says what the table
lists, so the reader knows what they are scanning before they start.

- A column you named that needs a sentence of explanation is badly named; rename it. A column carried from a source keeps the source's name (see Restating A Source in [source-verification.md](source-verification.md)).
- Keep column names short.
- Two tables may sit together when the second has its own introductory line. Without one they read as a single confusing block.
- A bare code such as `S1` or `E2` is not an identifier. Use the name it stands for, so the reader does not have to open another document.
- Keep cells short. Reasoning goes in the prose around the table.

## Explaining a Rule

A document that states a rule explains why it exists. The mechanics alone tell
a reader what happens without telling them whether it should worry them.

Use this shape:

1. A note that the situation can arise.
2. The exact conditions, named rather than counted.
3. The reason behind them.
4. A simple example.

Never write "two of those triggers" or "one of the cases above". The reader
then has to work out which, and the sentence has added nothing.

Look for the reason in the source before writing one. A rule that exists for a
stated purpose usually says so somewhere, and a reason invented to fill the
gap is a claim the document cannot support.

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

Start a major section with one or two short sentences when readers need orientation before a table, list, code block, command, or group of subsections.

A section never opens on a code block. Name what the command does before showing it, so the reader knows what they are about to run.

An introduction can:

- Explain what the section helps the reader do.
- Identify when it is relevant.
- Link to child sections when readers must choose a path.

Do not add introductory prose only to satisfy a template.

Keep a lead-in short and literal. "This tool has these modes:" does the job; a
paragraph explaining how modes are chosen does not, because the reader came
for the list.

A label introducing a short list goes on its own line, with the list beneath
it.

Lead an explanation with its label rather than its example. Write
"**Review** — you have a file in mind", not the example first with the label
trailing at the end.

Put a worked example after the explanation it illustrates, not before it.

Mark an example so the reader can tell it from the claims around it. An
unlabelled example reads as one more assertion.

An `Example` label has no end marker. Content that follows an example and is
not part of it starts under a heading or a new label, or it reads as more of
the example.

An example is one concrete case of the claim above it: a named thing, a value,
or a situation. A general statement under an `Example` label is a claim. Move
it into the prose, or replace it with a case.

Where several examples sit near each other, give each one a label that
distinguishes it. A retry policy showing a failed call, a throttled call and a
timeout needs `Failure`, `Throttled` and `Timeout`; unlabelled, the three merge
into a single passage.

A sentence states its own subject and object, without borrowing either from
the heading above it. Headings get collapsed, linked to directly and read out
of order.

```text
Weak    Two cases stop it short.
Strong  Two cases stop a deployment from rolling back automatically.
```

Cut words that carry no context. "After you approve" becomes "After approval",
and the meaning survives.

Keep clause order parallel between neighbouring rows and sentences. A reader
scanning a table compares cells position by position, and a reordered clause
breaks that.

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

Run this checklist after `scripts/format-docs.nu` has formatted the document. Run it also after a manual-check fallback, where the formatter was unavailable and this checklist is the only check performed.

After formatting, confirm:

- The title and heading levels are intact.
- TOC markers remain in place.
- TOC entries match current headings.
- Tables remain readable.
- Callouts still have valid syntax.
- Code-fence languages are correct.
- Local links and relative paths still make sense from the document location.
- Renderer-specific syntax still works in the intended destination.
