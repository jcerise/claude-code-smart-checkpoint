# Claude Code Smart Checkpoint System

A comprehensive context management system for Claude Code that intelligently decides when to compact vs. checkpoint+clear based on context quality and usage.

## Quick Start

1. **Create checkpoint directory**:
```bash
mkdir -p .claude/checkpoints
mkdir -p ~/.claude/commands  # for personal commands
```

2. **Install commands**:
```bash
# For project-specific (recommended)
cp smart-save.md .claude/commands/
cp checkpoint.md .claude/commands/
cp restore.md .claude/commands/
cp list-checkpoints.md .claude/commands/
cp diff-checkpoint.md .claude/commands/

# For personal (available in all projects)
cp smart-save.md ~/.claude/commands/
cp checkpoint.md ~/.claude/commands/
cp restore.md ~/.claude/commands/
cp list-checkpoints.md ~/.claude/commands/
cp diff-checkpoint.md ~/.claude/commands/
```

3. **Optional: Add to .gitignore or commit**:
```bash
# Option A: Keep checkpoints local
echo ".claude/checkpoints/" >> .gitignore

# Option B: Share with team
git add .claude/commands/ .claude/checkpoints/
git commit -m "Add checkpoint system"
```

## Commands Overview

### `/smart-save [name]` - The Smart Choice
**The main command.** Analyzes your context and recommends the optimal strategy.

```bash
/smart-save end-of-day
```

**What it does:**
1. Analyzes context usage (how full is your window?)
2. Evaluates context quality (how much noise vs signal?)
3. Recommends one of three strategies:
   - 🟢 **COMPACT**: Context clean, <60% full → preserve flow
   - 🟡 **CHECKPOINT + COMPACT**: 60-80% full → backup + compress
   - 🔴 **CHECKPOINT + CLEAR**: >80% full OR high noise → fresh start

**Token savings:**
- Compact: ~0-20% (maintains continuity)
- Checkpoint + Compact: ~30-50% (persistent backup)
- Checkpoint + Clear: ~60-80% (maximum efficiency)

### `/checkpoint [name]` - Quick Save
Fast, structured checkpoint without analysis.

```bash
/checkpoint before-refactor
```

Good for:
- Quick saves at natural breakpoints
- You already know you want just a backup
- Saving without affecting current context

### `/restore [name]` - Load Checkpoint
Restore from a saved checkpoint with minimal tokens.

```bash
/restore end-of-day
```

**Loads:**
- Structured checkpoint data (~1-3k tokens)
- File references (not full content unless requested)
- Todo list and next steps

**Saves ~60-70% vs compact** with fresh, clean context.

### `/list-checkpoints` - Browse Saves
See all available checkpoints with metadata.

```bash
/list-checkpoints
```

Shows:
- Checkpoint names and dates
- Task descriptions
- Status/progress
- Quick actions

### `/diff-checkpoint [name]` - Track Progress
Compare current state with a checkpoint.

```bash
/diff-checkpoint start-of-day
```

Shows:
- Files changed since checkpoint
- Todos completed
- Time elapsed
- Progress summary

## Usage Patterns

### Daily Workflow

```bash
# Morning: Start fresh
/restore end-of-yesterday

# Work throughout day...

# Afternoon: Context getting full
/smart-save lunch-break
# → Recommends checkpoint + compact

# Evening: End of day
/smart-save end-of-day
# → Creates checkpoint, then you can /clear
```

### Feature Development

```bash
# Start of feature
/checkpoint feature-start

# Midpoint check
/diff-checkpoint feature-start
# See progress since start

# Before risky refactor
/checkpoint before-refactor

# After completed
/smart-save feature-complete
# → Saves and cleans context
```

### Team Collaboration

```bash
# Before handing off
/checkpoint handoff-to-alice
git add .claude/checkpoints/handoff-to-alice.md
git commit -m "Checkpoint for Alice"
git push

# Alice picks up
git pull
/restore handoff-to-alice
```

## Context Strategy Decision Tree

```
Is context >80% full?
├─ YES → /smart-save [name] → CHECKPOINT + CLEAR
└─ NO ↓

Is context >60% full?
├─ YES → /smart-save [name] → CHECKPOINT + COMPACT
└─ NO ↓

Lots of failed attempts, errors, tangents?
├─ YES → /smart-save [name] → CHECKPOINT + CLEAR
└─ NO ↓

Natural breakpoint (end of day, feature done)?
├─ YES → /checkpoint [name]
└─ NO → Continue working, maybe /compact if needed
```

## File Structure

```
.claude/
├── commands/
│   ├── smart-save.md          # Main intelligent command
│   ├── checkpoint.md          # Quick checkpoint save
│   ├── restore.md             # Load checkpoint
│   ├── list-checkpoints.md    # Browse checkpoints
│   └── diff-checkpoint.md     # Compare with checkpoint
└── checkpoints/
    ├── end-of-day.md
    ├── feature-complete.md
    ├── before-refactor.md
    └── oauth-impl.md
```

## Checkpoint Format

Checkpoints are structured markdown:

```markdown
# Checkpoint: [name]
**Date:** 2025-11-08T14:30:00Z
**Strategy Used:** CHECKPOINT+CLEAR
**Estimated Token Savings:** 70%

## Executive Summary
[2-3 sentences of what was done]

## Files Changed
[List of files]

## Key Decisions
- **Decision**: Choice - Rationale

## Todo
- [ ] Next task
- [ ] Following task

## Next Steps
1. Immediate action
2. Then this
```

## Advanced: Automation

### Auto-checkpoint on commit

Create `.claude/hooks/pre-commit.md`:
```markdown
---
description: Auto-checkpoint before commits
---
Before committing, create checkpoint:
`/checkpoint pre-commit-$(date +%Y%m%d-%H%M%S)`
```

### Scheduled checkpoints

In your shell's crontab:
```bash
# Every 2 hours during work day
0 9-17/2 * * 1-5 echo "/checkpoint auto-$(date +%H%M)" | claude
```

## Tips

### Token Optimization
- Use YAML format for ultra-compact checkpoints
- Reference files by path, don't duplicate content
- Keep decisions terse: "Redis (auto-expiration)" vs long explanation
- Use bullet points, not prose

### When to Use What
- **Active coding**: Just work, Claude manages context
- **Getting stuck**: `/smart-save debug` → fresh start
- **End of session**: `/checkpoint end-of-day`
- **Starting session**: `/restore end-of-day`
- **Before risky change**: `/checkpoint before-X`
- **Context full**: Let `/smart-save` decide

### Team Best Practices
- Commit important checkpoints to git
- Use consistent naming: `feature-auth-YYYYMMDD`
- Add checkpoint links to PR descriptions
- Use `/diff-checkpoint` for standup reports

## Comparison: Checkpoint vs Compact

| Aspect | /compact | /checkpoint + /clear |
|--------|----------|---------------------|
| Token usage | ~4-8k | ~1-3k |
| Preserves reasoning | ✅ Yes | ❌ No |
| Removes noise | Partial | ✅ Complete |
| Persistent | ❌ Session only | ✅ File-based |
| Version control | ❌ No | ✅ Yes |
| Team sharing | ❌ No | ✅ Yes |
| Token savings | ~20-40% | ~60-80% |
| Best for | Continuing work | Fresh restart |

## Troubleshooting

**"Checkpoint file not found"**
```bash
ls .claude/checkpoints/  # Check if exists
/list-checkpoints        # See available
```

**"Too many checkpoints"**
```bash
# Clean up old ones
rm .claude/checkpoints/old-*.md
# Or keep only recent
find .claude/checkpoints -mtime +7 -delete
```

**"Context still full after checkpoint"**
- Did you `/clear` after checkpoint?
- Use `/smart-save` instead of manual `/checkpoint`

## Why This System?

**Traditional /compact:**
- Keeps conversation history (with noise)
- Session-only (lost on restart)
- Can't review what was saved

**This checkpoint system:**
- Explicit, reviewable saves
- Extreme token efficiency (60-80% savings)
- Persistent across sessions
- Version controlled
- Team shareable
- Smart recommendations

**Best of both:** Use `/smart-save` to get AI-recommended strategy for each situation.

## Next Steps

1. Install the commands
2. Try `/smart-save test-checkpoint` 
3. See the analysis and recommendation
4. Use `/restore test-checkpoint` to see the savings
5. Adjust to your workflow

Happy context management! 🚀
