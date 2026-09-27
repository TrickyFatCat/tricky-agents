# Behaviour Tests

Forty-three scenario tests for the code-comments skill.

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

## T6. Tooltips Are Written for Designers From the Declaration

**Trigger**

Three runs.

- "Comment the exported values in this script." The file is a Godot 4 script with `@export` variables and no comments.
- "Improve the comments." A Godot enemy script holds three exports. The body clamps `knockback_speed` to between 0 and 10.

  ```gdscript
  ## Speed is 4.5.
  @export var move_speed := 4.5

  ## Metres per second, from 0 to 10.
  @export_range(0.0, 10.0) var dash_speed := 6.0

  ## Metres per second, from 0 to 10.
  @export var knockback_speed := 3.0
  ```

- "Comment the dash values." The file is a Unity C# script with `public float dashSpeed;` and no `[Tooltip]` attribute.

**Must**

- In the first run, each `##` comment says what the value does, its units and its range, where the declaration and its annotations do not show them, with one sentence per line.
- In the second run, delete the comment above `move_speed` and report its unit as a missing fact, cut the comment above `dash_speed` to the unit, and keep the unit and the range above `knockback_speed`.
- In the third run, report the missing Unity tooltip under Needs Your Decision, with the text it would hold.

**Must Not**

- Include implementation detail in a tooltip.
- Keep a sentence that repeats a value or a range the declaration shows.
- Invent a unit for `move_speed`.
- Add a `[Tooltip]` attribute, or a `//` comment presented as the tooltip.

**Owner**

`SKILL.md`, Kinds, Editor Tooltips, and A Good Comment, Delete Test.

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
- No sentence fails the delete test, except a sentence kept unchanged.
- Every pronoun in a comment the agent wrote or changed resolves from that comment and the code it sits on.
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

`SKILL.md`, The Sort, Writing Rules and Final Check.

## T10. New Comments Come Out Plain

**Trigger**

"Add comments to this script." The file is `tests/samples/worktree_create.nu`, which has no comments. Live run only.

**Must**

- Each comment line holds one sentence.
- No clause is joined by a colon, a semicolon, or a dash.
- Each why sits in one sentence with its what.
- No sentence fails the delete test.
- Every pronoun resolves from its comment and the code it sits on.
- The reason the parent of the shared git folder is the primary checkout gets a comment.
- Each sentence about how git behaves was checked in the run, against git's help or with a run in a temporary folder.
- Code outside comments is unchanged.

**Must Not**

- A sentence wraps onto a second line.
- A comment explains how Nushell behaves, or how git arrives at a result.

**Owner**

`SKILL.md`, A Good Comment, Writing Rules and Final Check.

## T11. An Obvious Comment Is Deleted, Not Reworded

**Trigger**

"Improve the comments." The file holds `# Decrease the cooldown timer by the elapsed time.` above `_cooldown_left = max(_cooldown_left - delta, 0.0)`.

**Must**

Delete the comment.

**Must Not**

Reword it, for example to "Counts the cooldown down each frame."

**Owner**

`SKILL.md`, The Sort, step 5.

## T12. A Contradiction Is Kept Word for Word

**Trigger**

"Improve the comments." A Godot script holds this doc comment above `take_damage`:

```gdscript
## Takes damage.
## Subtracts the amount from health.
## This function also plays a hit flash effect.
func take_damage(amount: int) -> void:
```

The function sets `_flash_timer = 0.1` and plays nothing. No code in reach reads `_flash_timer`, but other scripts in the project are out of reach.

**Must**

- Keep the hit-flash sentence word for word and report it as a mismatch under Needs Your Decision.
- Still delete the two sentences that repeat the code.

**Must Not**

- Delete the hit-flash sentence, or rewrite it to follow the writing rules, such as "Also plays a hit flash effect.", before the user decides.
- Report it as not checked because other code might play the flash.
- Leave the whole comment unchanged because one sentence contradicts the code.

**Owner**

`SKILL.md`, The Sort, step 4 and Kept Text, and A Good Comment, Claims About Other Code.

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

`SKILL.md`, Writing Rules, and A Good Comment, Delete Test.

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

`SKILL.md`, The Sort, step 5, and A Good Comment, Fact Sources.

## T17. A Review Proposes Changes and Changes No Files

**Trigger**

"Review the comments in `EnemySpawner.cs`." No project rule sets a line width. The file holds five comments.

- `// Called by the player and the turret.` sits above `SpawnWave()`, and a boss also calls it.
- A doc comment holds a contradicting sentence, and an older sentence in the same comment states its true reading.
- Another comment says "Called only by the player.", and a turret also calls that method.
- A doc comment says "Returns the spawned enemy.", and the method returns nothing.
- `float t;  // Seconds since the last wave ended.` makes up for the name `t`.

**Must**

- Answer in the conversation, judging the comments with the skill's rules.
- Open the report with Proposed Changes, which shows the completed caller list and the proposed deletion.
- Put the return-value mismatch and the "only" claim under Needs Your Decision, before the bad name, because they may show a bug in the code.

**Must Not**

- Change any file.
- Put the proposed text only under For Your Information.

**Owner**

`SKILL.md`, Operations, Review, and Output, Report.

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

"Improve the comments in `export.py`." The docstring of `main()` is passed to `argparse` as the help description. It also holds a doctest that spans three lines.

**Must**

- Keep the help text. Its wording may change under the writing rules.
- Keep the doctest lines exactly as they are, including their line breaks.

**Must Not**

- Delete the help text because it fails the delete test.
- Reword the doctest, or join its lines.

**Owner**

`SKILL.md`, The Sort, steps 1 and 5 and Kept Text, and Protected Comments.

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

## T25. Claims About Other Code: Code In Reach Wins

**Trigger**

"Improve the comments in `EnemySpawner.h`." The header holds `// Only called from BeginPlay.` above `void ResetWave();`, and `ResetWave` is marked `UFUNCTION(BlueprintCallable)`. `EnemySpawner.cpp` also holds `// Increment the wave counter.` above `++WaveIndex;`.

- In the first run, `EnemySpawner.cpp` calls `ResetWave` from `BeginPlay` and from `Tick`.
- In the second run, `EnemySpawner.cpp` calls `ResetWave` only from `BeginPlay`.

**Must**

- In the first run, keep the claim word for word and report it as a mismatch, because the `Tick` call is in reach.
- In the second run, report the claim as not checked, because a Blueprint may call the function.

**Must Not**

- Delete or reword the claim.
- Report the claim as not checked when code in reach disproves it.
- Change or report the comment in `EnemySpawner.cpp`.

**Owner**

`SKILL.md`, A Good Comment, Claims About Other Code.

## T26. A Written Claim Is Checked Again Before Delivery

**Trigger**

"Add comments to `InventoryUI.cs`." While drafting, the agent writes `// Called only by the pause menu.` above `public void Refresh()`.

- In the first run, `HudController.cs` in the same project also calls `Refresh`.
- In the second run, only the pause menu calls `Refresh` in the code in reach, and the method is public, so code out of reach may call it.

**Must**

- In the first run, deliver no sentence that code in reach disproves.
- In the second run, do not write the claim, because the code in reach does not prove it.

**Must Not**

- Deliver the claim as it was written from what the agent read while drafting.
- Deliver a new claim and report it as not checked.

**Owner**

`SKILL.md`, A Good Comment, Claims About Other Code, and Final Check.

## T27. The Line Width Comes From the Project, Else 80

**Trigger**

"Improve the comments." Three runs.

- A Godot script has no formatter, linter, style guide or `.editorconfig`. A top-level comment holds one fact and its reason, and reaches 90 characters: `# Limits knockback force to 300 per hit, so stacked hits never push enemies through walls.` Another top-level comment holds two facts and reaches 94 characters: `# Stores the dash speed in metres per second and resets it to zero each time the player lands.` A function holds `# Waits for the landing animation, so the dash cannot start in mid-air.` behind two tabs, with 71 characters of text.
- The same script, and `.editorconfig` sets `max_line_length = 72`.
- The same script, and `.editorconfig` sets `tab_width = 8` and no line width.

**Must**

- In the first run, keep the first sentence whole on one line, split the second into one sentence per fact, and count the tabbed line as 79 characters and keep it as it is.
- In the second run, keep every line within 72 characters, or report each line that still does not fit after its words are shortened.
- In the third run, count the tabbed line as 87 characters, cut words that carry no fact, and keep what is left on one line.

**Must Not**

- Wrap a sentence onto a second line.
- Cut the what from its why to reach 80 characters.
- Count a tab as one character.

**Owner**

`SKILL.md`, Writing Rules.

## T28. Rewording Keeps the Facts That Passed the Sort

**Trigger**

"Shorten the comments." A Unity script holds this comment above `public float dashDuration;`:

```csharp
// Dash duration in seconds. Zero turns the dash off. Unity serialises this public float.
```

**Must**

Keep the unit and the zero case in the shortened comment.

**Must Not**

- Drop the unit or the zero case to make the comment shorter.
- Keep the sentence about how Unity serialises the field.

**Owner**

`SKILL.md`, Final Check and Writing Rules.

## T29. A Covered Contradiction Is Deleted, an Uncovered One Is Kept

**Trigger**

"Improve the comments." A save loader holds this doc comment above `LoadSlots()`:

```text
Returns an empty list when the save file is invalid.
Returns an empty list when the file header does not match.
```

The code repairs broken JSON and returns an empty list only for a wrong header. In a second run, the comment holds only the first sentence.

**Must**

- In the first run, delete the first sentence and report the deletion, because the second sentence states its true reading.
- In the second run, keep the first sentence word for word and report the mismatch.

**Must Not**

- In the second run, add a sentence about the header and then delete the first sentence.
- In the second run, correct "invalid" as a wrong word, because the condition is the fact the sentence states.
- In either run, add a sentence that contradicts a kept one.

**Owner**

`SKILL.md`, The Sort, step 4.

## T30. A Copy That Must Change Together Gets a Warning

**Trigger**

"Add comments to `enemy.gd`." The file sets `const MAX_HEALTH := 100`. The game reads `data/enemies.json` at load time, and it holds the same 100. A design wiki page in `docs/` says that enemies have 100 health.

**Must**

Write a `WARNING` above `MAX_HEALTH` that names `data/enemies.json`.

**Must Not**

- Name the wiki page in the warning.
- Leave the copy without a warning.

**Owner**

`SKILL.md`, A Good Comment, Add Test.

## T31. An Incomplete List Is Completed, Grouped or Reported

**Trigger**

"Improve the comments." A game project holds six comments above six methods. No project rule sets a line width.

- `// Called by the player and the turret.` A boss class also calls the method.
- `// Called only by the player.` A turret class also calls the method.
- `// Called by gameplay code, such as the player and the turret.` A boss class also calls the method.
- `// Called by the player.` Nine classes call the method. All except the player derive from `AEnemyBase` or `AHazard`.
- `// Called only by the player.` followed by `// The turret also calls it when it overheats.` The code shows the player and the turret as callers.
- `// Called by the player and the turret.`, with four spaces of indentation. The code shows seven more callers: `Boss`, `ExplosiveBarrel`, `SpikeTrap`, `LaserGrid`, `PoisonCloud`, `FallingRock` and `ArenaHazardController`. The nine caller classes share no base class, folder or tag.

**Must**

- Complete the first list with the boss, and report the change.
- Keep the second sentence word for word, and report it as a mismatch.
- Leave the third sentence as it is.
- Rewrite the fourth as groups named after the player, `AEnemyBase` and `AHazard`, with examples given by "such as", and report the change.
- Keep both sentences of the fifth comment word for word, report the first as a mismatch, and name the second sentence in the entry.
- Keep the sixth sentence and report the list as incomplete, with the seven missing callers.

**Must Not**

- Invent a group that the code does not define.
- Complete the second, the third, the fifth or the sixth list.
- Delete "Called only by the player." because the next sentence names the turret.

**Owner**

`SKILL.md`, A Good Comment, Claims About Other Code.

## T32. Matching a Sibling Does Not Add a Comment

**Trigger**

"Improve the comments." A Unity pool class holds `Spawn()` with a docstring that says it reuses an inactive enemy and returns null when the pool is empty. `Despawn(Enemy enemy)` has no comment and only calls `enemy.gameObject.SetActive(false)`.

**Must**

Leave `Despawn` without a comment.

**Must Not**

Add a docstring to `Despawn` so that it matches `Spawn`.

**Owner**

`SKILL.md`, Writing Rules.

## T33. A File Header Leaves Usage to the Help

**Trigger**

"Improve the comments in `bake_atlas.py`." The script prints its help from `argparse` strings. The file header holds three sentences: "Packs sprite frames into one atlas texture for the engine.", "Usage: bake_atlas.py FOLDER [--padding N]." and "Writes atlas.png next to the input folder."

**Must**

- Delete the usage sentence.
- Keep the purpose and the side effect.

**Must Not**

Delete the side effect because the help also prints it.

**Owner**

`SKILL.md`, Kinds, File Headers.

## T34. An Entry Name Is Not a Join

**Trigger**

"Improve the comments." A Godot enemy script holds two comments, and a Python script holds a parameter entry.

```gdscript
## States the enemy can be in.
## - "idle": waits at its spawn point.
## - "chase" - moves toward the player.

# Checks the floor first: root motion can carry the enemy off a ledge.
```

```python
    Args:
        radius: blast radius in metres, 0 or more.
```

**Must**

- Keep the colon and the dash after the state names.
- Keep the parameter entry as a name and a phrase.
- Rewrite the floor-check sentence without the joining colon.

**Must Not**

- Turn the state list or the parameter entry into prose.

**Owner**

`SKILL.md`, Writing Rules.

## T35. A Reason States What the Code Needs

**Trigger**

"Improve the comments." A Unity coroutine holds this comment:

```csharp
// Unity runs FixedUpdate before the physics step, so this waits for the step to finish.
yield return new WaitForFixedUpdate();
ApplyKnockback();
```

**Must**

Rewrite the comment to state what this code needs, such as "Waits for physics, so knockback reads the final position."

**Must Not**

- Keep the explanation of Unity's frame order.
- Delete the reason entirely.

**Owner**

`SKILL.md`, Writing Rules, comments are not tutorials.

## T36. A Kept Sentence Keeps Its Context

**Trigger**

"Improve the comments." A Godot script and a C# script each hold a comment of two sentences. The second sentence contradicts the code in both.

```gdscript
# This variable keeps track of the remaining time before the enemy can attack again.
# It is decreased every physics frame and when it reaches zero, the enemy can attack.
var _cooldown_left: float = 0.0
```

```csharp
// Stores the health.
// It never drops below zero.
int health;
```

The name `_cooldown_left` does not say which cooldown it tracks. The C# code can make `health` negative.

**Must**

- Keep the first Godot sentence, reworded under the writing rules, and keep the second word for word. Report the name `_cooldown_left` and the mismatch.
- Delete "Stores the health." and keep "It never drops below zero." word for word.
- Say in the C# mismatch entry that the subject of "It" was in a deleted sentence.

**Must Not**

- Delete the first Godot sentence.
- Rename `_cooldown_left`.
- Change "It" to "Health" in the kept C# sentence.

**Owner**

`SKILL.md`, The Sort, steps 3, 4 and 5, and A Good Comment, Claims About Other Code.

## T37. A Reason Names the Tool Fact the Code Relies On

**Trigger**

"Improve the comments." A Godot script holds:

```gdscript
# Godot packs res:// into a read-only .pck file at export, so any write there fails.
const SAVE_PATH := "user://save.json"
```

**Must**

Rewrite the comment to state the fact the code relies on, such as "Saves to user://, because an exported game cannot write to res://."

**Must Not**

- Keep the explanation of how Godot packs `res://`.
- Delete the reason entirely.

**Owner**

`SKILL.md`, Writing Rules, comments are not tutorials.

## T38. Blank Lines Follow the Comments

**Trigger**

"Add comments to this script." A Nushell script opens with its shebang line and a blank line, then `def refuse [msg: string, detail: string] {`. The agent adds a file header and a comment above `refuse`.

**Must**

- Put a blank line between the file header and the `refuse` comment, so the header does not become the help text of `refuse`.
- Leave every blank line between two code lines in the input as it is.

**Must Not**

- Place the header directly above the `refuse` comment with no blank line.
- Add or remove a blank line between two code lines.

**Owner**

`SKILL.md`, Invariant, and Kinds, File Headers.

## T39. An Agent Instruction File Counts as a Copy

**Trigger**

"Add comments to `worktree-create.nu`." The script sits in a repository's `scripts` folder. Its `refuse` function exits with code 2. The repository's `AGENTS.md` says that exit code 2 means a refusal, and `README.md` says the same.

**Must**

Write a `WARNING` at `refuse` that names `AGENTS.md`.

**Must Not**

- Name `README.md` in the warning.
- Leave the exit code without a warning.

**Owner**

`SKILL.md`, A Good Comment, Add Test.

## T40. The Agent's Own Sentence Is Fixed, Not Kept

**Trigger**

"Improve the comments in `export_level.py`." While drafting, the agent writes `# Sends the tool's messages to stderr, so stdout holds only the JSON result.` above the line that prints the tool's stderr. The code captures the tool's stdout and drops it. Before the final check, the agent notices that one reading of its sentence says every message is forwarded.

**Must**

Rewrite the sentence so that no reading contradicts the code, such as "Forwards only the tool's stderr, so stdout holds only the JSON result."

**Must Not**

- Keep the sentence word for word and report it as a mismatch.
- Treat the sentence as text that existed before the run.

**Owner**

`SKILL.md`, The Sort and Kept Text, and Final Check.

## T41. A Wrong Word Outside the Fact Is Corrected

**Trigger**

"Improve the comments." A texture build script holds `# Compresses the texture even when it is read-only, because the artist chose this file.` above `process(texture, mode, force=True)`. `mode` is "compress" or "verify", and nothing else in the comment mentions the mode.

**Must**

- Correct "Compresses" to a word that covers both modes, and keep the sentence's other facts and its reason.
- Report the correction under For Your Information.

**Must Not**

- Keep the sentence unchanged and report it under Needs Your Decision.
- Rewrite the reason, or drop `force`'s why.

**Owner**

`SKILL.md`, The Sort, step 4, and Output, Report.

## T42. A Claim About a Tool Is Checked Like a Claim About Code

**Trigger**

"Improve the comments in `format.sh`." The script runs a formatter that is installed on the machine. Two runs.

- The file holds `# Matches the message, because the formatter has no exit code for a missing config.` The formatter's help lists exit code 11 as a configuration error.
- The file has no comment above the line that prints the formatter's stderr. The agent wants to write a sentence about which stream the formatter uses for its diff.

**Must**

- In the first run, keep the sentence word for word, report it as a mismatch, and name the help as the source of the true fact.
- In the second run, check the stream from the formatter's help, or from a run on a copy of a file in a temporary folder, before writing the sentence.

**Must Not**

- Write the stream from memory.
- Check it with a run that formats the user's files in place, or with a run whose effects the agent is unsure of.
- Report the first sentence as not checked when the help was in reach.

**Owner**

`SKILL.md`, A Good Comment, Fact Sources and Claims About Other Code, and Final Check.

## T43. A Missing Fact Joins an Existing Comment

**Trigger**

A Python script's `main()` docstring says "Prints a JSON record with the fields ok and file." The script exits with code 2 before printing when the path is a folder. Two runs.

- In the first run, the user says "Improve the comments."
- In the second run, the user says "Shorten the comments."

**Must**

- In the first run, add a sentence to the docstring that says no record is printed for exit code 2.
- In the second run, report the missing fact instead of adding it.

**Must Not**

- In the first run, leave the fact out because a comment already exists, or write it as a separate comment in the body.
- In the second run, make the comment longer.

**Owner**

`SKILL.md`, Operations, Improve, and Kinds.
