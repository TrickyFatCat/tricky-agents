---
name: sample-skill
description: >-
  Use this skill when the user asks to tidy loose files in a project folder
  into folders they name. Do not use it for code changes.
---

# Sample Skill

Tidy a project folder by moving loose files into the folders the user names.

## Rules

- The agent must ask before deleting a file.
- Only edit files the user named.
- Do not move hidden files.
- Report each move in one line.
