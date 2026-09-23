# Behaviour Tests

Ten scenario tests for the code-comments skill.

Read them against the built rules whenever this skill changes. They are read, not executed, except three.

- T1 needs a live run, because reading cannot show whether the skill loads.
- T9 and T10 need a live run, because reading cannot show what comments the skill writes. Run each on a fresh agent with the sample file from `tests/samples/`.

A test whose Must the rules no longer produce is a failed validation, not a test to rewrite.

## T1. A Mixed Request Does Not Block Code Work

**Trigger**

"Add the stagger state, then tidy the comments."

**Must**

The code step proceeds.

**Must Not**

Refuse or pause the code step because this skill forbids code changes.

**Owner**

`SKILL.md`, description. Live run only.

## T2. Pasted Code Comes Back in Full

**Trigger**

The user pastes an 800-line file and asks for comments on one function.

**Must**

Return the full pasted code with the new comments.

**Must Not**

Return only the function, or replace code with a placeholder such as `// ... rest unchanged`.

**Owner**

`SKILL.md`, Operations and output, Output.

## T3. No Questions Before an Inline Rewrite

**Trigger**

"Rewrite this inline comment." The check finds no project rules.

**Must**

Rewrite the comment. After the work, state in one line that no project commenting rules were found and the skill's defaults were used.

**Must Not**

Ask about project rules, or whether the code is internal or shareable, before the work.

**Owner**

`SKILL.md`, Before commenting.

## T4. Unknown Shareability Goes to the Fallback

**Trigger**

"Document the functions in this file." The user has not said whether the code is internal or shareable.

**Must**

Write the documentation with the fallback. State that shareability is unknown, and flag the declarations whose documentation depends on it.

**Must Not**

Ask whether the code is internal or shareable, choose one, or invent a guarantee such as thread safety or ownership.

**Owner**

`SKILL.md`, Before commenting.

## T5. Commented-Out Code Is Kept

**Trigger**

"Remove unnecessary comments." The file contains `// MoveSpeed = 800.f;`.

**Must**

Keep the commented-out line and list it as retained.

**Must Not**

Delete it as unnecessary.

**Owner**

`SKILL.md`, Operations and output, Remove.

## T6. Editor-Facing Comments Are Written for Designers

**Trigger**

Comment a value whose comment the engine shows in the editor.

**Must**

Use designer wording, one claim per line, and the engine's parameter tag where one exists.

**Must Not**

Include implementation detail.

**Owner**

`SKILL.md`, Editor-facing comments.

## T7. A Conflict With a Mandatory Rule Is Asked Once

**Trigger**

"Add a one-line comment to `GetHealth()`, no Doxygen." `CONTRIBUTING.md` requires a Doxygen block on public functions.

**Must**

Name the rule, its source, and the consequence. Ask once whether to proceed. After a yes, add the one-line comment.

**Must Not**

Refuse, or ask for evidence that the rule does not apply.

**Owner**

`SKILL.md`, Before commenting, step 3.

## T8. A Delegated Answer Keeps the Rule

**Trigger**

The agent asks whether to break a mandatory rule. The user replies "Whatever."

**Must**

Follow the rule.

**Must Not**

Break the rule.

**Owner**

`SKILL.md`, Before commenting, step 3.

## T9. A Verbose File Comes Back Plain

**Trigger**

"Rewrite the comments in this file." The file is `tests/samples/enemy_melee.gd`. Live run only.

**Must**

- Each comment line holds one sentence.
- No clause is joined by a colon, a semicolon, or a dash.
- No comment repeats the line below it.
- The reason for the floor check before an attack, root motion, keeps a comment.
- The commented-out line `#var _debug_draw := true` is kept.
- Code outside comments is unchanged.
- The last function, `_die()`, is returned unchanged.
- No comment uses "because" or "so" more than once.

**Must Not**

- A sentence wraps onto a second line.
- A comment describes obvious code.

**Owner**

`SKILL.md`, Write the comment.

## T10. New Comments Come Out Plain

**Trigger**

"Add comments to this script." The file is `tests/samples/worktree_create.nu`, which has no comments. Live run only.

**Must**

- Each comment line holds one sentence.
- No clause is joined by a colon, a semicolon, or a dash.
- No comment repeats the line below it.
- The reason the parent of the shared git folder is the primary checkout gets a comment.
- Code outside comments is unchanged.
- No comment uses "because" or "so" more than once.

**Must Not**

- A sentence wraps onto a second line.
- A comment describes obvious code.

**Owner**

`SKILL.md`, Write the comment.
