# Odin, core library style

Odin has no dedicated doc-comment syntax.
This template follows the style of Odin's core library.
A `/* */` block directly above a procedure documents it.
A `//` line directly above `package` documents the package.
Odin's own tester compiles `Example:` and checks `Output:` only for `core/` packages.
In other code, nothing runs them.
Sources: the odin-lang.org overview, and two files in the odin-lang/Odin repository, core/strings/strings.odin and the documentation tester in its tests folder. Read 2026-09-23.

Procedures:

```odin
/*
<what it does or returns>

Inputs:
- <param>: <meaning, units, valid range>

Returns:
- <result>: <what it returns, and when>

Example:

	<a short example>

Output:

	<what the example prints>
*/
<name> :: proc(<param>: <Type>) -> (<result>: <Type>) {
}
```

Packages:

```odin
// <what the package is for>
package <name>
```
