# Audit Workflow

Use this reference for shared formal Audit mechanics. Domain skills supply the domain-specific evidence, criteria, risk model, and recommendations.

## Audit Boundary

Use Audit for formal bounded assessment with explicit scope, evidence, limitations, findings, and judgment. Save an Audit only when the user or active workflow requires persistence.

Do not use Audit for ordinary conversational critique. Use [review.md](review.md) for informal critique, user feedback, lightweight triage, or follow-up assessment.

An Audit does not approve implementation. If a change is justified, recommend the appropriate next decision path without drafting implementation details inside the Audit.

## Audit Content

A formal Audit should include these concepts when relevant:

1. Frontmatter for lifecycle and routing when the storage context supports it.
2. TOC markers for substantial saved Audits when the renderer or project convention supports them.
3. A concise summary that states the current judgment.
4. Scope and exclusions.
5. Evidence and method.
6. General questions before findings when they can change the whole Audit.
7. Findings with traceable evidence, rationale, and recommended action.
8. Good decisions worth preserving.
9. Limitations or untested areas.
10. Judgment and recommendation when not already clear from the summary.

Use [../assets/artifact-audit-template.md](../assets/artifact-audit-template.md) when no stronger domain template exists.

## Audit Findings

For three or more findings, start the `Findings` section with linked navigation:

```markdown
## Findings

1. [Scope boundary](#scope-boundary) — 🔴 High
2. [Approval gate](#approval-gate) — ✅ Pass

### Scope boundary

Priority: 🔴 High

<Observed issue and source.>

**Rationale**

<Why the issue matters.>

**Recommended action**

<Smallest useful change direction.>
```

Keep finding headings short, descriptive, and unnumbered. Ensure headings produce unique anchors in the target renderer.

Use priority for problems:

- `🔴 High`: likely to block success, weaken approval or safety, leave broken references, or make migration incomplete.
- `🟡 Medium`: likely to create unclear responsibility, maintenance problems, validation gaps, or ineffective guidance.
- `🟢 Low`: wording, organization, naming, consistency, or low-risk polish.

Use status for non-problem notes, such as `✅ Pass`, `🟢 Optional polish`, or `⛔ Declined`, when the active domain uses status labels.

Put finding-specific questions inside the relevant finding. Add a separate `General Questions` section before `Findings` only when questions can change the whole Audit judgment.

## Section Ownership

Give each concept one primary location:

- `Audit Summary`: judgment and orientation, not detailed evidence.
- `Scope`: audited targets and exclusions.
- `Evidence`: sources, method, and confidence.
- `General Questions`: whole-Audit questions that affect interpretation or judgment.
- `Findings`: material observations, rationale, finding-specific questions, and recommended action.
- `Good Decisions`: preserved behavior not already covered by pass findings.
- `Limitations`: unavailable evidence, runtime checks, renderer checks, or scope limits.
- `Judgment and Recommendation`: concise decision-shaping recommendation, not detailed implementation steps.

Before finalizing, remove repeated rationale, evidence, recommendations, and authority boundaries. Keep short local restatements only when needed for safety, confidence, scope, or approval meaning.

## Judgment and Recommendation

Use the domain or project judgment vocabulary when it exists. When no stronger vocabulary exists, write a concise bullet list that helps the user decide what to do next:

- **Judgment:** <current assessment of the audited scope>.
- **Recommendation:** <what is better to do or choose next, without implementation detail>.
- **Reason:** <short decision-shaping reason, when needed>.

Keep the recommendation broad and decision-oriented. Avoid implementation detail unless it changes the user's decision. Put the judgment in the summary or in this section, not both.

## Persistence and Lifecycle

Follow this storage precedence for saved Audits:

1. User-provided destination.
2. Project-local rules.
3. `<project>/docs/audit/`.
4. If no project context exists, ask the user where to save the Audit.

Assess directory and file naming before saving:

- Use the user's explicit directory when provided.
- Use local conventions such as `docs/audit/`, `docs/audits/`, or `docs/reports/` when already established.
- Prefer `docs/audit/` as the fallback for formal Audit artifacts when no stronger convention exists.
- Use `audit-<concise-subject>-<yymmdd-hhmm>.md` as the fallback filename when no stronger convention exists.
- Keep filenames stable after review unless the user approves a rename.
- Do not create a new storage convention silently.

When no stronger lifecycle rule exists:

- save formal Audit when durable traceability is required;
- update the same Audit only when review corrections preserve its identity;
- preserve historical artifacts when replacement would change chronology; and
- do not create a proposal retrospectively for work already implemented.

## Final Checks

Before presenting or saving an Audit:

- confirm Audit is the right mode;
- confirm the domain owner supplied or accepted the criteria;
- confirm scope, evidence, exclusions, and limitations are visible;
- confirm general questions appear before findings and finding-specific questions stay inside findings;
- confirm Review, Audit, proposal, approval, and implementation remain separate;
- confirm metadata does not duplicate prose without adding meaning;
- confirm TOC markers and links resolve when present; and
- state renderer, runtime, source, or validation checks that were not performed.
