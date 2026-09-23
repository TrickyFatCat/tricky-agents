# Nushell

`help <command>` shows these comments.
The block directly above `def` is the command description.
A blank `#` line starts a new paragraph.
A comment after a parameter is that parameter's help.
Tested on Nushell 0.115.1.

```nu
# <what the command does, in one line>
#
# <more facts, one sentence per line>
def <name> [
    <arg>: <type>   # <meaning, units, valid range>
    --<flag>        # <what the flag changes>
] {
}
```
