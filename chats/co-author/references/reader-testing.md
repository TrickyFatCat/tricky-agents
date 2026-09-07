# Reader Testing

Use reader testing to determine whether a document works for someone who does not share the authors' conversation context.

It is primarily a comprehension and ambiguity test, not another general editorial review.

## When to Use

Reader testing is especially useful for:
- technical specifications;
- RFCs;
- architecture or design documents;
- decision documents;
- important proposals;
- operational procedures;
- documents defining interfaces or behaviour; and
- documents that will guide implementation by other people or agents.

It is usually unnecessary for:
- small edits;
- short informal documents;
- obvious reference material;
- low-impact internal notes; or
- drafts that are still changing substantially.

## Reader Model

Evaluate the document from the perspective of a reader who has:
- the document;
- normal domain knowledge appropriate to its intended audience; and
- no access to the conversation used to create it.

Do not silently give the reader missing conversation context.

## Core Questions

Choose questions appropriate to the document.

Examples:

- What is this document trying to accomplish?
- What problem is being addressed?
- What has been decided?
- Why was this approach chosen?
- What alternatives were rejected or left open?
- What constraints apply?
- What assumptions does the document make?
- What must happen next?
- Who owns the next action?
- What behaviour or outcome should an implementer produce?
- What remains unresolved?
- Could two reasonable readers interpret any instruction differently?

Add domain-specific questions where they reveal more than generic checks.

## Testing

Where an independent or context-isolated agent is available, provide it only:
- the document;
- the intended audience, when necessary; and
- the test question.

Do not provide the co-authoring conversation.

Where independent execution is unavailable, simulate the same constraint: evaluate only what the document itself supports.

## Evaluate Results

Look for:

### Missing Context

The reader cannot answer an important question without information that exists only outside the document.

### Ambiguity

Multiple reasonable interpretations are possible.

### Hidden Assumptions

The document relies on knowledge that the intended audience may not possess.

### Contradictions

Different sections imply incompatible behaviour, decisions, or requirements.

### Weak Decision Trace

The reader can identify what was chosen but cannot understand important rationale or trade-offs required to use the decision correctly.

### Unclear Action

The reader understands the document but cannot determine what to do next.

## Reporting

Report concrete failures rather than vague criticism.

For each material issue state:
- what the reader could not determine or misunderstood;
- where the gap originates;
- why it matters; and
- which section should be corrected.

Do not rewrite unrelated sections.

## Fix and Retest

Return to the affected section, make the smallest change that resolves the gap, and retest the relevant question.

Do not restart the entire co-authoring workflow for a local reader-testing failure.

## Exit Condition

Reader testing is complete when:
- important questions can be answered from the document;
- no material ambiguity remains;
- assumptions are appropriate for the intended audience;
- no unresolved contradiction is found; and
- the expected action or conclusion is clear.

Reader testing does not prove factual or technical correctness. Validate those separately when required.