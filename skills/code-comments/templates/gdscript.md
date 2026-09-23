# GDScript, Godot 4

GDScript has no `@param` tag.
Name a parameter inside a sentence with `[param name]`.
Source: Godot stable documentation, "GDScript documentation comments", read 2026-09-23.

Functions:

```gdscript
## <what it does or returns>
## <how [param <name>] is used, with units and valid range>
func <name>(<name>: <Type>) -> <Type>:
```

Exported values, shown as Inspector tooltips:

```gdscript
## <what the value does>
## <its units and range>
@export var <name>: <Type>
```
