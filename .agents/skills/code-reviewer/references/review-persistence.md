# Code Review Persistence

Read this reference before saving Review, creating or correcting Code Audit, processing review feedback, annotating source, resolving a review thread, or applying recommendations.

## Operation Boundary

Keep these operations separate:

- conversational assessment;
- saving a Review snapshot;
- creating or correcting a Code Audit;
- annotating source;
- adding, resolving, or reopening a review thread;
- accepting or declining a direction;
- preparing a proposal;
- implementing changes;
- committing or pushing.

One operation does not authorize another. State the requested operation when ambiguity could alter persistent state.

## Storage Priority

Use this order:

1. Explicit user destination.
2. Active project review storage, naming, metadata, and history rules.
3. An established project review location and pattern.
4. User clarification before creating a new review store, index, or home-level location.

Do not silently create a project, review directory, index, or global review archive.

## Save Review

Do not save conversational Review automatically.

When saving is requested:

1. Confirm the review subject or task slug when unclear.
2. Determine whether this is a new Review or part of existing history.
3. Resolve the destination and filename pattern.
4. Preserve previous Review artifacts unless replacement of a named file is explicitly approved.
5. Save the rendered Review with only locally required title, target, date, or metadata additions.

Do not force Code Audit fields onto a Review snapshot.

When no local convention exists and the user wants a recommendation, suggest a timestamped file under a subject-specific review directory:

```text
reviews/<task-slug>/<yyyy-mm-dd-hhmmss>-code-review-<review-slug>.md
```

Use `reviews/<task-slug>/README.md` only as an optional collection index, not the default Review artifact.

## Create Code Audit

Resolve the destination and any required persistence approval before formal work.

Follow project-local metadata and terminology first. Otherwise adapt [../assets/code-audit-template.md](../assets/code-audit-template.md).

Record target snapshot, scope, exclusions, source material, evidence origin, methods, checks actually performed, specialists, tools, confidence, untested areas, limitations, outcome, and next action when relevant.

Preserve prior formal assessments. Correct the same Audit only when the active workflow preserves its identity and chronology. Otherwise create a related pass. Add `updated` or `reviewed` only when the storage convention permits it.

A completed Code Audit records assessment state. It does not grant implementation, merge, release, certification, or legal approval.

## Review Feedback and Channels

Follow project-defined review channels, markers, status meanings, and platform behavior.

`REVIEW` is a Helper-project saved-artifact marker, not a global requirement. `TODO` and `FIXME` are source-work evidence unless active project rules say otherwise.

Treat clear conversational user feedback as review input even without a marker. Ask when the requested effect or authority is ambiguous.

Inspect pull-request comments, inline threads, suggestions, issue comments, approvals, change requests, resolution, and reopening only when they are in scope. Separate user wording from reviewer interpretation.

Classify feedback only when useful:

- correction;
- accepted direction;
- declined direction;
- question;
- new finding; or
- unrelated note.

A suggestion does not authorize applying it. Approval, resolution, or reopening does not authorize implementation or silent assessment-history changes.

## Source Annotation

Annotating reviewed source is a file change and requires applicable approval.

Before annotation:

1. Confirm the exact files and marker or platform syntax.
2. Preserve user wording separately from reviewer interpretation when needed.
3. Avoid converting source `TODO` or `FIXME` markers into review-lifecycle markers.
4. Do not embed sensitive evidence, credentials, or unrelated local paths.
5. Validate that annotations do not alter executable behavior accidentally.

Saving a Review does not authorize source annotation. Source annotation does not authorize implementation.

## Multiple Passes and History

For follow-up work:

- link or identify the prior Review or Audit when the active format supports it;
- verify resolved findings rather than restating them as new;
- preserve accepted and declined directions when they prevent repetition;
- identify newly discovered evidence explicitly;
- avoid overwriting immutable history; and
- report when the storage context has no Git or revision history.

Do not mark a finding resolved solely because a thread closed, code changed, or a tool stopped reporting it. Reinspect the relevant behavior.

## Apply Recommendations

Assessment remains separate from implementation.

When the user requests changes after Review or Code Audit:

1. Confirm accepted findings or the implementation scope when unclear.
2. State that work is switching from assessment to implementation.
3. Load the applicable language, project, documentation, safety, and repository workflows.
4. Apply only authorized changes.
5. Validate changed behavior and report unresolved findings.

Do not infer implementation authority from saving findings, accepting a direction, annotating source, resolving a thread, or approving a review outcome.

## Validation

After persistence work:

- re-read every changed artifact;
- confirm destination, metadata, target, mode, status, and outcome agree;
- resolve local links;
- check formatting, trailing whitespace, conflict markers, and unexpected sensitive paths;
- confirm prior history was preserved as required;
- distinguish direct inspection from Git-backed validation; and
- report operations not performed or behavior not retested.
