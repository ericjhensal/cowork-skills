---
name: foucault-env
description: "Load FOUCAULT machine environment reference. Use at the start of any session or when Claude needs to know what tools, packages, paths, or configurations are available on Eric's computer."
---

# FOUCAULT Environment Loader

Read the file `FOUCAULT.md` from this skill's directory to understand Eric's full machine setup, tool paths, installed packages, git configuration, and work preferences.

## Steps

1. Determine the skills repo location. Check these in order:
   - Adjacent to this SKILL.md: look for `../../FOUCAULT.md` relative to this file
   - In the session's .claude/skills directory: `/sessions/*/mnt/.claude/skills/foucault-env/FOUCAULT.md`
   - Clone from GitHub if needed: `git clone https://github.com/ericjhensal/cowork-skills.git`

2. Read FOUCAULT.md and internalize the contents — paths, packages, preferences, known issues.

3. Use this context throughout the session. Do not ask Eric for information that is already documented there.

## When to Use
- Start of any new session (recommended)
- Before suggesting Eric install any tool (check if it's already installed)
- Before writing scripts that reference file paths on FOUCAULT
- When troubleshooting git, Python, Node, or other tool issues
