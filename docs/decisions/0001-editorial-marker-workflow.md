# Editorial Marker Workflow

Status: Accepted
Date: 2026-08-26

## Context

Documentation reviews can contain temporary `REVIEW`, `TODO`, and `FIXME` annotations in callout, blockquote, plain-text, or HTML-comment forms. Earlier handling assumed a narrower syntax and initially used a similarly named generated document instead of the reviewed source.

A strict marker search also failed to find existing comments, showing that format recognition alone was not enough without a reliable discovery and document-resolution workflow.

## Decision

Documentation review and writing workflows will:

- Confirm the exact document before using a similarly named generated or output copy.
- Recognize uppercase and lowercase `REVIEW`, `TODO`, and `FIXME` markers in supported callout, blockquote, plain-text, and HTML-comment forms.
- Start discovery with a broad whole-word marker search, then inspect matches in context.
- Map markers to their nearest relevant headings and prepare changes in document order.
- Apply approved requests with targeted, marker-scoped edits that preserve unreviewed content.
- Remove resolved markers, retain unresolved markers, and report what remains after formatting.

## Reasons

The workflow must reliably find user feedback without mistaking generated copies for authoritative documents. Targeted edits reduce the chance of overwriting unrelated changes made between review passes.

## Consequences

- Marker handling is more tolerant of the formats users naturally write.
- Reviews require a broad discovery pass and contextual inspection rather than one strict regular expression.
- Whole-document rewrites are reserved for explicitly approved restructuring.
- Validation includes a final marker search, adding a small amount of work but reducing incomplete resolutions.

## Alternatives

- Require only `> [!REVIEW]` callouts. Rejected because existing documents use simpler forms.
- Depend on one strict marker-format expression. Rejected because it can miss valid comments.
- Rewrite the document after approval. Rejected as the default because it can overwrite unrelated content.

## Related Changes

- Commit `3dca719` — introduced broader editorial marker and document-location guidance.
- Commit `60cef41` — added resilient discovery and marker-scoped editing.
- `.agents/skills/tech-docs-reviewer/SKILL.md`
- `.agents/skills/tech-docs-writer/references/markdown-conventions.md`
