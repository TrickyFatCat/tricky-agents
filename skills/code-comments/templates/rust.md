# Rust, rustdoc

`///` documents the item below it.
`//!` documents the enclosing module or crate.
Rustdoc has no parameter tag.
Name a parameter inside a sentence.
Code in `# Examples` runs as a doctest under `cargo test`.
Sources: rustdoc book, "How to write documentation"; Rust API Guidelines, C-FAILURE and C-EXAMPLE. Read 2026-09-23.

Items:

```rust
/// <what it does or returns>
/// <how `<param>` is used, with units and valid range>
///
/// # Errors
///
/// <when it returns an error>
///
/// # Panics
///
/// <when it panics>
///
/// # Safety
///
/// <what the caller must uphold, for an unsafe function>
///
/// # Examples
///
/// ```
/// <a short example that compiles>
/// ```
pub fn <name>(<param>: <Type>) -> <Type> {
}
```

Modules and crates:

```rust
//! <what the module or crate is for>
```
