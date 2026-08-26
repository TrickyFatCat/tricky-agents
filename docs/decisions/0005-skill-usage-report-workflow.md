# Skill Usage Report Workflow

Status: Accepted
Date: 2026-08-26

## Context

Skill improvements are easier to make when user feedback is captured as focused, traceable evidence. Feedback can appear in direct messages, report requests, corrections, and editorial comments inside reviewed material. Without a shared reporting convention, important skill issues can be lost in chat history or converted into proposals without a clear link back to the user-observed problem.

A global convention is needed because both global and project-local skills can receive feedback, and future `skill-creator` and `agents-maintainer` work should be able to trace proposals and decisions back to the reports that motivated them.

## Decision

Global agent instructions will route user-requested skill usage reports to `~/.agents/references/skill-usage-reports.md`.

The reference defines:

- Reports are created only when the user asks for them.
- The default project reports-vault location is `linked-vaults/reports-vault/skill-usage/` when available.
- Missing reports vaults require asking the user where to save or whether to return the report inline.
- Reports separate global and local skills by path structure and metadata.
- Reports capture user-pointed issues separately from agent interpretation.
- Reports use stable YAML metadata plus human-readable Markdown sections.
- Proposals and decisions should trace back to motivating reports when practical.
- Addressed, stale, superseded, and rejected reports are preserved.
- Archiving is an explicit process that moves eligible final-status reports under `skill-usage/archive/` only after approval or an approved batch workflow.

## Reasons

A global reference keeps the durable workflow available to every skill without expanding each skill file. YAML metadata supports AI-assisted filtering and traceability, while stable Markdown headings keep reports readable for humans. Keeping status in metadata avoids link breakage during normal lifecycle changes. Archiving by explicit workflow prevents old reports from cluttering active views without deleting historical feedback.

## Consequences

- Any skill can produce a consistent usage report when the user asks.
- Report creation remains opt-in and does not add automatic logging.
- Projects without a reports vault require an explicit user choice before persistent report storage.
- `skill-creator` and `agents-maintainer` gain a stable evidence source for proposals and decisions.
- Reports and decisions require maintenance links when feedback is triaged, decided, implemented, superseded, or archived.
- External reports vaults may not be Git-backed, so validation may be limited to direct file inspection.

## Alternatives

- Store the full workflow in global `AGENTS.md`. Rejected because it would make always-loaded instructions too long.
- Add report logic to each skill. Rejected because it would duplicate a shared convention and make updates inconsistent.
- Create reports automatically after every skill use. Rejected because it would create noise and persistent records without explicit user intent.
- Encode report status in directory names. Rejected because routine status changes would move files and break links.
- Delete addressed reports. Rejected because user feedback should remain traceable to proposals, decisions, and outcomes.

## Related Changes

- `.agents/AGENTS.md`
- `.agents/references/skill-usage-reports.md`
