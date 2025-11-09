---
description: Quick checkpoint save with structured format
argument-hint: [checkpoint-name]
---

Create a fast, structured checkpoint: `$ARGUMENTS`

## Generate Checkpoint

Create `.claude/checkpoints/$ARGUMENTS.md` with:

```markdown
# Checkpoint: $ARGUMENTS
**Date:** [ISO timestamp]
**Type:** Manual Checkpoint

## Current Task
[One sentence: what are we working on right now?]

## Files in Play
[List files from git status, or files we've been discussing]

## Progress
### Completed
- [What's done]

### In Progress  
- [What's being worked on now]

### Pending
- [What's next]

## Key Info
[Any critical decisions, gotchas, or context needed]

## Next Action
[The immediate next step when resuming]
```

## Save & Confirm

1. Write the checkpoint file
2. Stage it: `git add .claude/checkpoints/`
3. Report: "✅ Checkpoint '$ARGUMENTS' saved"
4. Ask: "Ready to continue, /compact, or /clear?"
