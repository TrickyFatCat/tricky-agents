# Research Method

Read this reference for substantial research, disputed claims, multi-source comparison, or decisions where evidence quality can change the recommendation.

Use only the steps needed for the question. Do not turn a small factual check into a research project.

## Match Rigor to the Research Shape

Scale source breadth, verification depth, persistence, and documentation to consequence, uncertainty, conflict, and the cost of error.

| Research shape                   | Method                                                                                                                                             |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Quick evaluation                 | Inspect the smallest sufficient source set and answer directly. Escalate only when uncertainty or conflict can change the answer.                  |
| Focused research                 | Define a bounded question and visible criteria, inspect applicable evidence, and show material limits.                                             |
| Substantial research             | Define questions and stopping criteria, map important claims, record material methods, and use a source ledger when source detail warrants it.     |
| Systematic or regulated research | Follow the applicable domain protocol, specialist, evidence-selection, documentation, and review requirements. Do not infer compliance from rigor. |

Use a more rigorous shape when a missing fact could reverse the recommendation, create a safety risk, or invalidate applicability. Use a smaller shape when extra process would not change confidence or the user's decision.

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

A citation is not verified merely because its URL is known. Verify two separate questions:

1. **Citation identity:** Does the source exist, and do its title, author, date, version, and location match the citation?
2. **Claim support:** Does the inspected source actually support the attributed claim in the relevant scope?

For sources used as evidence:

- Open or inspect the relevant source when tools and access permit.
- Confirm the source says what the claim attributes to it.
- Check publication or update date.
- Check product, version, platform, region, and account scope.
- Link to the most specific useful page, release, issue, section, or document.
- Label evidence as directly `inspected`, `indirect`, `inaccessible`, `generated lead`, `inferred`, or `unknown` when the distinction affects confidence.

If a source cannot be accessed:

- State that limitation.
- Do not describe its contents as verified.
- Treat snippets, cached text, AI output, or third-party summaries as indirect evidence or generated leads.

When local files are evidence, cite precise paths and distinguish observed content from inferred runtime behavior.

## AI-Assisted Research

Treat AI-generated claims, quotations, summaries, citations, and confidence statements as unverified leads. Verify citation identity separately from whether the inspected source supports the attributed claim.

When AI assistance materially affects substantial research, record:

- provider or tool;
- model or feature when known;
- access date;
- research role, such as discovery, extraction, synthesis, translation, or critique;
- retrieval mode and whether cited sources were directly inspected;
- important limitations; and
- human checks performed.

Do not retain full prompts, private context, credentials, personal data, or sensitive content merely for reproducibility. Do not transmit them to an external AI or research service without explicit destination and payload authorization.

Treat vendor AI documentation as evidence about the vendor's product, not independent evidence of effectiveness. Preserve human responsibility for source selection, interpretation, recommendations, and consequential judgments.

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

## Decision Framing

Use visible criteria, assumptions, realistic alternatives, and decision-changing unknowns when they improve the research question. Do not invent alternatives merely to fill a table.

Use `rubber-duck` before research when the goal, criteria, alternatives, or values are still exploratory. Research supplies external evidence; it does not decide which personal or organizational preference should dominate.

Recommendations remain advisory. Use `Decision` only for a choice the user or an authorized owner explicitly adopts.

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

Use `rubber-duck` before research when the decision frame is still exploratory. Return after evidence gathering when the remaining choice depends on preferences or trade-offs rather than missing facts.

## Stopping Criteria

Stop researching when:

- Applicable evidence answers the main question.
- Important conflicting claims were checked.
- Decision-changing unknowns are visible.
- Additional sources are unlikely to change the conclusion.

Continue when a missing fact could reverse the recommendation, create a safety risk, or make the answer inapplicable to the user's environment.

Do not keep searching merely to increase the number of citations.

## Human-Facing Saved Research

Assign one primary owner to each concept:

- `Conclusion` owns the answer and overall confidence.
- `Findings` or research-question answers own evidence and reasoning.
- `Recommendations` owns actionable deltas, not repeated rationale or adopted decisions.
- `Method and Limitations` owns process, exclusions, conflicts, AI assistance, human verification, and uncertainty.
- The source ledger owns detailed source inventory, source quality, claim mapping, and source-level limitations.

Link instead of restating. Lead with the conclusion, keep sections short, group related lists, show material limitations, and suppress tangents. End with one next action when work remains. Every saved research artifact must include a project- or renderer-compatible table of contents.

Do not duplicate the conclusion or recommendations in the source ledger. Use inline attribution instead of a separate ledger when it remains clear.

## Final Research Check

Before responding or saving:

1. Confirm important factual claims map to inspected evidence.
2. Verify citation identity separately from claim support.
3. Recheck versions, dates, product names, and platform scope.
4. Separate inspected facts, indirect evidence, generated leads, inferences, assumptions, and unknowns.
5. State inaccessible sources or unverified runtime behavior.
6. Confirm the recommendation follows from the evidence and visible criteria without presenting it as an adopted decision.
7. Record material AI assistance, limitations, and human checks when applicable.
8. Check section ownership, navigation, and non-duplication for saved artifacts.
9. Include a concise source list for user review when external sources were used.
