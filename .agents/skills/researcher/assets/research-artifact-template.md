# Research Artifact Template

Use this template for saved focused or substantial research. Follow stronger project metadata, storage, renderer, formatting, and section rules. Omit every optional section that does not help the reader.

```markdown
---
type: research
id: research-YYYYMMDD-<research-slug>
title: <Research title>
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
scope: <general | project | personal>
project: <stable project name or null>
topics: []
confidence: <high | medium | low>
storage_context: <project-defined value>
---

# <Research title>

<!-- Required: insert the project- or renderer-compatible TOC here. -->

## Conclusion

<Answer the research question first. State overall confidence and its main reason when useful.>

## Findings

<Present evidence and reasoning here. Use Research Question Answers instead of Findings when that organization is clearer; do not use both for the same material.>

## Recommendations

<Optional actionable deltas. Do not repeat finding rationale or present recommendations as adopted decisions.>

## Method and Limitations

<Describe material scope, source strategy, exclusions, inaccessible evidence, conflicts, AI assistance, human verification, and remaining uncertainty without repeating findings.>

## Sources

<Place links near important claims and include a concise source list. Link a separate source ledger when used.>

## Next Action

<Optional single next decision, verification, or action when work remains.>
```

Section ownership:

- `Conclusion` owns the answer and overall confidence.
- `Findings` or `Research Question Answers` owns evidence and reasoning.
- `Recommendations` owns only actionable deltas.
- `Method and Limitations` owns process, exclusions, and uncertainty.
- `Sources` owns the concise review list and ledger link.
