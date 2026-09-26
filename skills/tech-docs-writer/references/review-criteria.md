# Review Criteria

Read this reference in review mode.

This file owns what is wrong with a document, and how to report it.

## Boundary

Review produces findings. It produces no edited document, no corrected
version, and no file changes. `SKILL.md` owns that rule; this file works
inside it.

## Order Of Passes

1. Confirm purpose, mode, intended reader and reader goal.
2. Map each section's responsibility and the reader's path. Ask what question
    each section answers. A section that answers none is a finding, and so is
    a passage that belongs to no section.
3. Run the cold reader once, as `SKILL.md` describes. Check each of its
    questions against the source. A gap is a finding for a missing fact. A
    misreading is a finding for an unclear sentence. A question known from
    context, under the limits in `SKILL.md`, is not a finding. List it with
    what covers it. When the reader is only implied, say that the starting
    point is implied too. When no subagent tool is available, say "not
    checked by a cold reader".
4. Check progression, duplication, misplaced detail, mixed purposes and
    navigation.
5. Assess terminology, density, abstraction and tone where they affect reader
    success.
6. Check each sentence with the job test and the view test in `SKILL.md`,
    then against the writing conventions, which are loaded for review as well
    as for writing. A failed test is a finding, not an edit. A counted
    sentence, a section opening on a code block, and a flag explained only in
    a comment are defects a reader feels and rarely names.
7. Convert only material reader impact into findings.

Run the whole-document pass before local prose critique. Structure changes how
individual passages read.

## Self-Review

When the document was drafted by this agent earlier in the same session, say
so, and re-check every claim against its authority.

Drafting-session memory is not verification. The claim was as likely to be
wrong when it was written as it is now.

## Internal Review

A Write runs this pass after the cold-reader fixes, when it creates a document
or rewrites a whole one. It skips an edit to part of a document, and an edit
that changes no meaning.

1. Start one subagent in Review mode. Give it the finished document, the named
   reader, the starting point and the source paths. It runs no cold reader,
   because the Write already ran one.
2. It returns findings only, in the shape this file describes.
3. For each finding, the writer checks two things:
   - the source confirms it;
   - the named reader needs it.
4. The writer applies each finding that passes both, inside the same Write.
   This is the one case where a finding is applied without the user asking.
5. The writer lists every other finding in the report as declined, with the
   reason.

When the tool list has no subagent tool, skip the pass and say "not reviewed"
in the report. Never imitate the review in the writer's own context.

**Example**

A finding says a command reference lacks install steps for an optional export
plugin. The source confirms the steps. The page's reader only runs the command,
so the writer declines the finding as another reader's job.

## Feedback That Asks A Question

When feedback questions a claim rather than stating it is wrong, verify the
claim against its source and answer the question.

Change the passage only when the wording is what caused the doubt. Never
weaken or remove a correct claim because someone asked about it.

A reviewer asking whether an endpoint really returns `204` is asking for the
handler to be read. If it does, the reply says so and the document stands. If
the sentence around it was ambiguous, that sentence is fixed and the `204`
stays.

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

Within one conversation, the agent marks a finding `✅ Accepted` when the user
resolves it or judges it intentional, and `⛔ Declined` when they reject it. Do not repeat a
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

- Report the five most severe findings in full.
- List every other finding below them, one line each: severity word, the
    passage, the problem. Leave the list out when there are none. Expand one
    when asked.
- Review in document order when that helps the user apply findings.
- Group by file for a multi-file review, in a stable order.
- Prioritise plausible reader failures over exhaustive criticism.
- Name specific good decisions and why they help. No generic praise.

## Tone

Be a thoughtful senior peer. Be direct about real problems, do not shame the
writer for gaps, and do not overpraise weak documentation.
