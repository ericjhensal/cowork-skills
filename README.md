# Cowork Skills for FOUCAULT

Persistent custom skills for Claude Cowork sessions.

## Usage

At the start of each Cowork session, ask Claude to:
> "Bootstrap my skills from GitHub"

Or manually tell Claude:
> "Clone https://github.com/ericjhensal/cowork-skills and copy the skills into .claude/skills/"

## Structure

- skills/ — Custom SKILL.md files, one folder per skill
- scripts/ — Setup and utility scripts for FOUCAULT

## Adding New Skills

1. Create skills in Cowork as usual
2. Ask Claude to save them to outputs
3. Run sync-to-github.ps1 to push changes

