# claude-goal

A Codex-style `/goal` command for Claude Code.

It gives Claude Code a persistent local goal state, Codex-inspired continuation instructions, pause/resume/clear/status controls, completion-audit guardrails, and a Stop hook that keeps Claude working while a goal is active.

## Install

```bash
git clone https://github.com/jthack/claude-goal.git
cd claude-goal
./install.sh
```

This installs:

- `~/.claude/skills/goal` as a symlink to this repo's `goal/` directory
- a user-level Claude Code `Stop` hook in `~/.claude/settings.json`

The `goal/` directory is the Claude skill package. It contains `SKILL.md`, `scripts/claude_goal.py`, and reference notes.

State is stored at:

```text
~/.claude/goal/goals.sqlite
```

## Usage

```text
/goal find and fix the flaky auth tests
/goal --tokens 250K do deep research and build the full prototype
/goal
/goal status
/goal pause
/goal resume
/goal clear
```

When a goal is active, the command returns a continuation prompt that wraps the goal text in `<objective>` and requires a completion audit before marking the goal complete.

## Notes

Claude Code custom skills do not currently expose reliable live per-turn token usage to markdown commands. Token budgets are therefore stored and displayed as soft budgets. Elapsed-time tracking is local and persistent.

The Stop hook blocks Claude from stopping while the current goal is active. It stops blocking when you run `/goal pause`, `/goal clear`, or `/goal complete`. A runaway guard defaults to 25 stop-hook continuations; override with `CLAUDE_GOAL_MAX_STOP_CONTINUES`.

## Test

```bash
python3 -m pytest tests
```
