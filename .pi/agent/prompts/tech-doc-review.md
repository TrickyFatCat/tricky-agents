---
description: Start a teaching-oriented technical documentation review
argument-hint: "[focus|general]"
---

Use the `tech-docs-reviewer` skill.

Review this documentation to improve both the document and my documentation skill.

Fill in any missing context from the document when possible. Ask only when missing context would change the review.

**Project:**
**Document type:**
**Document mode:** tutorial | maintainer-reference | personal-notes | command-reference | troubleshooting | unknown
**Audience:**
**Reader goal or maintainer use case:**
**Focus area:** ${ARGUMENTS:-general}
**Review output:** inline only

If the focus area is `general`, do a broad review across structure, audience fit, onboarding flow, examples, troubleshooting, safety notes, language clarity, Markdown readability, and maintainability. Match findings to the document mode; do not force tutorial-style expectations onto maintainer reference or personal documentation.

If the documentation is too large to review deeply in one pass, state the scope reviewed and prioritize the highest-impact findings.

Suggested focus values:

- `general` — broad review of everything important
- `structure`
- `audience`
- `document-mode`
- `onboarding`
- `examples`
- `troubleshooting`
- `safety`
- `language`
- `markdown`
- `maintainability`

**Known issues I already see:**

**Documentation or files to review:**
