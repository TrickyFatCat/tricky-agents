# Code Review and Audit Format

Read this reference when producing Review, Code Audit, or follow-up findings.

## Mode Boundary

Use **Review** for proportional conversational assessment. Save it only when requested.

Use **Code Audit** for explicit bounded formal assessment with resolved target, snapshot, scope, evidence, exclusions, limitations, outcome, and destination.

Response length alone does not change modes. Ask when “detailed review” could mean either expanded Review or formal Code Audit.

## Shared Rules

- Report the highest-value findings instead of exhaustive nitpicks unless formal scope requires broader coverage.
- Keep findings in source or application order when that helps correction; keep priority visible.
- Group multi-file findings by file in a stable order.
- Tie findings to exact locations when available.
- Separate observed evidence, impact, triggering conditions, and recommendations when conflating them could change the decision.
- Preserve specific good decisions that prevent regression.
- Ask only questions that can change a finding, confidence, scope, or next action.
- Do not treat local priority as vulnerability severity, legal risk, merge state, or a universal standard.

## Review Lenses

Apply only relevant lenses:

- correctness, contracts, control flow, state, and error handling;
- empty, null, missing, malformed, duplicate, boundary, and off-by-one inputs;
- paths, permissions, symlinks, environment, configuration precedence, and platform differences;
- network failure, timeout, partial response, retry, and cleanup behavior;
- processes, resources, concurrency, failure recovery, and repeated work;
- large inputs, slow paths, memory growth, data structures, and algorithms;
- security, secrets, injection, unsafe operations, and destructive effects;
- architecture, API usability, compatibility, generated code, and maintenance boundaries;
- tests, observability, diagnostics, suppressions, comments, and documentation claims; and
- language and project idioms supplied by applicable specialists.

Prioritize plausible conditions over mechanical checklist coverage.

## Priority and Status

Use priority for problems and improvement opportunities:

- `🔴 High`: likely correctness bug, data loss, security issue, broken behavior, or severe maintenance risk.
- `🟡 Medium`: likely edge case, confusing behavior, maintainability problem, missing validation, or important design concern.
- `🟢 Low`: style, naming, readability, idiom, or low-risk cleanup.

Use status for non-problem review notes:

- `✅ Accepted`: behavior is intentional, a finding is resolved, or no change is needed.
- `⛔ Declined`: the user rejected or overrode a suggestion; do not repeat it without new evidence.

Do not silently change a previous status without user confirmation or new evidence.

## Review Format

Scale the format to the result.

### Orientation

For three or more findings, use no more than three orientation bullets:

- finding count or distribution when useful;
- highest-priority concern; and
- first recommended action.

Use one sentence or omit orientation for one or two clear findings.

### Findings in Source Order

Use numbered descriptive headings so follow-up discussion can refer to each finding:

```markdown
## Findings in Source Order

### 1. Missing empty-input handling

Priority: 🔴 High

**Evidence**

The first index access occurs before the list length is checked.

**Why it matters**

An empty input raises an exception before the documented fallback runs.

**When this appears**

The caller supplies an empty list.

**Look into**

Guard clauses and empty collection contracts.

**Direction**

Handle the empty case before indexing.
```

Use only labels that help. Keep simple findings short. Short illustrative snippets should clarify rather than replace the user's solution.

For accepted or declined notes, use a compact form:

```markdown
### 2. Existing fallback behavior

Status: ✅ Accepted

The fallback is intentional for this workflow. No change needed.
```

### Good Decisions

Name the decision, explain why it helps, and state the habit worth preserving. Omit generic praise.

### Questions

Ask two to four probing questions only when they expose an assumption or can change the assessment. Do not disguise criticism as a question.

### Final Action

End with one narrow `Next Step` or `Decision Check` when useful.

A Review may be expanded without becoming Code Audit. State sampled files, excluded areas, and untested behavior when partial coverage could look comprehensive.

## Code Audit Format

Use [../assets/code-audit-template.md](../assets/code-audit-template.md) unless active project rules define another contract.

Begin with an Audit Summary of no more than five short bullets. Include purpose, target, scope, main concern, preserved behavior, and next action only when useful.

Record:

- purpose, audience, and questions;
- target and version, commit, or other snapshot;
- scope and explicit exclusions;
- source material and contextual evidence;
- instructions, specialists, tools, and methods used;
- checks actually performed;
- supplied evidence that was not reproduced;
- unavailable evidence and untested areas;
- findings, good decisions, limitations, outcome, and next action; and
- external sources when used.

### Section Ownership and Final Pass

Give each concept one primary location:

- `Audit Summary`: orientation, outcome, highest-value concern, preserved behavior, and next action without detailed evidence.
- `Scope and Evidence`: purpose, target, snapshot, included and excluded areas, evidence origins, methods, checks, and coverage limits.
- `Findings`: material evidence, impact, triggering conditions, recommendation, confidence, location, and finding state.
- `Good Decisions`: preserved behavior not already recorded as an accepted finding.
- `Questions`: only unknowns whose answers can change the Audit.
- `Untested Areas`: behavior or environments not tested; keep evidence unavailability in `Scope and Evidence`.
- `Audit Outcome`: final state, confidence, assurance boundary, and next action without repeating finding evidence.

Before finalizing:

1. Remove repeated scope, evidence, rationale, outcomes, and next actions across sections.
2. Link accepted external context instead of restating it.
3. Omit optional sections that do not help the judgment.
4. Preserve short local context when needed for safety, evidence origin, confidence, scope, or authority.

Do not use line, heading, sentence, or paragraph counts as pass/fail limits.

### Formal Findings

Use one parent `Findings` section. For three or more findings, begin with numbered linked navigation:

```markdown
## Findings

1. [Unchecked destructive path](#unchecked-destructive-path) — 🔴 High
2. [Missing boundary tests](#missing-boundary-tests) — 🟡 Medium
3. [Clear resource cleanup](#clear-resource-cleanup) — ✅ Accepted

### Unchecked destructive path

Priority: 🔴 High
```

Keep detailed headings descriptive and unnumbered. Include location, priority or status, evidence, impact, recommendation, confidence, and finding state when relevant.

### Audit Outcomes

Use one local outcome without implying approval outside the assessed scope:

- `no material findings`: no material finding at the recorded scope and confidence;
- `changes recommended`: one or more findings warrant correction or a decision;
- `blocked on evidence`: missing or unsafe-to-obtain evidence prevents a reliable outcome; or
- `defer`: preserve findings until a named condition is met.

`No material findings` is not a guarantee of correctness, security, legal compliance, exhaustive coverage, or merge readiness.

## Follow-Up Assessment

When reviewing prior findings:

1. Preserve original user wording and status when it matters.
2. Verify resolved findings instead of presenting them as new.
3. Keep accepted and declined directions visible when they prevent repetition.
4. Identify genuinely new evidence as a new or revised finding.
5. Do not treat correction, saving, annotation, thread resolution, proposal, or implementation as the same operation.

Read [review-persistence.md](review-persistence.md) before changing a saved assessment or processing review-channel feedback.
