# Code Reference

Read this reference when documenting a source-level API.

This file owns documenting a source-level API. The unit is an exported symbol.

## Public Surface

Document what is exported. Name the rule used to decide, because it differs by
language.

```text
Python        __all__, or absence of a leading underscore
TypeScript    export
Rust          pub
C#/Java       public
```

State the rule in the document when the boundary is not obvious.

## Entry Fields

Inherit the shared entry contract from [document-modes.md](document-modes.md),
and add these when they apply.

| Field       | When                                                      |
| ----------- | --------------------------------------------------------- |
| Raises      | The symbol can throw, and the caller must handle it       |
| Concurrency | Thread safety, async behaviour, or reentrancy matters     |
| Since       | The symbol was added after the first documented version   |
| Deprecated  | The symbol is scheduled for removal, with its replacement |

## Wording

These conventions come from Google's developer documentation style guide.

| Symbol kind           | First sentence                            |
| --------------------- | ----------------------------------------- |
| Data-returning method | An action verb                            |
| Boolean getter        | "Checks whether…"                         |
| Non-boolean getter    | "Gets the…"                               |
| Void method           | "Sets", "Updates", "Deletes", "Registers" |
| Callback              | "Called by…"                              |
| Constructor           | "Creates a…"                              |

For parameters and returns:

- Non-boolean: begin with "The" or "A".
- Boolean control: "If true, … If false, …".
- Boolean query: "True if …; false otherwise."
- Defaults: "Default: `value`".

Do not repeat the symbol name in its first sentence. Do not write "This class
does…".

## Grouping

Group by the reader's lookup path, not by file order. A caller looking for
"how do I build one of these" should not have to know which file the
constructor lives in.

## Verification Order

1. Symbol inventory — what is exported.
2. Per-symbol signature, parameter types, defaults, return type.
3. One direct call site, where it clarifies the contract.

Code intelligence tools give all three directly. See
[source-verification.md](source-verification.md) for the ladder when they are
absent.

## Sources

Fetched 2026-09-20.

- <https://developers.google.com/style/api-reference-comments>
