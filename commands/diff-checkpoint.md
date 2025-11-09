---
description: Compare current session with a checkpoint
argument-hint: [checkpoint-name]
---

Compare current state with checkpoint: `$ARGUMENTS`

## Step 1: Load Checkpoint Reference

Read `.claude/checkpoints/$ARGUMENTS.md` to get:
- Date checkpoint was created
- Files that were modified at checkpoint time
- Todo list at checkpoint
- Git commit at checkpoint (if recorded)

## Step 2: Current State Analysis

Analyze what's happened since checkpoint:

### File Changes
```bash
# If checkpoint has a git commit reference
git diff [checkpoint-commit] --name-status

# Otherwise, check modified dates vs checkpoint date
```

Present as:
```
Files since checkpoint:
✅ No changes: file1.ts, file2.ts
📝 Modified: oauth.ts (+45 lines)
➕ New: encryption.ts
❌ Deleted: old-auth.ts
```

### Todo Progress
Compare checkpoint todos with current state:
```
Todo Progress:
✅ Token refresh logic (was pending, now done)
✅ Error handling (was pending, now done)
⏳ Integration tests (still pending)
➕ New todo: Update docs (not in original checkpoint)
```

### Time Elapsed
```
⏱️ Time since checkpoint: 2 hours 15 minutes
📊 Estimated progress: 40% (2/5 todos complete)
```

## Step 3: Session Summary

Summarize what happened since checkpoint:
```markdown
## Changes Since Checkpoint: $ARGUMENTS

**Time elapsed:** [duration]
**Files changed:** [count]
**Todos completed:** [count/total]

### Highlights
- [Major accomplishment 1]
- [Major accomplishment 2]
- [Issue encountered/resolved]

### Current State
[Brief description of where things are now]

### Drift Analysis
⚠️ Scope changes:
- [Any new todos not in original plan]
- [Any abandoned original todos]
```

## Step 4: Recommendation

Suggest next action:
```
Recommendation:
- ✅ Good progress, continue working
- 💾 Save new checkpoint (significant progress)
- 🔄 Context getting full, consider /smart-save
- ⚠️ Off track from checkpoint plan, review goals
```

## Use Cases

This is useful for:
- **End of session**: "How much did I accomplish?"
- **Daily standup**: "What did I do since yesterday?"
- **Progress check**: "Am I on track with the plan?"
- **Team handoff**: "Here's what changed since you last worked on this"
