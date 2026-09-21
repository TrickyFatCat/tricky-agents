# Review Criteria

Read this reference in review mode.

This file owns what is wrong with a document, and how to report it.

## Boundary

Review produces findings. It produces no edited document, no corrected
version, and no file changes. `SKILL.md` owns that rule; this file works
inside it.

## Order Of Passes

1. Confirm purpose, mode, intended reader and reader goal.
2. Map each section's responsibility and the reader's path.
3. Check progression, duplication, misplaced detail, mixed purposes and
    navigation.
4. Assess terminology, density, abstraction and tone where they affect reader
    success.
5. Convert only material reader impact into findings.

Run the whole-document pass before local prose critique. Structure changes how
individual passages read.

## Self-Review

When the document was drafted by this agent earlier in the same session, say
so, and re-check every claim against its authority.

Drafting-session memory is not verification. The claim was as likely to be
wrong when it was written as it is now.

## Unclear Reader As A Finding

When the intended reader is ambiguous and the user cannot supply it, assess
the document against the reader it implies, and report the ambiguity itself.

A document that does not make its reader clear is a real defect, not a gap in
the review.

## Severity

| Mark      | Meaning                                                  |
| --------- | -------------------------------------------------------- |
| 🔴 High   | Blocks reader success, causes unsafe action, or misleads |
| 🟡 Medium | Confuses, slows down, or leaves an important gap         |
| 🟢 Low    | Polish, consistency, minor readability                   |

Within one conversation, `✅ Accepted` marks a finding the user resolved or
judged intentional, and `⛔ Declined` marks one they rejected. Do not repeat a
declined finding without new evidence.

## Finding Shape

The heading names what distinguishes this finding from the others, in at most
four words. The severity mark never sits in the heading.

Severity goes on its own line below the heading, and carries its word. A
coloured mark alone makes the reader recall a legend.

```markdown
### 3. Non-existent skill in example

🟡 **Medium Severity**

`install.nu --skill combat` is offered as a runnable command. No skill called
`combat` exists.

**Where**

Flags, under Install. Line 81.
```

The observed problem follows the severity line with no label, because the
heading already named it.

## Finding Fields

Add only the fields that make a finding clearer. There is no `What` field; the
heading carries it.

```text
Where           The section or heading, then a line number if it helps
Evidence        Source, project rule, or inspected content
Condition       Audience, version, platform or workflow limit
Reader impact   Likely failure, risk, confusion or maintenance cost
Direction       A focused improvement, not a rewrite
Example         A small replacement, when it makes the direction reviewable
```

`Where` names a section. A bare line number moves with the next edit, and it
does not tell the reader which part of the document is wrong.

`Reader impact` opens with the failure, risk or cost. Context that is not
itself an impact goes after it, or is cut.

Do not repeat the same rationale under two labels.

## Reporting

- Report at most five findings by default. Expand only when asked.
- Review in document order when that helps the user apply findings.
- Group by file for a multi-file review, in a stable order.
- Prioritise plausible reader failures over exhaustive criticism.
- Name specific good decisions and why they help. No generic praise.

## Tone

Be a thoughtful senior peer. Be direct about real problems, do not shame the
writer for gaps, and do not overpraise weak documentation.
