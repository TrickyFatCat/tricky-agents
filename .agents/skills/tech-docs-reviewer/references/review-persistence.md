# Documentation Assessment Persistence

Use this reference for documentation-assessment metadata, saved-operation boundaries, annotations, history, and Writer handoffs.

Use [`audit-workflow/references/review.md`](../../audit-workflow/references/review.md) for generic saved Review persistence and [`audit-workflow/references/audit.md`](../../audit-workflow/references/audit.md) for generic Audit persistence and lifecycle. Project-local storage, metadata, naming, renderer, approval, formatter, and validation rules take precedence.

## Operation Boundary

Treat these as distinct operations:

1. Print a Quick Review in chat.
2. Save an assessment artifact.
3. Insert actionable `REVIEW` markers into a source document.
4. Retain a final `Review Notes` section in a source document.
5. Apply accepted recommendations to documentation.

Approval for one operation does not authorize another. Resolve the destination, overwrite behavior, retention, and exact source-document effect before writing.

## Documentation Assessment Metadata

Use project-local metadata first. When none exists, adapt shared persistence with these domain concepts:

| Property                | Quick Review               | Documentation Audit                           |
| ----------------------- | -------------------------- | --------------------------------------------- |
| `type`                  | `documentation-assessment` | `documentation-assessment`                    |
| `mode`                  | `quick-review`             | `audit`                                       |
| `status`                | `snapshot`                 | `complete`                                    |
| `created`               | Required                   | Required                                      |
| `target`                | Required                   | Required; may be a list                       |
| `focus`                 | Optional                   | Optional                                      |
| `updated` or `reviewed` | Omit for immutable output  | Add when the same Audit is corrected/reviewed |
| `outcome`               | Omit                       | Use when the project or workflow requires it  |

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

Keep sources and exclusions in the Audit body unless local metadata requires them. Omit empty properties.

## Saving Assessments

A Quick Review stays in chat unless the user asks to save it. Preserve the conversational assessment as a snapshot and do not silently expand or reclassify it as a Documentation Audit.

A Documentation Audit is always saved. Before formal assessment:

1. Resolve and inspect the destination through the shared Audit persistence workflow.
2. Confirm project metadata, naming, history, renderer, and formatting rules.
3. Record scope, target paths, sources, and exclusions.
4. Adapt the shared Audit template with the domain guidance in [review-format.md](review-format.md).

If no durable destination can be agreed, stop the Audit and offer an expanded Quick Review. Do not create a formal artifact in chat and call it saved.

Treat saved Reviews and Audits as snapshots unless the active project defines an update lifecycle. Do not silently overwrite, renumber, rename, or rewrite historical assessments. Use shared fallback naming only when no user or project convention exists.

## Add Feedback to the Document

Use Writer-owned editorial-marker behavior from [Markdown Conventions](../../tech-docs-writer/references/markdown-conventions.md).

For temporary actionable feedback:

1. Prepare the exact `REVIEW` marker text and insertion location.
2. Explain that the marker changes the source document but does not apply the recommendation.
3. Obtain approval for the insertion.
4. Insert only approved markers.
5. Preserve unresolved markers and remove resolved markers only when addressed.

Use a final `Review Notes` section only when the user intends the review to remain in the source document. Agree on location, content, and retention before adding it. Do not use Review Notes as a hidden substitute for a saved assessment artifact.

## Apply Recommendations

An accepted finding does not authorize a documentation rewrite.

When the user asks to apply findings:

1. Identify the accepted findings and exact target files.
2. Hand substantive drafting, rewriting, or restructuring to `tech-docs-writer`.
3. Preserve Reviewer findings as assessment evidence rather than replacing them with implementation claims.
4. Validate edited documentation under project-local Writer rules.
5. Update assessment state only when the active lifecycle and user decision authorize it.

Use Task Manager when accepted recommendations require persistent multi-file migration planning.

## Multiple Passes

When correcting or reviewing the same Audit, update it only when the active lifecycle preserves its identity. Otherwise create a related snapshot without overwriting history.

For follow-up assessment, preserve enough relationship context to distinguish resolved, declined, retained, and new findings. Do not require one universal sequence or timestamp convention when the project already supplies naming.

## Validation

After a persistent operation:

- Re-read every changed artifact.
- Confirm target, mode, status, dates, and domain outcome are internally consistent.
- Confirm paths, names, metadata, links, renderer syntax, and formatting follow project and shared rules.
- Confirm a saved Quick Review still matches the chat snapshot except for required wrapper material.
- Confirm a Documentation Audit records scope, sources, exclusions, evidence confidence, and untested areas.
- Confirm source-document annotations contain only approved feedback and are not presented as applied changes.
- Report retained markers, anything not tested, and whether Git rollback is available.
