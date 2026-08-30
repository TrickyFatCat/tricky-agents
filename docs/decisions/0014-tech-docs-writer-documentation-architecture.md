# Tech Docs Writer Documentation Architecture

Status: Accepted
Date: 2026-08-30

## Context

Tech Docs Writer combined content modes, Markdown defaults, renderer behavior, TOC policy, callouts, editorial markers, and formatting guidance. Its reusable Markdown reference required an HTML title unconditionally, while current Markdown tools use different navigation, anchor, extension, and raw HTML behavior.

The Writer also described several document types without a source-backed selection method or adaptable structures. A proposed deterministic local documentation contract was rejected because agent output remains nondeterministic and active project instructions already provide local authority.

## Decision

Tech Docs Writer will use a layered documentation architecture:

- Use [Diátaxis](https://diataxis.fr/) as the main baseline for tutorial, how-to, reference, and explanation modes.
- Keep one adaptive documentation-mode reference instead of rigid assets for every mode.
- Select the content mode before applying renderer syntax or project-local formatting.
- Use Markdown ATX headings when there is no TOC or a heading should appear in Markdown-derived navigation.
- Use paired HTML headings for intentional navigation omission only when the confirmed renderer preserves raw HTML.
- Treat self-closing forms such as `<h1 />` as discussion shorthand, never copyable heading syntax.
- Prefer renderer-native TOC controls and validate anchors with the selected renderer or generator.
- Keep Writer's Markdown conventions as the shared callout and editorial-marker authority consumed by Tech Docs Reviewer.
- Use active project instructions as flexible local documentation authority without requiring a dedicated schema, filename, template, or contract artifact.
- Preserve target-local dprint configuration precedence and the user's global fallback.

Troubleshooting, maintainer, README, and personal documentation remain supported when the reader need does not fit one primary Diátaxis mode.

## Reasons

- Content modes describe reader needs; renderer profiles describe syntax and rendering behavior.
- One adaptive mode reference keeps the core focused without multiplying templates prematurely.
- Markdown does not define a universal mechanism for excluding individual headings from generated navigation.
- Paired HTML headings provide a useful omission technique across known HTML-capable tools while retaining valid heading elements.
- Keeping callout and editorial-marker rules in Writer avoids competing cross-skill authorities.
- Project instructions are simpler for humans to find and adapt than another deterministic configuration layer.
- Target-local formatter configuration preserves project ownership of Markdown style.

## Consequences

- Writers must identify both the reader mode and intended renderer when those choices affect output.
- Markdown headings remain the normal default; raw HTML omission requires confirmed compatibility.
- TOC presence and generation use navigation need and renderer behavior rather than universal line or heading thresholds.
- Tech Docs Reviewer can continue loading `tech-docs-writer/references/markdown-conventions.md` directly.
- Users may add concise documentation guidance to local `AGENTS.md`, but changes still require explicit approval.
- The formatter reports unreadable or unwritable targets before invoking dprint.
- One additional reference increases resource count but keeps optional structures out of the always-loaded core.

## Alternatives

- Require an HTML H1 in every document. Rejected because raw HTML is not a universal portable Markdown default and may be opaque to Markdown-aware tools.
- Use only Markdown headings and give up individual TOC omission. Rejected because intentional omission improves navigation in supported renderers.
- Create one template asset per document mode. Rejected until repeated use demonstrates that rigid copyable assets outperform one adaptive reference.
- Create one reference per renderer. Rejected because the current profile set does not justify the added fragmentation.
- Create a dedicated local documentation contract schema or file. Rejected because it adds ceremony without making nondeterministic output exact.
- Move callout rules into Tech Docs Reviewer. Rejected because Writer already owns the shared Markdown behavior and Reviewer consumes it.
- Bundle a dprint configuration with the skill. Rejected because it could override project-local style and duplicate the user's fallback configuration.

## Related Changes

- `.agents/skills/tech-docs-writer/SKILL.md`
- `.agents/skills/tech-docs-writer/references/documentation-modes.md`
- `.agents/skills/tech-docs-writer/references/markdown-conventions.md`
- `.agents/skills/tech-docs-writer/script/format-md.sh`
- [Decision 0001: Editorial Marker Workflow](0001-editorial-marker-workflow.md) remains accepted and governs editorial-marker behavior preserved by this architecture.
- Source: approved `Update Tech Docs Writer` proposal in the external task vault.
