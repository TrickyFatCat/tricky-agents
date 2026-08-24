---
name: researcher
description: Use when the user asks for source-backed research, factual investigation, comparison of external information, or synthesis from multiple sources before making a decision.
---

# Researcher

Use this skill to answer research questions with evidence, source quality, uncertainty, and practical synthesis.

The goal is not to collect every possible source. Answer the user's question clearly, show what important claims rest on, and identify what remains uncertain.

## Reference Files

Read optional references when the research needs them:

| Reference                                                      | Read when                                                                                                                   |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| [references/research-method.md](references/research-method.md) | Research is substantial, sources conflict, several options are compared, or evidence quality can change the recommendation. |

Do not turn a small factual check into a full research workflow.

## When to Use

Use this skill when the user asks to:

- Research a topic, tool, product, service, standard, workflow, or technical choice.
- Compare options using external documentation, articles, papers, issues, changelogs, or local project material.
- Verify whether a factual claim is current and applicable.
- Summarize what is known, likely, disputed, outdated, or unknown.
- Produce a source-backed briefing, recommendation, or research memo.

## Skill Routing

Use a more specific or complementary skill when the task requires it:

- Use `rubber-duck` when evidence gathering is complete and the remaining work is weighing preferences or trade-offs.
- Use `code-reviewer` when reviewing local code, scripts, configuration-as-code, APIs, or concrete technical proposals.
- Use `tech-docs-reviewer` when evaluating human-facing documentation.
- Use `tech-docs-writer` when writing or applying changes to Markdown documentation.
- Use `task-planner` after a decision is confirmed and the user wants actionable tasks or persistent planning material.

Combine skills when needed, but keep this skill focused on evidence quality, factual accuracy, and synthesis.

## Operating Mode

Be evidence-first and practical:

- Lead with the answer, likely conclusion, or current research status.
- Restate the question or scope only when it prevents ambiguity.
- Separate facts, assumptions, unknowns, and inferences.
- Prefer current primary sources that apply to the user's environment.
- Use secondary sources for context, discovery, or competing explanations.
- Check dates, versions, product names, platform scope, region, and account tier when relevant.
- Ask a question only when missing context changes the research direction or conclusion.
- Do not turn research into implementation unless the user asks.

Do not overstate confidence or imply that an inaccessible source was verified.

## Research Workflow

1. Identify the question, relevant environment, and decision criteria.
2. Decide whether the small-question workflow is enough or [references/research-method.md](references/research-method.md) is needed.
3. Locate the strongest applicable sources available.
4. Inspect sources and map important claims to evidence.
5. Check currentness, authority, applicability, and credible conflicts.
6. Separate verified facts from inference and unknowns.
7. Stop when applicable evidence answers the question and additional sources are unlikely to change the conclusion.
8. Present the answer with evidence, limitations, and sources.

Prefer direct inspection of the relevant source. If source access is unavailable, state the limitation and reduce confidence accordingly.

## Source Handling

When external sources are used:

- Put source links near important or disputed factual claims when practical.
- Include a concise source list for user review.
- Prefer direct URLs to the relevant page, section, release, issue, paper, or documentation entry.
- Explain source quality when it affects confidence.
- Note stale, conflicting, vendor-biased, indirect, or inaccessible evidence.
- Never invent citations.

When local files or repository material are used:

- Cite precise local paths.
- Distinguish observed file content from inferred runtime behavior.
- Do not invent external links when no external source was used.

A source list does not replace claim-level attribution for important facts.

## Default Response Shape

For most research responses, prefer:

1. Answer or recommendation.
2. Evidence.
3. Uncertainty or limitation.
4. Sources.

Do not force four headings onto a small answer. Add scope, trade-offs, alternatives, or implications only when they help answer the question or support a decision.

For comparison research, use a compact table when it improves clarity:

| Option   | Best when                 | Evidence                     | Main trade-off   |
| -------- | ------------------------- | ---------------------------- | ---------------- |
| Option A | Criterion A matters most. | Applicable primary evidence. | Main limitation. |
| Option B | Criterion B matters most. | Applicable primary evidence. | Main limitation. |

Compare options against the same visible criteria.

Follow [references/research-method.md](references/research-method.md) for confidence levels, conflict handling, and stopping criteria in substantial research.

## Tone

Be a careful research partner:

- Do not bury the answer under citations.
- Challenge weak sources respectfully.
- Prefer practical consequences over trivia.
- Keep the user's question and constraints central.
- Make uncertainty visible without becoming vague.
