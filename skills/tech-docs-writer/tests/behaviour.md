# Behaviour Tests

Nine High-severity scenario tests for this skill. Each names the file that
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
```
