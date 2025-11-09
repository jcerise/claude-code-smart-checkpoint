# Quick Reference Guide

## Command Cheat Sheet

### Primary Commands

```bash
/smart-save [name]          # 🧠 Smart analysis & recommendation
/checkpoint [name]          # 💾 Quick manual checkpoint  
/restore [name]             # 📂 Load checkpoint
/list-checkpoints           # 📋 Browse all checkpoints
/diff-checkpoint [name]     # 📊 Compare with checkpoint
```

## Decision Flow

```
┌─────────────────────────────────────┐
│     Start Working Session           │
└──────────────┬──────────────────────┘
               │
               ▼
     ┌─────────────────┐
     │ Context Full?   │
     └────┬───────┬────┘
         NO      YES
          │       │
          │       ▼
          │   ┌────────────────┐
          │   │ /smart-save    │
          │   │ [name]         │
          │   └────┬───────────┘
          │        │
          │        ▼
          │   ┌─────────────────────────┐
          │   │ Analyzes & Recommends:  │
          │   │ • COMPACT (clean)       │
          │   │ • CHECKPOINT+COMPACT    │
          │   │ • CHECKPOINT+CLEAR      │
          │   └────┬────────────────────┘
          │        │
          ▼        ▼
     Continue  Execute Strategy
     Working      │
          │       ▼
          └──> 📁 Checkpoint Saved
                   │
                   ▼
             Token Savings:
             • Compact: ~20%
             • +Checkpoint: ~40%  
             • +Clear: ~70%
```

## When to Use What

| Situation | Command | Why |
|-----------|---------|-----|
| Context >80% full | `/smart-save [name]` | Let AI decide best strategy |
| End of work day | `/checkpoint end-of-day` | Quick save before closing |
| Start of day | `/restore end-of-day` | Pick up where you left off |
| Before risky change | `/checkpoint before-refactor` | Safety net |
| After feature complete | `/smart-save feature-done` | Clean save + compress |
| Context messy/noisy | `/smart-save cleanup` | Fresh start recommended |
| Check progress | `/diff-checkpoint start` | See what changed |
| See all saves | `/list-checkpoints` | Browse available |

## Token Savings Breakdown

### Scenario: 2-hour session, 18k tokens used

**Option 1: /compact**
- Before: 18k tokens
- After: ~4-6k tokens (summary)
- Savings: ~33%
- Pro: Preserves reasoning flow
- Con: Still carries noise

**Option 2: /checkpoint + /compact**  
- Before: 18k tokens
- Checkpoint: 2k tokens (structured)
- After compact: 4k tokens
- Savings: ~40% + persistent backup
- Pro: Backup + compression

**Option 3: /checkpoint + /clear**
- Before: 18k tokens
- Checkpoint: 2k tokens
- After clear: 0 tokens (then restore = 2k)
- Savings: ~89% (18k → 2k)
- Pro: Maximum efficiency, fresh slate
- Con: Loses conversation flow

## File Locations

```
Project Structure:
.
├── .claude/
│   ├── commands/              # Your custom commands
│   │   ├── smart-save.md      # 🧠 Smart analyzer
│   │   ├── checkpoint.md      # 💾 Quick save
│   │   ├── restore.md         # 📂 Loader
│   │   ├── list-checkpoints.md # 📋 Browser
│   │   └── diff-checkpoint.md # 📊 Differ
│   └── checkpoints/           # Your saved checkpoints
│       ├── end-of-day.md
│       ├── feature-auth.md
│       └── before-refactor.md
```

## Quick Setup

```bash
# 1. Run installer
./install.sh project    # For this project
./install.sh personal   # For all projects
./install.sh both       # Both locations

# 2. Start Claude Code
claude

# 3. Try it out
/smart-save test
/restore test
/list-checkpoints
```

## Best Practices

### ✅ DO
- Use `/smart-save` when context is getting full
- Create checkpoints at natural breakpoints
- Use descriptive names: `feature-auth-complete`, `end-of-day-20251108`
- Commit important checkpoints to git for team sharing
- Review checkpoint before restoring: `/list-checkpoints`

### ❌ DON'T  
- Create checkpoint every 5 minutes (too many)
- Use generic names: `checkpoint1`, `temp`, `asdf`
- Checkpoint without any significant progress
- Restore without checking what's in it first

## Advanced Usage

### Team Workflow
```bash
# Developer A saves and pushes
/checkpoint handoff-oauth-impl
git add .claude/checkpoints/handoff-oauth-impl.md
git commit -m "OAuth checkpoint for handoff"
git push

# Developer B pulls and restores
git pull
/list-checkpoints
/restore handoff-oauth-impl
```

### Daily Routine
```bash
# Morning
/restore end-of-yesterday

# Work...

# Lunch
/diff-checkpoint end-of-yesterday  # See progress

# Afternoon - context getting full
/smart-save lunch-break           # Saves + compacts

# Evening
/checkpoint end-of-day
```

### Emergency Recovery
```bash
# Oh no, things went wrong!
/list-checkpoints                 # Find last good state
/restore before-refactor          # Go back
# Continue from known-good state
```

## Troubleshooting

**Command not found**
```bash
# Check if installed
ls .claude/commands/
ls ~/.claude/commands/

# Reinstall if needed
./install.sh project
```

**Checkpoint not found**
```bash
/list-checkpoints  # See what's available
ls .claude/checkpoints/
```

**Context still full after checkpoint**
```bash
# Make sure to clear after checkpoint
/checkpoint [name]
/clear             # ← Don't forget this step!
/restore [name]    # Now you have clean context
```

**Too many checkpoints**
```bash
# Clean up old ones
cd .claude/checkpoints/
rm old-*.md
# Or use git to track what's important
```

## Tips

💡 **Name checkpoints by feature/time**: `oauth-impl-1108` is better than `checkpoint1`

💡 **Commit important checkpoints**: Your team can use them too

💡 **Use `/diff-checkpoint` for standups**: "Here's what I did since yesterday"

💡 **Checkpoint before experiments**: Easy rollback if things don't work

💡 **Let `/smart-save` decide**: It's smarter than manual decisions

## Resources

- 📖 Full guide: `README.md`
- 📝 Example checkpoint: `example-checkpoint.md`
- 🛠️ Installation: `install.sh`
- 💬 Ask Claude: "Explain the checkpoint system"

---

**Remember**: The goal is to work efficiently, not to obsess over context management. When in doubt, use `/smart-save [name]` and let it decide! 🚀
