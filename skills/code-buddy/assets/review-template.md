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

<one sentence: the main problem>

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

<what goes wrong, when, and why it matters>

**Fix Direction**

<a direction, not the fixed code>

### Bugs

#### <n>. <short name>

[One location]
`<file>:<line>` — `<function>`

[Or several locations sharing one cause]
- `<file>:<line>` — `<function>`
- `<file>:<line>` — `<function>`

<what goes wrong, when, and why it matters>

<how it was checked, with a link when one was opened; or "Not checked." and why>

[Only when the user must run something to check it]
<what the command changes>

```<language>
<command>
```

**Hint**

<a direction, not the fix>

### Architecture

#### <n>. <short name>

(same shape as Bugs)

### Names

#### <n>. <short name>

- `<file>:<line>` — `<name>`

<the problem, as a condition when it may be deliberate>

### Comments

#### <n>. <short name>

`<file>:<line>` — `<function>`

<the problem>

### Later

[Only in a prototype, for findings that matter only at a larger scale]

#### <n>. <short name>

(same shape as Bugs)

### Typos

| Location | Found | Fix |
|---|---|---|
| `<file>:<line>` | <found> | <fix> |
````

A Danger risk uses `> ⛔ **Danger**` in place of the Warning callout.
