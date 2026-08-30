# Review Persistence

Read this reference before saving a Quick Review or Documentation Audit, inserting review feedback into a source document, retaining Review Notes, or applying accepted recommendations.

Project-local storage, metadata, naming, renderer, approval, formatter, and validation rules take precedence.

## Operation Boundary

Treat these as distinct operations:

1. Print a Quick Review in chat.
2. Save an assessment artifact.
3. Insert actionable `REVIEW` markers into a source document.
4. Retain a final `Review Notes` section in a source document.
5. Apply accepted recommendations to documentation.

A request or approval for one operation does not authorize another. A user request to save or edit authorizes the named destination and effect; resolve any missing destination, overwrite, retention, or scope decision before writing.

## Shared Saved Properties

Use project-local metadata syntax and fields first. When none exists, use these shared concepts:

| Property                | Quick Review               | Documentation Audit                           |
| ----------------------- | -------------------------- | --------------------------------------------- |
| `type`                  | `documentation-assessment` | `documentation-assessment`                    |
| `mode`                  | `quick-review`             | `audit`                                       |
| `status`                | `snapshot`                 | `complete`                                    |
| `created`               | Required                   | Required                                      |
| `target`                | Required                   | Required; may be a list                       |
| `focus`                 | Optional                   | Optional                                      |
| `updated` or `reviewed` | Omit for immutable output  | Add when the same Audit is corrected/reviewed |
| `outcome`               | Omit                       | Required                                      |

Keep sources and exclusions in the Audit body unless local metadata requires them. Omit empty properties.

Fallback Quick Review metadata:

```yaml
---
type: documentation-assessment
mode: quick-review
status: snapshot
created: YYYY-MM-DD
target: path/to/document.md
---
```

Fallback Documentation Audit metadata:

```yaml
---
type: documentation-assessment
mode: audit
status: complete
created: YYYY-MM-DD
target:
  - path/to/document.md
outcome: revision-recommended
---
```

## Storage Priority

Resolve persistent storage in this order:

1. Explicit user destination.
2. Active project review rules.
3. Established project review location and naming.
4. A proposed project-local `reviews/` location when a project exists without a convention.
5. User choice when no project or durable destination exists.

For the final case, offer only relevant options: beside the source, a user-named directory, or chat without persistence. Do not silently create a project, review directory, index, or home-level review store.

Inspect whether the destination exists, whether the file would overwrite history, and whether local instructions require a timestamp or immutable artifact. Ask before overwriting an existing assessment unless an active lifecycle explicitly updates the same artifact.

## Save Quick Review

A Quick Review stays in chat unless the user asks to save it.

When saving:

1. Preserve the chat response as the assessment snapshot.
2. Add only the title, target, date, or metadata required by the destination.
3. Do not silently expand, rewrite, or reclassify it as a Documentation Audit.
4. Follow the storage and naming rules in effect at the destination.
5. Format and validate the saved artifact.

## Save Documentation Audit

A Documentation Audit is always saved.

Before formal assessment:

1. Resolve and inspect the destination.
2. Confirm project metadata, naming, history, renderer, and formatting rules.
3. Record scope, target paths, sources, and exclusions.
4. Use [../assets/documentation-audit-template.md](../assets/documentation-audit-template.md).

If no durable destination can be agreed, stop the Audit and offer an expanded Quick Review. Do not produce a formal artifact in chat and call it saved.

When correcting or reviewing the same Audit, update it only when the active lifecycle preserves the artifact's identity. Otherwise create a related pass without overwriting history.

## Add Feedback to the Document

Use Writer-owned editorial-marker behavior from [../../tech-docs-writer/references/markdown-conventions.md](../../tech-docs-writer/references/markdown-conventions.md).

For temporary actionable feedback:

1. Prepare the exact `REVIEW` marker text and insertion location.
2. Explain that the marker changes the source document but does not apply the recommendation.
3. Obtain approval for the insertion.
4. Insert only approved markers.
5. Preserve unresolved markers and remove resolved markers only when their request has been addressed.

Example:

```markdown
> REVIEW
> Add one representative success output so readers can verify this command.
```

Use a final `Review Notes` section only when the user intends the review to remain in the source document. Agree on its location, content, and retention before adding it. Do not use Review Notes as a hidden substitute for a saved assessment artifact.

## Apply Recommendations

An accepted finding does not by itself authorize a documentation rewrite.

When the user asks to apply findings:

1. Identify the accepted findings and exact target files.
2. Hand substantive drafting, rewriting, or restructuring to `tech-docs-writer`.
3. Preserve Reviewer findings as assessment evidence rather than silently replacing them with implementation claims.
4. Validate the edited documentation under project-local Writer rules.
5. Update assessment status only when the active lifecycle and user decision authorize it.

Use Task Manager when accepted recommendations require persistent multi-file migration planning.

## Naming and Multiple Passes

Use project-local naming first.

When no convention exists, use role + action + subject:

```text
review-assess-nushell-readme.md
audit-assess-nushell-readme.md
```

Use two-digit suffixes for related passes by default:

```text
review-assess-nushell-readme-01.md
review-assess-nushell-readme-02.md
```

Use timestamp prefixes when local rules, concurrent agents, or immutable chronology require them:

```text
260830-1344-review-assess-nushell-readme.md
```

Do not combine a sequence number and timestamp by default. Reserve `README.md` for a real review collection overview, not an individual assessment.

Treat saved Reviews and Audits as snapshots unless the active project defines an update lifecycle. Do not silently overwrite, renumber, or rename historical artifacts.

## Validation

After a persistent operation:

- Re-read every changed artifact.
- Confirm target, mode, status, dates, and Audit outcome are internally consistent.
- Confirm paths, names, metadata, links, renderer syntax, and formatting follow project rules.
- Confirm the saved Quick Review still matches the chat snapshot except for required wrapper material.
- Confirm a Documentation Audit records scope, sources, exclusions, outcome, and untested areas.
- Confirm source-document annotations contain only approved feedback and are not presented as applied changes.
- Report files changed, any retained markers, anything not tested, and whether Git rollback is available.
