---
name: code-comments
description: Use this skill when the user asks to write, rewrite, review, or remove code comments or documentation comments. Apply it to line comments, block comments, public APIs, libraries, enums, functions, classes, properties, warnings, workarounds, invariants, and labelled comments. Do not use it for comments written while implementing, fixing, or refactoring code. Optimise comments for human readers, including people who use English as an additional language.
---

# Code Comments

Write comments for humans. Make them concise, clear, accurate, and useful.

## Invariant

Preserve all non-comment code exactly, including identifiers, literals, ordering, behaviour, and formatting. Do not refactor, rename, reformat, optimise, or correct unrelated code. If adding a comment requires moving or changing code, explain the conflict instead of changing the code.

## Before commenting

1. Check the user's instructions and authoritative project guidance, including `AGENTS.md`, contribution guides, style guides, documentation standards, and relevant linter or formatter rules.
2. Follow the host's instruction hierarchy. This skill does not change it. Within it, follow this precedence:
   1. user instructions;
   2. mandatory project, legal, and tool requirements;
   3. project preferences and established conventions;
   4. this skill's defaults;
   5. consistent nearby comments as fallback evidence.
3. If it is unclear whether a requirement is mandatory or applies, and no user instruction conflicts with it, ask for clarification and leave the affected content unchanged. If a user instruction conflicts with a requirement that is or may be mandatory, name the requirement, its source, and the consequence of breaking it. Ask once per requirement per request whether to proceed. Leave the affected content unchanged until the user answers. A yes means break the requirement for this request. Any other answer, including a delegated one such as "you decide", means follow the requirement.

Do not ask about other missing context before the work. This includes whether the project has commenting rules, whether the code is internal or shareable, and which ecosystem convention to follow. Do the work with the fallback below. After the work, state in one line what was assumed. Do not repeat a question the user has already answered.

Do not guess whether code is shareable. When the user has not said, treat it as unknown.

When context is unknown:

- do not block the work;
- apply known mandatory requirements and this skill's defaults;
- name the unknown context in the assumption line;
- use concise general comments;
- do not invent public API guarantees, including ownership, lifetime, thread safety, compatibility, error behaviour, or performance guarantees;
- flag declarations whose documentation depth depends on whether the code is shareable.

## Project and ecosystem conventions

Use nearby comments as a fallback only when no authoritative project commenting rules are available. Follow a nearby convention only when several relevant comments use it consistently within the same component, module, or directory. Prefer examples for the same code type and audience, such as public APIs, internal implementation, tests, or generated code.

Do not follow nearby comments when the sample is too small, examples are inconsistent, comments appear outdated or inaccurate, audiences are mixed, or the convention conflicts with mandatory requirements. Nearby comments never decide sentence layout. The rules in "Write the comment" do.

Do not search unrelated repository areas merely to manufacture a convention. Name the source of guidance in the assumption line. Do not present general ecosystem practice as a project requirement.

### Documentation templates

Documentation comments on declarations follow a template. Find it in this order:

1. If project rules name a path for comment templates, use a matching template from that path.
2. Otherwise use `templates/<language>-<format>.md` from this skill, or `templates/<language>.md` for a language with one format.
3. Otherwise use the language's documented convention.

When a language has several formats, choose by project rules first, then by a consistent nearby convention as defined above. Name the template or convention in the assumption line.

A template holds syntax only. When filling it:

- fill only the parts that apply;
- add no filler;
- follow every rule in "Write the comment".

## Protect special comments

Before changing or removing an existing comment, check whether it has legal, tooling, generation, attribution, or operational significance.

Protected comments include:

- copyright, licence, SPDX, and attribution notices;
- generated-code and "do not edit" markers;
- compiler and build directives;
- formatter, linter, static-analysis, and coverage directives;
- documentation-generator and reflection directives;
- suppression and deliberate-fallthrough markers;
- comments required by code-generation or extraction tools.

Preserve protected comments exactly, including their text, capitalisation, punctuation, spacing, and placement, unless the user explicitly requests a change. A requested change that breaks the governing format or a legal requirement follows the conflict rule in step 3 of "Before commenting". Preserve their relationship to the code they affect, including position, order, adjacency, and scope. Do not insert content between a directive and its target.

If unsure whether a comment is protected, ask the user before changing or removing it. Leave it unchanged until the user answers.

Treat docstrings, documentation attributes, and documentation macros as both documentation and code when they can affect runtime behaviour or tooling. Preserve their syntax, placement, indentation, tags, and required structure. Before removing one, check whether runtime introspection, generated documentation, reflection, localisation, tests, or other tools use it.

## Decide whether to comment

Add a comment only when it communicates useful information that the code does not express clearly.

Useful information includes:

- intent or rationale;
- externally observable behaviour;
- a non-obvious constraint, invariant, or precondition;
- units, ranges, ownership, lifetime, or thread safety;
- an important side effect, failure case, or performance characteristic;
- why unusual code or a workaround is necessary;
- an actionable TODO or FIXME;
- an informative label such as NOTE when it helps classify important context.

Do not add comments that translate obvious code into English, repeat names or signatures, narrate implementation steps, speculate about intent, preserve irrelevant details, or add prose without helping a reader use, change, or verify the code.

If no useful information needs stating, write no comment.

## Write the comment

- Use plain English, familiar words, and direct sentence structure.
- Imperative mood is fine. A comment may leave out a subject such as "This" when the subject is the code the comment sits on.
- State the important fact first.
- Put one fact in each sentence.
- Put one sentence on each line. If a sentence is too long for one line, split it into two sentences. Keep every fact.
- Do not join clauses with a colon, a semicolon, or a dash.
- A comment may join one fact to its reason with "because" or "so" once. Give every other reason its own sentence.
- Most comments need one sentence. Write more sentences when the facts need them.
- Describe behaviour at the highest useful level of abstraction.
- Make related comments parallel in terms, detail, and abstraction. Sentence layout always follows the rules above, whatever nearby comments do.
- Use identifiers only when they improve precision.
- Avoid introductions such as "This function is used to" or "The following code".
- Avoid idioms, compressed grammar, and unexplained technical terms.
- Use established project terminology when required, but do not introduce technical vocabulary only to reduce word count.
- If clearer wording needs more words, prefer clarity over brevity.
- If intent cannot be established from the available context, do not invent it.

Prefer the shortest wording that is easy for the intended reader to understand and preserves the necessary meaning. Never shorten a comment by hiding, weakening, generalising, or removing information needed to understand the code, use it correctly, change it safely, or maintain its contract.

Preserve important actions, limits, reasons, conditions, risks, constraints, invariants, exceptions, and contracts. Remove incidental implementation detail that readers do not need.

When the user asks for shorter comments, cut incidental words in the requested comments. If shortening a comment would remove a needed fact, keep the fact and name it in the report. The user decides whether it goes.

## Internal code

Optimise for quick scanning and local understanding. Prefer a short statement of intent, reason, or non-obvious behaviour. Keep implementation detail in the code unless it explains a necessary constraint or surprising choice.

## Shareable code and public APIs

Shareable means used outside this project.

Write from the consumer's perspective. Keep documentation as short as the complete contract allows.

Document applicable parts of the contract: purpose and observable behaviour; parameter meaning, units, ranges, and valid values; return values; preconditions and postconditions; errors; ownership and lifetime; thread safety; side effects; compatibility expectations; and performance costs that affect correct use.

Do not expose private algorithm steps or internal identifiers that consumers do not need. For mixed code, apply the public-contract standard to the parts consumers use and the internal-code standard to implementation details.

## Editor-facing comments

Some engines show a comment to designers in the editor:

- Unreal: a comment directly above a `UPROPERTY` or `UFUNCTION` becomes its editor tooltip.
- Godot 4: a `##` comment directly above an `@export` variable becomes its Inspector tooltip.

Write these for the designer: what the value or node does, its units, and its range. Leave out implementation detail. When the comment is also part of a shareable contract, write for the editor reader first and keep every contract fact a caller needs, in plain words.

Document each parameter with the engine's parameter tag where one exists.

For other engines, treat a comment as editor-facing only when project rules say so.

## Common labels

Prefer the smallest label set that follows the project rules:

- **TODO:** Work to complete later.
- **FIXME:** Known incorrect behaviour that needs correction.
- **NOTE:** Important information that is easy to miss. It is not a task or warning.
- **WARNING:** A serious risk. Name the risk and the condition that triggers it.
- **WORKAROUND:** Temporary handling of an external limitation or known issue. Name the issue, and say when the workaround can be removed, if known.
- **DEPRECATED:** An interface or behaviour that should no longer be used.
- **SECURITY:** A security-sensitive assumption, constraint, or required action.

Other common labels include `CAUTION`, `HACK`, `BUG`, `OPTIMIZE`, `REVIEW`, and `XXX`. Use them only when project rules establish their meaning. Avoid `XXX` by default because it is ambiguous.

- Use a recognised label only when it adds useful classification.
- Use the exact label spelling and format required by the project.
- Do not add a label when an ordinary comment is clearer.
- Follow a label with a concise, complete explanation that stands on its own.
- Include an issue reference, owner, or removal condition when available and useful. Do not invent missing details.
- Keep informational labels such as `NOTE` distinct from action labels such as `TODO` and `FIXME`.

Preserve required documentation tags and language-specific formats.

## Operations and output

Match the output to the requested operation. Do not silently expand one operation into another.

Treat commented-out code as an uncertain comment unless the user asks to remove commented-out code.

When the task writes, rewrites, or reviews a comment at the top of a file, read `references/file-headers.md`.

### Output

- With file access, edit the files directly. Show a diff only when the user asks for one.
- With pasted code, return the full code the user provided, with the comment changes. Return the code through the last line of the input. This includes code after the last comment change. Preserve existing placeholders. Do not omit code or introduce new placeholders unless the user requests a patch or comments-only output.
- End with the one-line statement of what was assumed, from "Before commenting". It names the unknown context and the source of guidance or template used.

### Write

- Add only the requested comments.

### Rewrite

- Change only the comments being rewritten.
- Preserve comment placement unless moving it is necessary for correctness or required by project rules.
- Briefly identify important meaning preserved and any comment left unchanged because it is uncertain or protected.

### Review

Read `references/review.md` for a review. It owns what a review checks and how findings are reported.

A review does not modify code unless the user also requests writing, rewriting, or editing.

### Remove

- Remove only comments confirmed as unnecessary.
- Preserve protected, meaningful, and uncertain comments.
- List comments retained because they have useful, protected, or uncertain significance.

### Mixed requests

Perform only the operations explicitly requested. For example, "review and rewrite" permits both findings and revised comments.

## Final check

Before returning comments, verify that each one:

1. adds information not obvious from the code, without repetition;
2. is accurate and supported by the available context;
3. follows the user's instructions, mandatory requirements the user has not chosen to break, project rules, and the correct internal, shareable, or editor-facing standard;
4. uses plain English, proportional detail, and the fewest easy-to-understand words that preserve meaning;
5. has one fact per sentence and one sentence per line, with no clauses joined by a colon, a semicolon, or a dash, and at most one "because" or "so";
6. is consistent with related comments in terminology, labels, and abstraction;
7. does not alter or endanger a protected comment;
8. leaves all non-comment code unchanged, as the Invariant requires.

Then check the returned code as a whole. It has the same non-comment lines as the input, in the same order. Count them.

## General examples

Remove a comment that only repeats the code:

Before:

```cpp
// Increase the retry count by one.
retryCount++;
```

After:

```text
Remove the comment. It repeats the code.
```

Explain a non-obvious reason:

```cpp
// Keep one slot free for recovery messages.
const int usableCapacity = capacity - 1;
```

Use `NOTE` for important information that is easy to miss:

```cpp
// NOTE: Hit-stop also pauses this timer, so cooldowns last longer in heavy combat.
float AttackCooldownRemaining;
```

Document the consumer-facing contract of shared code:

```cpp
/// Returns the matching account, or null when no account exists.
/// The cache owns the account. Do not delete it.
/// Safe to call from multiple threads.
Account* FindAccount(AccountId id);
```

Make maintenance actions specific:

```cpp
// TODO: Remove the legacy conversion after format version 3 is retired.
ConvertLegacyValue(value);
```

Prefer common words over compressed technical language:

Before:

```cpp
// Retry on transient session unavailability.
```

After:

```cpp
// Retry once, because the new session may not be ready yet.
```

Split a dense comment into one fact per sentence and one sentence per line:

Before:

```nu
# Fast-forward main from origin when the primary checkout allows it. A failure
# is a warning, not a stop: a branch from slightly old main still works.
```

After:

```nu
# Update main from origin.
# This works only when the primary checkout is on main.
# A failure is only a warning, because a branch from an older main still works.
```
