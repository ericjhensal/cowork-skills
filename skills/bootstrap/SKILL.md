---
name: bootstrap
description: "Pull persistent skills from GitHub into the current Cowork session. Run this at the start of every new session to restore your custom skills and environment."
---

# Bootstrap Skill — Restore Persistent Skills from GitHub

This skill clones the user's skills repository from GitHub and installs all custom skills into the current Cowork session.

## Steps

1. **Clone the skills repo** into the working directory:
   ```bash
   git clone https://github.com/ericjhensal/cowork-skills.git /sessions/*/cowork-skills-repo 2>/dev/null || (cd /sessions/*/cowork-skills-repo && git pull)
   ```
   (Use the actual session path, e.g., `/sessions/funny-jolly-lamport/cowork-skills-repo`)

2. **Copy each skill folder** from the cloned repo into `.claude/skills/`:
   ```bash
   cp -r /sessions/*/cowork-skills-repo/skills/*/ /sessions/*/mnt/.claude/skills/
   ```

3. **Verify installation** by listing the skills:
   ```bash
   ls -la /sessions/*/mnt/.claude/skills/
   ```

4. **Report to the user** which skills were installed and confirm they're ready to use.

## Notes
- The GitHub repo is: https://github.com/ericjhensal/cowork-skills
- If git is not available, check if the outputs folder has a local backup at `/sessions/*/mnt/outputs/cowork-skills/`
- If the repo doesn't exist yet, inform the user they need to run the setup script on FOUCAULT first
- Always use the actual session directory name (check with `ls /sessions/`)
