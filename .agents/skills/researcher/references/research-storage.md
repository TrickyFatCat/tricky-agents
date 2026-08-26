# Research Storage

Read this reference when research needs a persistent artifact, destination selection, continuation, or lifecycle update.

The storage workflow must preserve the same human-readable research package across destinations. Active global and project instructions remain authoritative.

## Resolve the Destination

Resolve storage in this order:

1. A path the user provides in the initial request or in response to a destination prompt.
2. `linked-vaults/research-vault` when that exact path is available.
3. A local `output/` destination after notifying the user and receiving confirmation.

Inspect only the expected linked-vault path. Do not search parent directories, the home directory, or unrelated project paths for another vault. Do not create, replace, rename, repair, or delete a linked-vault entry.

A user-provided directory is a storage root. Create the standard research directory beneath it. If the user explicitly names an exact file, honor that destination and explain when it bypasses the standard package layout.

When neither a user path nor the expected linked vault is available, state the proposed local destination and ask for confirmation or another path:

> No explicit research path or linked research vault is available. I can save this research under `output/<research-slug>/`. Proceed, or provide another save path.

If the user confirms, use the active project's output convention. When no more specific convention exists, use `output/<research-slug>/README.md`. If the user supplies another path, resolve it as the highest-priority destination. If the user declines without supplying a path, complete the research in conversation and do not create files.

## Apply Project Rules

Destination selection does not grant permission to write.

Before creating or changing an artifact:

1. Read applicable rules for external data, linked vaults, output directories, deliverables, and approvals.
2. State the resolved destination and proposed files when approval is required.
3. Write only after receiving required approval.
4. If a destination is prohibited, explain the constraint and offer only compliant alternatives.

Never ask whether authoritative rules should apply. If approval is declined, complete the research in conversation and state that no artifact was created.

Treat linked vaults as external user data. Never broadly scan a vault. Inspect the narrow index, year, project, or research path needed for the request.

## Use One Research Package

Every destination uses the same leaf structure:

```text
<research-slug>/
├── README.md
├── sources.md       # when needed
├── notes/           # when needed
└── attachments/     # when needed
```

`README.md` is required. Create supporting files or directories only when they contain useful material.

Use these destination layouts by default:

```text
linked-vaults/research-vault/research/<year>/<research-slug>/README.md
<user-path>/<research-slug>/README.md
output/<research-slug>/README.md
```

A project-specific output convention takes precedence over the default output layout. Organizational parent directories may differ, but the research package and metadata schema remain the same.

Choose a concise lowercase kebab-case slug based on the research subject. Reuse an existing directory only when its immutable ID and scope match the current research. Otherwise choose a more specific slug; never overwrite adjacent research merely because its title is similar.

## Metadata Schema

Start `README.md` with stable YAML metadata:

```yaml
---
type: research
schema_version: 1
id: research-YYYYMMDD-research-slug
title: Human-readable research title
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
scope: general
project: null
topics: []
confidence: medium
storage_context: project-output
---
```

Use:

- `id`: immutable identity derived from the creation date and stable slug.
- `status`: `draft`, `active`, `completed`, or `superseded`.
- `scope`: `general`, `project`, or `personal`.
- `project`: a stable project name or repository identity when applicable; do not rely on an absolute local path.
- `topics`: human-readable discovery terms, not a substitute for directory identity.
- `confidence`: `high`, `medium`, or `low` only when it usefully communicates the conclusion's evidence quality.
- `storage_context`: `obsidian-vault`, `user-path`, or `project-output`.

Add optional fields such as `completed`, `supersedes`, `superseded_by`, or `related` only when they carry real information. Update `updated` only for meaningful research changes, not formatting alone.

## README Contract

Make the artifact understandable without reconstructing the investigation. Include the sections needed to show:

- The research question.
- Relevant context and constraints.
- The current conclusion or answer.
- Key findings and their evidence.
- Important alternatives when compared.
- Uncertainty, conflicts, inaccessible evidence, and limitations.
- Sources suitable for user review.

Put links near important or disputed claims. Use `sources.md` when annotations, source-quality assessment, or claim mapping would make the README unwieldy. Do not create empty sections merely to satisfy a template.

A small factual check may use only `README.md`. Substantial, continuing, or attachment-heavy research uses the same package with the necessary supporting material.

## Continue and Complete Research

When continuing research:

1. Resolve the artifact by immutable `id`, not title alone.
2. Confirm its question and scope match the request.
3. Preserve prior conclusions when new evidence materially changes them; record what changed and why.
4. Update findings, source attribution, confidence, status, and `updated` together when applicable.
5. Preserve unrelated user notes and attachments.

When completing research:

1. Answer the scoped question directly.
2. Record decision-changing uncertainty and source limitations.
3. Set `status: completed` and add `completed: YYYY-MM-DD`.
4. Validate links and the final package directly.

Do not automatically move, delete, archive, or supersede research. Do not automatically migrate an `output/` artifact when a linked vault later becomes available. A user-approved import must preserve the immutable ID and record its original path when useful.

## Final Storage Check

Before reporting completion, confirm:

1. The chosen destination followed the priority order and active rules.
2. The research directory and required `README.md` exist.
3. Metadata, title, scope, status, and storage context agree with the artifact.
4. Important claims map to inspected evidence.
5. Relative links resolve and no empty scaffolding was created.
6. Only approved files or vault entries changed.
7. The response names the saved path and any validation limitation.
