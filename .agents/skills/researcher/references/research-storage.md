# Research Storage

Read this reference when research needs a persistent artifact, destination selection, continuation, naming, or lifecycle update.

Active project instructions define storage authority. This reference provides a fallback contract without overriding project-specific destinations, metadata, naming, rendering, formatting, approval, or validation.

## Decide Whether to Persist

Persist research only when:

- the user requests a saved artifact;
- the selected research shape requires durable traceability or continuation; or
- active project instructions require it.

Quick evaluation stays conversational by default. Focused research is saved only when requested or required. For substantial, systematic, or regulated work, decide whether durable evidence and continuation are part of the selected method before writing.

If persistence is optional and declined, complete the research in conversation. If an authoritative project rule requires persistence and no compliant destination or approval is available, stop before claiming completion.

## Resolve the Destination

Resolve storage in this order:

1. Use an explicit user destination when allowed by active project rules.
2. Read active project instructions and use their research convention when defined.
3. Otherwise check only the project root for an existing `researches/` directory.
4. If it is absent, ask the user for a destination.
5. If the answer is ambiguous, use `<project-root>/researches/`, or `<current-working-directory>/researches/` when no project root is known.
6. Obtain required write approval before creating files.

An explicitly selected linked research vault is an explicit user destination, not an automatic fallback. Inspect only the narrow linked path required by the request; do not broadly scan linked vaults or search unrelated directories for another destination.

An explicit exact file bypasses the fallback directory layout. Follow its project rules and do not add a package directory unless the user requests one.

## Apply Project Rules

Destination selection does not grant permission to write.

Before creating or changing an artifact:

1. Read applicable rules for external data, linked vaults, output directories, deliverables, filenames, metadata, formatting, and approval.
2. State the resolved destination and proposed files when approval is required.
3. Write only after receiving required approval.
4. If a destination is prohibited, explain the constraint and offer only compliant alternatives.

Never ask whether authoritative rules should apply. Treat linked vaults as external user data and preserve their specific workflow.

## Use Semantic Research Artifacts

When no stronger project layout exists, use:

```text
<project-root>/researches/<research-slug>/
├── research-<research-slug>.md
└── source-ledger-<research-slug>.md  # when justified
```

If no project root is known, replace `<project-root>` with the current working directory. Do not add another global `research/` directory under `researches/`.

Use a concise lowercase kebab-case slug based on the research subject. Keep these concepts separate:

- **Immutable ID:** Stable identity used for continuation and lineage.
- **Title:** Human-readable subject description.
- **Slug:** Stable semantic directory identity.
- **Filename:** Artifact role plus research slug.

Follow stronger project naming and layout rules. Otherwise:

- use `research-<research-slug>.md` for the canonical research artifact;
- use `source-ledger-<research-slug>.md` only when source detail or claim mapping warrants it;
- name additional files `<concise-file-role>-<concise-research-slug>`; and
- reserve `README.md` for a genuine directory, package, or collection overview.

Do not create empty supporting files or directories.

## Use Researcher Templates

Use [../assets/research-artifact-template.md](../assets/research-artifact-template.md) for saved focused or substantial research when no stronger project template exists.

Every saved research artifact must include a project- or renderer-compatible table of contents. Follow stronger local navigation rules when present.

Use [../assets/source-ledger-template.md](../assets/source-ledger-template.md) when annotations, source-quality assessment, or claim mapping would overload the main artifact. A separate ledger is optional when inline attribution is sufficient. A ledger with more than two source entries must include a project- or renderer-compatible table of contents.

The main research artifact owns the conclusion, evidence synthesis, recommendations, method, limitations, and concise source list. The ledger owns source-level detail and must not repeat the conclusion or recommendations.

## Metadata

Follow project-defined metadata first. When no stronger schema exists, use the adaptable fields in the research artifact template.

Preserve an immutable `id` independently from title, slug, directory, and filename. Do not add `schema_version` without a machine-consumed schema and migration contract that justifies it.

Add optional metadata only when it carries real information. Update `updated` only for meaningful research changes, not formatting alone.

## Check for Continuation

Before creating a new artifact:

1. Inspect only the expected project research location or user-named path.
2. Look for a known immutable ID or a plausible semantic slug.
3. Compare the research question, scope, criteria, expected conclusion, and known identity.
4. Continue the existing artifact only when identity and scope match.
5. Otherwise create a more specific slug without overwriting adjacent research.

Do not rely on title similarity alone. Ask when identity remains ambiguous and the answer changes whether work should continue or start separately.

When continuing research:

1. Preserve the immutable ID.
2. Preserve prior conclusions when new evidence materially changes them; record what changed and why.
3. Update findings, source attribution, confidence, status, and `updated` together when applicable.
4. Preserve unrelated user notes and attachments.
5. Keep workflow feedback in skill usage reports unless it changes research validity.

## Complete or Supersede Research

When completing research:

1. Answer the scoped question directly.
2. Record decision-changing uncertainty and source limitations.
3. Use the project's completion lifecycle when defined; otherwise set `status: completed` and add `completed: YYYY-MM-DD` when the field is useful.
4. Validate links, navigation, metadata, section ownership, and approved paths directly.

Do not automatically move, rename, rewrite, flatten, delete, archive, or supersede research. Do not automatically migrate an existing package when a new project convention or destination becomes available.

Existing `README.md` research packages, source files, directory layouts, and immutable IDs remain valid. Apply the new fallback prospectively. A separately approved import or migration must preserve immutable identity and record lineage when useful.

## Preserve Decision Authority

Research conclusions and recommendations are not adopted decisions. Use `Decision` only when the user or an authorized owner explicitly confirms a choice.

Do not create or update planning, decision, implementation, or task artifacts merely because research recommends an action. Follow the owning workflow and obtain its separate approval.

## Final Storage Check

Before reporting completion, confirm:

1. Persistence was requested or required by the selected shape or active project rules.
2. Destination resolution and write approval followed active authority.
3. The artifact identity, title, scope, status, slug, and filename agree.
4. Required table-of-contents navigation works for the selected renderer.
5. Important claims map to inspected evidence, with indirect or inaccessible evidence labeled.
6. The main artifact and ledger do not duplicate conclusions or recommendations.
7. Existing packages were not migrated or rewritten without approval.
8. Only approved files or vault entries changed.
9. The response names the saved path and any validation limitation.
