# Review

Read this reference when the user asks to review comments.

It owns what a review checks and how findings are reported. `SKILL.md` owns every rule a comment must meet, including the Final check.

A review does not modify code unless the user also requests writing, rewriting, or editing.

## What to check

Review each comment against the Final check in `SKILL.md`.

Check each comment against the current code. Flag a mismatch instead of assuming that either is correct.

Identify different terms used for the same concept and one term used for different concepts. Compare comments with code identifiers and authoritative project terminology. Prefer the established term, but do not merge technically distinct concepts merely to make wording uniform.

Suggest clearer naming or structure when that would remove the need for a comment, but do not refactor.

Report commented-out code, because it may have been forgotten.

## Severity and order

Give each finding a severity. Order findings by impact:

| Severity | Impact |
|---|---|
| 🔴 High | A protected, incorrect, or misleading comment |
| 🟡 Medium | Missing information needed for correct use |
| 🟡 Medium | Inconsistent terminology |
| 🟢 Low | Unnecessary detail or repetition |
| 🟢 Low | Minor wording and style issues |

Within each row, use source order unless another order makes the locations easier to find.

## Overview

For three or more findings, start with an `Overview` of at most three bullets:

- the counts by severity, in a sublist;
- the main finding;
- the first action.

```text
## Overview

- Five findings
    - 🟡 Medium — 3
    - 🟢 Low — 2
- The take_damage summary claims a hit flash that never plays.
- Rewrite the take_damage summary.
```

## Finding form

Use this form for each distinct finding. The heading names the issue in a few words. The severity sits on its own line and carries a word. Each label is bold and sits on its own line.

````text
### <issue in a few words>

<emoji> **<High|Medium|Low> Severity**

**Location**

<declaration, line, or nearby code>

**Before**

```<language>
// Existing comment.
```

**After**

```<language>
// Suggested comment.
```

**Reason**

<why the change improves accuracy, clarity, consistency, or brevity>
````

For removal, put `Remove the comment.` in a fenced `text` block under **After**.

When safe wording cannot be proposed because intent, terminology, or contract information is unknown, report the issue, omit **After**, and ask one focused question. Do not invent the missing meaning.

### Example

````text
### Hit flash claim

🟡 **Medium Severity**

**Location**

`take_damage()`, line 58

**Before**

```gdscript
## Applies damage to the enemy. It also plays a hit flash effect.
```

**After**

```gdscript
## Subtracts the damage from health.
## Frees the enemy when health drops to 0 or below.
```

**Reason**

The old comment claims a hit flash.
The code only sets `_flash_timer`, and nothing reads it.
````

## Grouped findings

Group comments only when they have the same issue and recommended change. For each group:

- show one representative **Before** and **After**;
- list every affected location under **Location**, using precise file paths, line numbers, identifiers, or nearby declarations;
- report exceptions as separate findings.
