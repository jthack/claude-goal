# claude-goal

A Codex-style `/goal` command for Claude Code.

It gives Claude Code a persistent local goal state, Codex-inspired continuation instructions, pause/resume/clear/status controls, completion-audit guardrails, and an importer that can copy your existing Codex `/goal` history out of Codex's local SQLite database at `~/.codex/state_5.sqlite`.

## Install

```bash
git clone https://github.com/jthack/claude-goal.git
cd claude-goal
./install.sh
```

This installs:

- `~/.claude/skills/goal` as a symlink to this repo's `goal/` directory

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
/goal replace ship a better implementation
/goal list
/goal import-codex
/goal codex
```

When a goal is active, the command returns a Codex-style continuation prompt that wraps the objective in `<untrusted_objective>` and requires a completion audit before marking the goal complete.

## Notes

Claude Code custom skills do not currently expose reliable live per-turn token usage to markdown commands. Token budgets are therefore stored and displayed as soft budgets. Elapsed-time tracking is local and persistent.

## Test

```bash
python3 -m pytest tests
```
