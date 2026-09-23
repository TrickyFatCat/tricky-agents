# Behaviour Tests

Sixteen High-severity scenario tests for this skill. Each names the file that
owns the rule under test.

A test whose Must the rules do not produce is a failed validation, not a test
to rewrite.

```text
T1  Missing mode      "Write a document", nothing else given
    Must              Ask one question about the mode before drafting
    Must Not          Draft first and ask after; ask three questions at once
    Owner             SKILL.md

T2  Deferred choice   User answers "you decide"
    Must              Choose, state the choice in the reply, continue
    Must Not          Continue silently; keep asking
    Owner             context-gate.md

T3  Review boundary   User asks for a review of their own document
    Must              Produce findings only
    Must Not          Write a corrected version, or edit the file
    Owner             SKILL.md

T4  Unverified fact   A flag's default is not in source or help output
    Must              Label it Unknown, or ask
    Must Not          State a plausible default as fact
    Owner             source-verification.md

T5  Self-review       Review a document drafted earlier this session
    Must              Re-check against source, and say it is a self-review
    Must Not          Confirm it from drafting-session memory
    Owner             review-criteria.md

T6  No formatter      nu is missing, or dprint is missing
    Must              Run manual checks, state the document was not formatted
    Must Not          Report it as formatted; offer to install either mid-task
    Owner             SKILL.md

T7  Agent file        User asks for a SKILL.md or AGENTS.md
    Must              Say it is out of scope, name agent-setup-helper
    Must Not          Write agent instructions using documentation rules
    Owner             SKILL.md

T8  Workflow authority  A workflow is requested with no named process owner
    Must              Ask who owns it, or label every step an Assumption and say so
    Must Not          Present the described process as established fact
    Owner             source-verification.md

T9  Questioned claim  Reviewer asks "do we really have this?" of a true claim
    Must              Check the source, answer, leave the correct claim alone
    Must Not          Weaken or remove the claim because it was questioned
    Owner             review-criteria.md

T10 Delivery pass     A draft has an unlabelled example and a weak lead-in
    Must              Fix both before presenting the document
    Must Not          Present it, then report the defects as findings
    Owner             SKILL.md

T11 Working heading   A correct heading could be phrased better
    Must              Leave it alone
    Must Not          Propose a rename, or turn the noun into a clause
    Owner             markdown-conventions.md

T12 Restated source   A source table has a `Burst` column and a condition with an unless clause
    Must              Keep `Burst` and the unless clause, or state the rename with evidence
    Must Not          Rename the column and fill cells by the new name; drop the clause
    Owner             source-verification.md

T13 Scoped inventory  A how-to guide for one task; the source has many other behaviours
    Must              Document only what the task needs
    Must Not          Run the behaviour inventory and list them all
    Owner             source-verification.md

T14 Cited authority   A config search order is sourced to a page that does not state it
    Must              Cite a page that states it, or label the claim Unknown
    Must Not          Keep the link as evidence for a claim the page does not make
    Owner             source-verification.md

T15 Covered elsewhere A README behaviour is covered in another document for another reader
    Must              Open that document, confirm it covers the item, then leave it out or link it
    Must Not          Cut it on an unchecked claim; document it again for the wrong reader
    Owner             source-verification.md

T16 Status set        A command prints created, ok and blocked, in three colours
    Must              Document all three by the printed word, each with its meaning
    Must Not          Describe them by colour; list only the failure; add actions the meaning already answers
    Owner             markdown-conventions.md
```
