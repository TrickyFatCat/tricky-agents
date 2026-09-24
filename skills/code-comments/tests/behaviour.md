# Behaviour Tests

Twenty-five scenario tests for the code-comments skill.

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

`SKILL.md`, Output.

## T3. No Questions Before an Inline Rewrite

**Trigger**

"Rewrite this inline comment." The check finds no project rules.

**Must**

Rewrite the comment. After the work, state in one line that no project comment rules were found and the skill's rules were used.

**Must Not**

Ask about project rules, or whether the code is shared, before the work.

**Owner**

`SKILL.md`, Before Commenting.

## T4. An Interface Comment Is Tested on the Declaration

**Trigger**

"Improve the comments in `AccountCache.h`." The header holds `// Returns the matching account, or null when no account exists.` above `Account* FindAccount(AccountId Id);`. The body in the `.cpp` file returns `nullptr` when no account exists.

**Must**

Keep the null result in the comment, because the declaration does not show it.

**Must Not**

- Delete the comment because the body shows the null result.
- Add a thread safety, ownership or lifetime claim that the code does not show.

**Owner**

`SKILL.md`, A Good Comment and Kinds.

## T5. Commented-Out Code Is Kept and Reported

**Trigger**

"Remove unnecessary comments." The file contains `// MoveSpeed = 800.f;`.

**Must**

Keep the commented-out line and list it under "Needs Your Decision".

**Must Not**

Delete it as unnecessary.

**Owner**

`SKILL.md`, The Sort, step 2.

## T6. Editor Tooltips Are Written for Designers

**Trigger**

"Comment the exported values in this script." The file is a Godot 4 script with `@export` variables.

**Must**

Each `##` comment says what the value does, its units and its range, with one sentence per line.

**Must Not**

Include implementation detail.

**Owner**

`SKILL.md`, Kinds, Editor Tooltips.

## T7. A Conflict With a Required Rule Is Asked Once

**Trigger**

"Add a one-line comment to `GetHealth()`, no Doxygen." `CONTRIBUTING.md` requires a Doxygen block on public functions.

**Must**

Name the rule, its source, and the cost of breaking it. Ask once whether to proceed. After a yes, add the one-line comment.

**Must Not**

Refuse, or ask for evidence that the rule does not apply.

**Owner**

`SKILL.md`, Before Commenting, step 3.

## T8. A Delegated Answer Keeps the Rule

**Trigger**

The agent asks whether to break a required rule. The user replies "Whatever."

**Must**

Follow the rule.

**Must Not**

Break the rule.

**Owner**

`SKILL.md`, Before Commenting, step 3.

## T9. A Verbose File Comes Back Plain

**Trigger**

"Rewrite the comments in this file." The file is `tests/samples/enemy_melee.gd`. Live run only.

**Must**

- Each comment line holds one sentence.
- No clause is joined by a colon, a semicolon, or a dash.
- Each why sits in one sentence with its what.
- No sentence fails the delete test, except a sentence kept because it contradicts the code.
- The root-motion reason for the floor check before an attack is kept.
- The hit-flash sentence in the `take_damage` comment is kept word for word and reported as a contradiction.
- The `## @param amount` line is gone, because GDScript has no `@param` tag to require it.
- The commented-out line `#var _debug_draw := true` is kept and reported.
- The file header, if any, holds only facts about the whole file.
- Code outside comments is unchanged.
- The last function, `_die()`, is returned unchanged.

**Must Not**

- A sentence wraps onto a second line.
- A comment repeats the code or explains GDScript itself.

**Owner**

`SKILL.md`, The Sort and Writing Rules.

## T10. New Comments Come Out Plain

**Trigger**

"Add comments to this script." The file is `tests/samples/worktree_create.nu`, which has no comments. Live run only.

**Must**

- Each comment line holds one sentence.
- No clause is joined by a colon, a semicolon, or a dash.
- Each why sits in one sentence with its what.
- No sentence fails the delete test.
- The reason the parent of the shared git folder is the primary checkout gets a comment.
- Code outside comments is unchanged.

**Must Not**

- A sentence wraps onto a second line.
- A comment explains how Nushell or git behave.

**Owner**

`SKILL.md`, A Good Comment and Writing Rules.

## T11. An Obvious Comment Is Deleted, Not Reworded

**Trigger**

"Improve the comments." The file holds `# Decrease the cooldown timer by the elapsed time.` above `_cooldown_left = max(_cooldown_left - delta, 0.0)`.

**Must**

Delete the comment.

**Must Not**

Reword it, for example to "Counts the cooldown down each frame."

**Owner**

`SKILL.md`, The Sort, step 5.

## T12. A Contradiction Is Kept and Reported

**Trigger**

"Improve the comments." A doc comment holds two sentences that repeat the code and one that says the function plays a hit flash. The function sets `_flash_timer`, and nothing reads it.

**Must**

- Keep the hit-flash sentence word for word and report the mismatch.
- Still delete the sentences that repeat the code.

**Must Not**

- Delete or rewrite the hit-flash sentence.
- Leave the whole comment unchanged because one sentence contradicts the code.

**Owner**

`SKILL.md`, The Sort, step 4.

## T13. A Bad Name Is Reported, Not Renamed

**Trigger**

"Improve the comments." The file holds `float t;  // Time since the enemy was last hit, in seconds.`

**Must**

Keep the comment and report that `t` needs it.

**Must Not**

- Rename `t`.
- Delete the comment.

**Owner**

`SKILL.md`, The Sort, step 3.

## T14. A Split Keeps What and Why Together

**Trigger**

"Improve the comments." The file holds `# A foreign symlink is yellow: deleting it loses nothing.` above `"foreign" => {action: "blocked", colour: "yellow"}`.

**Must**

Write one sentence with the what first and the why after it, such as "Shows yellow, because deleting a foreign symlink loses nothing."

**Must Not**

- Keep only "Deleting a foreign symlink loses nothing."
- Keep the colon.

**Owner**

`SKILL.md`, Writing Rules.

## T15. The Language Is Not Explained

**Trigger**

"Improve the comments." The file holds `^ln -s $e.source $e.link   # Nushell has no symlink builtin.` and a four-line comment above `$path | path type | default ""` that explains how Nushell types and `let` work.

**Must**

- Delete the symlink comment.
- Replace the four lines with "Do not remove the `default`." followed by what breaks in this code.

**Must Not**

Keep any sentence that explains how Nushell behaves.

**Owner**

`SKILL.md`, Writing Rules.

## T16. A Missing Reason Is Reported, Not Invented

**Trigger**

"Improve the comments." The file holds `# Wait 200 milliseconds.` above `sleep 200ms`. Neither the code nor its history says why.

**Must**

Delete the comment and report the missing reason.

**Must Not**

Write a reason the sources do not give.

**Owner**

`SKILL.md`, The Sort, step 5, and Operations, Improve.

## T17. A Review Changes No Files

**Trigger**

"Review the comments in `install.nu`."

**Must**

Answer in the conversation, judging the comments with the skill's rules.

**Must Not**

Change any file.

**Owner**

`SKILL.md`, Operations, Review.

## T18. A Required Doc Part Is Replaced, Not Deleted

**Trigger**

"Improve the comments." The project follows a standard that requires `@param` on public functions. The header holds `@param Damage The damage to apply.` The body treats negative damage as 0.

**Must**

Keep the tag and replace its text with a caller fact, such as "Negative values count as 0."

**Must Not**

- Delete the tag.
- Leave the tag with no text.

**Owner**

`SKILL.md`, The Sort, step 5.

## T19. The Language Is Explained Only on the User's Word

**Trigger**

Two runs of "Add comments to this script."

- In the first, the user adds "This is a teaching project for beginners."
- In the second, the file sits in a folder named `examples/`, and the user says nothing about teaching.

**Must**

Explain the language in the first run only.

**Must Not**

Explain the language in the second run because of the folder name.

**Owner**

`SKILL.md`, Writing Rules.

## T20. What Could Not Be Checked Is Reported

**Trigger**

"Improve the comments." A comment says "Runs in under 1 ms." The agent cannot run the code.

**Must**

Keep the comment and list the claim under "what you could not check", with the reason.

**Must Not**

- Treat the claim as verified.
- Delete it as false.

**Owner**

`SKILL.md`, Output, Report.

## T21. "Every Function" Skips Functions With Nothing to Say

**Trigger**

"Add doc comments to every function in this file." One function is `func get_health() -> int: return health`. No project rule requires doc comments.

**Must**

Skip `get_health` and list it in the report.

**Must Not**

Write "Returns the health." or any other comment that fails the delete test.

**Owner**

`SKILL.md`, Operations, Add.

## T22. Deleted Comments Are Reported

**Trigger**

"Improve the comments." The sort deletes three comments.

- In the first run, the file is under git.
- In the second, the file is not under version control.

**Must**

- In the first run, report the count.
- In the second run, report the count and each deleted comment in full.

**Must Not**

Leave the deletions out of the report.

**Owner**

`SKILL.md`, Output, Report.

## T23. Runtime Docs and Doctests Survive

**Trigger**

"Improve the comments in `export.py`." The docstring of `main()` is passed to `argparse` as the help description. It also holds a doctest.

**Must**

- Keep the help text. Its wording may change under the writing rules.
- Keep the doctest lines exactly as they are.

**Must Not**

- Delete the help text because it fails the delete test.
- Reword the doctest.

**Owner**

`SKILL.md`, The Sort, step 5, and Protected Comments.

## T24. A Moved Fact Is Tested Again

**Trigger**

"Improve the comments in `EnemyCharacter.h`." The doc comment on `Explode()` holds three sentences: "Damages every enemy within BlastRadius.", "Loops over the overlap results and casts each one to AEnemy." and "Uses squared distance to avoid a square root per enemy."

**Must**

- The doc comment keeps only "Damages every enemy within BlastRadius."
- The squared-distance reason moves to the `DistSquared` line in the body.
- The loop sentence is deleted.

**Must Not**

The loop sentence reappears as a comment in the body.

**Owner**

`SKILL.md`, Kinds.

## T25. Claims About Other Code Are Checked, Not Widened

**Trigger**

"Improve the comments in `EnemySpawner.h`." The header holds `// Only called from BeginPlay.` above `void ResetWave();`. `EnemySpawner.cpp` calls `ResetWave` from `BeginPlay` and from `Tick`. It also holds `// Increment the wave counter.` above `++WaveIndex;`.

- In the first run, `ResetWave` has no `UFUNCTION` specifier.
- In the second run, `ResetWave` is marked `UFUNCTION(BlueprintCallable)`.

**Must**

- In the first run, keep the claim word for word and report it as a mismatch.
- In the second run, report the claim as not checked, because a Blueprint may call the function.

**Must Not**

- Delete or reword the claim.
- Change or report the comment in `EnemySpawner.cpp`.

**Owner**

`SKILL.md`, A Good Comment, Claims About Other Code.
