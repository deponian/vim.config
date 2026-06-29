See AGENTS.md for project conventions.

On first use, create symlinks so Claude Code discovers existing skills and agents:
```
mkdir -p .claude/skills/nvim-e2e-workflow .claude/skills/codediff-developer
ln -sf ../../.github/skills/nvim-e2e-workflow/SKILL.md .claude/skills/nvim-e2e-workflow/SKILL.md
ln -sf ../../.github/agents/codediff-developer.agent.md .claude/skills/codediff-developer/SKILL.md
```
