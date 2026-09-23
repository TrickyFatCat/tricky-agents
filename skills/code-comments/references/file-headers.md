# File Headers

Read this reference when the task writes or reviews a comment at the top of a file.

It owns what a file header says and where it goes. `SKILL.md` owns how each sentence is written and which comments are protected.

## Contents

A header can state:

- the purpose of the file;
- how to run it;
- its arguments;
- its requirements, such as a language version or a tool;
- its side effects, such as files it writes or deletes.

Include only the parts that apply. A library file often needs only its purpose.

Do not repeat what a tool already prints from other comments. For example, Nushell's `help` shows the comments above `def main` and after each parameter. A header in that script leaves usage and arguments to those comments.

## Placement

The header goes after these lines, when the file has them:

1. a shebang line;
2. an encoding line;
3. a licence or copyright notice.

Leave these lines and every other protected comment unchanged. Do not insert the header between a directive and its target.

## Example

```python
#!/usr/bin/env python3
# Exports all localisation tables to CSV for the translation team.
#
# Usage: python export_localisation.py [--lang de] [--dry-run]
# Requires Python 3.11 or newer.
# Writes to Content/Localisation/Export/.
# Overwrites existing files there.
```
