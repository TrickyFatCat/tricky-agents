# Artifact Audit Template

Use this adaptable template for a formal saved Audit when no stronger domain or project template exists. Omit irrelevant sections. Preserve domain-specific criteria, headings, metadata, and lifecycle rules when they are stronger.

```markdown
---
type: audit
status: draft # draft | reviewed | final
created: YYYY-MM-DD
updated: YYYY-MM-DD
audit_scope: <bounded artifact, workflow, or resource set>
---

# <Audit Title>

<!--toc:start-->

- [Audit Summary](#audit-summary)
- [Scope](#scope)
- [Evidence](#evidence)
- [General Questions](#general-questions)
- [Findings](#findings)
- [Good Decisions](#good-decisions)
- [Limitations](#limitations)
- [Judgment and Recommendation](#judgment-and-recommendation)

<!--toc:end-->

## Audit Summary

<Concise judgment. If no material concerns were found, say so directly. If a proposal is needed, say that exact scope belongs in a separate proposal.>

## Scope

- Audited:
- Excluded:

## Evidence

- Sources:
- Method:
- Confidence:

## General Questions

- <Whole-Audit question whose answer can change the judgment or recommendation>?

## Findings

For three or more findings, add linked navigation. Omit navigation when one or two findings are easy to scan.

1. [<Finding title>](#finding-title) — 🔴 High | 🟡 Medium | 🟢 Low | ✅ Pass

### <Finding title>

Priority: 🔴 High

<Observed issue and source.>

**Question**

<Finding-specific question, when the answer can change this finding.>

**Rationale**

<Impact, risk, or maintenance cost.>

**Recommended action**

<Smallest useful direction without approving implementation.>

### <Pass or preserved behavior>

Status: ✅ Pass

<Concise reason this behavior is correct and should remain unchanged.>

## Good Decisions

- <Specific behavior worth preserving> — <why it matters>.

## Limitations

- <Evidence, runtime, renderer, integration, or scope limit.>

## Judgment and Recommendation

- **Judgment:** <current assessment of the audited scope>.
- **Recommendation:** <what is better to do or choose next, without implementation detail>.
- **Reason:** <short decision-shaping reason, when needed>.
```

## Final Pass

Before saving:

- assign each fact to one primary section;
- remove repeated evidence, rationale, and recommendations;
- keep finding-specific questions inside findings;
- keep general questions before findings;
- keep short local restatements only when needed for safety, confidence, scope, or approval meaning;
- confirm Review, Audit, proposal, approval, and implementation remain separate; and
- confirm links and TOC entries resolve in the target context.
