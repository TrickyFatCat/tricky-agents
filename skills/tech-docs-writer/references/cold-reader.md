# Cold Reader

Read this reference at stage 4 of every Write, and in Review.

This file owns how a reader who has not seen the source checks a finished
document, and what happens to each of its questions. `SKILL.md` owns when it
runs.

## Procedure

1. Start a subagent. Give it only the finished document, the named reader,
   and that reader's starting point: what they already know and have done.
   Give it no source, no draft history and no skill rules.
   `context-gate.md` owns how the starting point is settled.
2. Ask it to answer from the page alone:
   - What is this document for, and who is it for?
   - What do you do first?
   - Where the page names or shows a status or result, what does it mean?
   - Which terms or sentences did you not understand?

   Send these questions as written. Add no examples, hints or questions. A
   hint passes on what the writer knows, and the cold reader must not have it.
3. It returns questions only. It proposes no wording and edits nothing.
4. Check each question against the source:
   - a gap: when a table on the page lists that kind of item, put the fact in
     that item's row. Otherwise add it in its smallest form, such as one
     example case or one requirement note, in the section that owns it;
   - a misreading: rewrite the sentence;
   - the source cannot answer it: label the claim Unknown, as
     `source-verification.md` requires;
   - known from context: a line in the starting point answers it, or it asks
     about a standard term of the field or the standard behaviour of a
     platform the starting point names. It is standard when the field uses it
     widely and one search explains it. Change nothing. Nothing else counts
     as known from context.
   - not needed: the Job Test would cut the answer, such as output the reader
     does not check, act on or use. Change nothing, except a link the Job
     Test asks for, such as to another tool's configuration document.

   In an existing document, make these changes only in the sentences and
   blocks the task wrote or changed. When a fix belongs anywhere else,
   change nothing there, and mark the question outside the task, with the
   fix it needs.

   Doubt makes a question a gap, unless the Job Test cuts that kind of fact.
5. Run the cold reader once per Write. Do not run it again after the fixes.
   List each question in the report as fixed, open, known from context,
   not needed with the Job Test reason, or outside the task.

## Without A Subagent Tool

A subagent tool starts another agent with its own context, such as `Agent` or
`Task`. When the tool list has none, skip the check and say "not checked by a
cold reader" in the report. Never imitate the cold reader in your own context.
