#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.claude/skills" "$HOME/.claude/commands" "$HOME/.claude/goal"

ln -sfn "$ROOT/goal" "$HOME/.claude/skills/goal"
chmod +x "$ROOT/goal/scripts/claude_goal.py"

# Older installs created a legacy ~/.claude/commands/goal.md shim. Claude Code
# now exposes the skill itself as /goal, so keeping both produces duplicate
# entries in /help.
if [ -L "$HOME/.claude/commands/goal.md" ] && [ "$(readlink "$HOME/.claude/commands/goal.md")" = "$ROOT/goal.md" ]; then
  rm "$HOME/.claude/commands/goal.md"
fi

python3 "$ROOT/goal/scripts/claude_goal.py" import-codex >/dev/null 2>&1 || true

echo "Installed /goal for Claude Code."
echo "Skill: $HOME/.claude/skills/goal"
echo "State DB: $HOME/.claude/goal/goals.sqlite"
