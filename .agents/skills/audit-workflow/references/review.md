# Review Workflow

Use this reference for shared conversational Review mechanics. Domain skills supply the domain-specific evidence, criteria, risk model, and recommendations.

## Review Boundary

Use Review for conversational critique, user feedback on an artifact, lightweight triage, or follow-up assessment.

Keep Review proportional and normally unsaved. Do not let response length alone turn Review into Audit. Do not silently save, annotate, propose, approve, or implement from a Review.

Use [audit.md](audit.md) when the user or active workflow needs a formal bounded assessment with explicit scope, evidence, limitations, findings, and judgment.

## Default Review Shape

Use only sections that help:

1. `Overview`, only for three or more findings or when orientation prevents confusion.
2. `General Questions`, only when questions affect the whole review; place finding-specific questions inside the relevant finding.
3. `Findings`, with numbered descriptive headings when there are multiple findings.
4. `Good Decisions`, only for specific behavior worth preserving.
5. `Recommendation`, when concise judgment helps the user decide what to do or choose.

For one or two direct comments, omit headings when prose is clearer.

Keep `Recommendation` broad and decision-oriented. Do not turn it into implementation instructions unless the detail changes the user's decision.

## Review Findings

Keep findings concise and useful for the next decision:

```markdown
### <Finding title>

Priority: 🔴 High | 🟡 Medium | 🟢 Low

<Observation or evidence.>

**Rationale**

<Impact, risk, reader friction, maintenance cost, or failure mode.>

**Direction**

<Focused recommendation without approving implementation.>
```

Use status labels for non-problem notes when the active domain uses them:

- `Status: ✅ Accepted`
- `Status: ✅ Pass`
- `Status: 🟢 Optional polish`
- `Status: ⛔ Declined`

Keep priority or status on a separate line. Do not put severity in the heading. Omit `Rationale`, `Direction`, or finding-specific questions when the finding is obvious without them.

## Review Principles

- Present findings in source or application order when that helps the user apply them.
- Use a linked finding list only when it improves navigation.
- Preserve specific good decisions without overpraising weak artifacts.
- Ask questions inside the relevant finding by default.
- Add a separate `General Questions` section only when questions affect the whole review.
- Separate confirmed problems from conditional recommendations and style preferences.
- Keep metadata and prose from duplicating each other in saved Reviews.
- Preserve project-local storage, naming, lifecycle, approval, and validation rules.

## Persistence and Naming

Keep Review in chat by default. When the user or project requests a saved Review, follow this storage precedence:

1. User-provided destination.
2. Project-local rules.
3. `<project>/docs/reviews/`.
4. If no project context exists, ask the user where to save the Review.

Assess directory and file naming before saving:

- Use the user's explicit directory when provided.
- Use local conventions such as `docs/reviews/`, `docs/review/`, or `docs/reports/` when already established.
- Prefer `docs/reviews/` as the fallback for saved Review artifacts when no stronger convention exists.
- Use `review-<concise-subject>-<yymmdd-hhmm>.md` as the fallback filename when no stronger convention exists.
- Keep filenames stable after review unless the user approves a rename.
- Do not create a new storage convention silently.

## Final Checks

Before presenting or saving a substantial Review:

- confirm Review is the right mode;
- confirm the domain owner supplied or accepted the criteria;
- confirm findings are proportional and decision-relevant;
- confirm Review, Audit, proposal, approval, and implementation remain separate;
- confirm links resolve when present; and
- state renderer, runtime, source, or validation checks that were not performed.
