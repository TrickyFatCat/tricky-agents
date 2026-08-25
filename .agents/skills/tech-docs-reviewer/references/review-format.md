# Documentation Review Format

Read this reference before producing a full documentation review or saving a review. For a very small review, keep the same principles but omit sections that add no value.

## Review Structure

Use this structure unless the user requests another format:

1. Overview.
2. Findings in Document Order.
3. Good Decisions.
4. Questions, only when answers would change the review.
5. Next Step or Decision Check.

For three or more findings, make `Overview` a maximum of three bullets covering:

- The finding count and priority distribution when useful.
- The highest-priority reader concern, referencing its finding number.
- The first recommended action.

Do not summarize every finding or repeat its evidence. For one or two simple findings, use a one-sentence overview or omit the section when it would only duplicate the findings. Omit other empty or unnecessary sections instead of filling the template mechanically.

Within `Findings in Document Order`:

- Follow the document from top to bottom when that makes findings easier to apply.
- For multi-file reviews, group findings by file in a stable order.
- Use priority labels without reordering findings by priority.
- Number each finding heading while keeping a descriptive title.

Example:

```markdown
### 1. Quick Start lacks expected output
```

## Finding Priority

Use `Priority` for problems or improvement opportunities:

- `🔴 High`: likely to block reader success, cause unsafe action, or make the document misleading.
- `🟡 Medium`: likely to confuse readers, slow them down, or leave an important gap.
- `🟢 Low`: polish, consistency, minor readability, or low-risk maintainability improvement.

Use `Status` for non-problem review notes:

- `✅ Accepted`: wording, structure, or behavior is intentional, resolved, or needs no change.
- `⛔ Declined`: the user rejected or overrode a suggestion; do not repeat it unless new evidence changes the review.

A high-priority finding can appear late when it occurs late in the document. Preserve document order and let the label show impact.

## Default Finding Format

Use a numbered heading with a descriptive title and visible sublabels:

```markdown
### 1. Section or finding title

Priority: 🟡 Medium

**What**

Describe the issue.

**Reader impact**

Explain the likely confusion, failure, risk, or unnecessary work.

**Direction**

Give a focused change direction without rewriting the whole document by default.
```

Keep findings short. Omit labels that do not help a simple finding.

Add these optional labels only when needed:

- `**Where**`: the heading, path, table, example, or workflow is not obvious from the finding title.
- `**Evidence**`: a source file, help output, authoritative reference, or observed behavior supports an accuracy finding.
- `**Condition**`: the problem appears only for a specific audience, version, platform, or workflow.

Do not use both `Why it matters` and `Reader impact` when they repeat the same reasoning.

## Accepted and Declined Notes

Keep accepted or no-change findings concise:

```markdown
### 2. Compact reference structure

Status: ✅ Accepted

This fits the requested command-reference mode. No change needed.
```

Keep declined notes equally direct:

```markdown
### 3. Installation tutorial section

Status: ⛔ Declined

The user confirmed this is personal reference material. Do not keep recommending a full installation walkthrough.
```

Do not apply the full finding template unless the note teaches something important.

## Good Decisions

Identify specific decisions that help readers:

- Name the decision.
- Explain its reader benefit.
- Mention how to preserve or repeat the pattern when useful.

Avoid generic praise such as `looks good`.

Do not duplicate accepted findings in both `Findings` and `Good Decisions`. Use the location that best supports the review.

## Questions

Ask questions only when missing context changes the recommendation.

Good questions target:

- Intended reader.
- Document mode.
- Required prior knowledge.
- Shortest safe success path.
- Most important failure mode.

Keep questions few and decision-oriented. Do not disguise criticism as a question.

## Follow-Up Reviews

When reviewing a document again and previous review history is relevant:

1. Read the previous review when the user requests continuity or it is part of the active task context.
2. Verify resolved findings instead of presenting them as new problems.
3. Keep accepted decisions visible only when they prevent repeated recommendations.
4. Do not repeat declined findings unless new evidence changes the analysis.
5. Identify newly discovered issues as new findings.
6. Number findings within the current review; treat each saved review as a snapshot.

Do not silently change the status of previous findings. The user confirms whether a recommendation is accepted, declined, or resolved.

## Next Step

End with one narrow action when implementation is ready:

```markdown
## Next Step

Add expected output under Quick Start.
```

When the user is still deciding, end with a decision prompt:

```markdown
## Decision Check

Should the document remain a compact reference or become a first-time setup guide?
```

Keep the final action or decision small and specific.
