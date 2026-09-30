# Review Template

Replace each `<placeholder>`.
Leave out a section with no findings, but keep its row in the Overview table with 0.
A line in square brackets is a note for you, not output. Leave out a block marked "Only when" unless its condition holds.

````markdown
```text
Review: <target>
Stage: <stage>
Lang: <language and version>
Framework: <engine or framework and version, or none>
Goal: <goal>
```

[Only when a value was assumed]
```text
Assumptions
<field>: <value> (<why it was assumed>)
```

### Overview

| Kind | Count |
|---|---|
| Risks | <n> |
| Bugs | <n> |
| Architecture | <n> |
| Names | <n> |
| Comments | <n> |
| Typos | <n> |

[Only when not every file in the target was read]
Read: <files> · Not read: <files>

[Only when there are no findings]
Checks ran: <checks>, against <help or docs used>.

### Risks

#### <n>. <short name>

> ⚠️ **Warning**
>
> <one sentence about the risk>

`<file>:<line>` — `<function>`

[Snippet only when it holds no secret; write <redacted> in place of a secret]
```<language>
<up to five lines of the file>
```

<what the code does at that line>

<the effect>

**Fix Direction**

- <step>
- <step>

### Bugs

#### <n>. <short name>

`<file>:<line>` — `<function>`

```<language>
<up to five lines of the file>
```

<what the code does at that line>

<the effect, with a concrete value>

[Only when it may be deliberate]
<one condition>

[Only when not checked]
Not checked. See Verification <n>.

[Only when a later finding shares the cause of an earlier one]
Same cause as finding <n>.

**Hint**

<a direction, not the fix>

### Architecture

#### <n>. <short name>

(same shape as Bugs)

### Names

#### <n>. <short name>

- `<file>:<line>` — `<name>`
- `<file>:<line>` — `<name>`

<the problem, as a condition when it may be deliberate>

### Comments

#### <n>. <short name>

`<file>:<line>` — `<function>`

```<language>
<the comment and the line it sits on>
```

<the problem>

### Later

[Only in a prototype, for findings that matter only at a larger scale]

#### <n>. <short name>

(same shape as Bugs)

### Typos

| Location | Found | Fix |
|---|---|---|
| `<file>:<line>` | <found> | <fix> |

### Verification

<n>. <how it was checked: help, docs, a test on made-up data, or reading the file>

<n>. Not checked. <why>
<what the command changes>

```<language>
<command for the user to run>
```
````

A Danger risk uses `> ⛔ **Danger**` in place of the Warning callout.
