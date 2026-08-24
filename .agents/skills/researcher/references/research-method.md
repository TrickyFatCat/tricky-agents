# Research Method

Read this reference for substantial research, disputed claims, multi-source comparison, or decisions where evidence quality can change the recommendation.

Use only the steps needed for the question. Do not turn a small factual check into a research project.

## Define the Question and Scope

Identify:

- The exact question to answer.
- The user's environment, version, platform, region, or product tier when relevant.
- The date or time range that determines currentness.
- The decision criteria when comparing options.
- What is intentionally outside scope.

Restate scope only when it prevents ambiguity or records an important limitation.

## Source Strategy

Prefer sources in this order when applicable:

1. Specifications, standards, official documentation, and current schemas.
2. Release notes, changelogs, security advisories, and maintainer announcements.
3. Source repositories, tests, issue trackers, and maintainer discussions.
4. Peer-reviewed papers or authoritative institutional publications.
5. High-quality secondary analysis.
6. Community reports and anecdotal evidence.

The order is not absolute. A current maintainer issue can be more applicable than stale official documentation. Explain the trade-off when source authority and currentness conflict.

Use secondary sources to discover terminology, primary sources, or competing explanations. Do not promote them to primary evidence without justification.

## Source Access and Verification

A citation is not verified merely because its URL is known.

For sources used as evidence:

- Open or inspect the relevant source when tools and access permit.
- Confirm the source says what the claim attributes to it.
- Check publication or update date.
- Check product, version, platform, region, and account scope.
- Link to the most specific useful page, release, issue, section, or document.

If a source cannot be accessed:

- State that limitation.
- Do not describe its contents as verified.
- Treat snippets, cached text, or third-party summaries as indirect evidence.

When local files are evidence, cite precise paths and distinguish observed content from inferred runtime behavior.

## Claim-to-Source Mapping

Keep important factual claims attributable to specific evidence.

For short answers, place the source link near the claim. For larger research, a compact evidence table can help:

| Claim                               | Evidence                    | Applicability                     | Confidence |
| ----------------------------------- | --------------------------- | --------------------------------- | ---------- |
| Feature X was added in version 2.0. | Official 2.0 release notes. | Applies to version 2.0 and later. | High       |

Do not add a table when two short paragraphs and links are clearer.

A final source list is useful for review, but it does not replace claim-level attribution for important or disputed facts.

## Source Quality Checks

Evaluate:

- Authority: Who produced the source, and are they responsible for the claim?
- Currentness: Does it match the relevant date and version?
- Applicability: Does it match the user's environment and constraints?
- Directness: Does it support the claim directly or require inference?
- Independence: Are corroborating sources genuinely independent?
- Incentives: Is the source marketing, advocacy, vendor guidance, or neutral analysis?

Do not equate source count with evidence strength.

## Conflicting Evidence

When sources disagree:

1. Confirm they discuss the same version, platform, scope, and terminology.
2. Prefer direct, current, and applicable evidence.
3. Check whether one source documents intended behavior while another reports observed behavior.
4. Look for release notes, corrections, maintainer responses, or later updates.
5. Present unresolved disagreement instead of forcing a single conclusion.

Explain which source is more persuasive and why. Do not hide credible contrary evidence that could change the user's decision.

## Confidence Levels

Use confidence labels only when they help communicate uncertainty:

- High: current primary evidence directly supports the claim and matches the relevant environment.
- Medium: evidence is indirect, only partly corroborated, or has a limited applicability gap.
- Low: evidence is stale, conflicting, anecdotal, inaccessible, or substantially inferred.

Confidence applies to a claim or conclusion, not automatically to the entire research response.

Name the reason for medium or low confidence.

## Comparison Research

Before comparing options, identify two to four decision criteria.

Compare each option against the same criteria. Useful criteria include:

- Required capabilities.
- Compatibility.
- Safety and reversibility.
- Maintenance cost.
- Performance.
- Price or licensing.
- Migration effort.

Use `rubber-duck` after evidence gathering when the remaining work is primarily weighing trade-offs or making a preference-based decision.

## Stopping Criteria

Stop researching when:

- Applicable evidence answers the main question.
- Important conflicting claims were checked.
- Decision-changing unknowns are visible.
- Additional sources are unlikely to change the conclusion.

Continue when a missing fact could reverse the recommendation, create a safety risk, or make the answer inapplicable to the user's environment.

Do not keep searching merely to increase the number of citations.

## Final Research Check

Before responding:

1. Confirm important factual claims map to inspected evidence.
2. Recheck versions, dates, product names, and platform scope.
3. Separate facts, inferences, assumptions, and unknowns.
4. State inaccessible sources or unverified runtime behavior.
5. Confirm the recommendation follows from the evidence and visible criteria.
6. Include a concise source list for user review when external sources were used.
