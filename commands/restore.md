---
description: Restore from a saved checkpoint
argument-hint: [checkpoint-name]
---

Restore from checkpoint: `.claude/checkpoints/$ARGUMENTS.md`

## Step 1: Load Checkpoint

1. Read `.claude/checkpoints/$ARGUMENTS.md`
2. Parse the checkpoint structure

## Step 2: Context Summary

Present a concise summary:

```
📁 Restoring: $ARGUMENTS
📅 Saved: [date from checkpoint]
🎯 Task: [main task]
📊 Status: [progress summary]
```

## Step 3: File Analysis

For each file mentioned in checkpoint:
1. Check if file exists
2. Note if it's been modified since checkpoint (git diff)
3. List files: ✅ unchanged, ⚠️ modified, ❌ missing

## Step 4: Context Reconstruction

Provide working context:

```markdown
## You were working on:
[Task description from checkpoint]

## Files you need:
[List key files - I'll read them if you want]

## Where you left off:
[Last completed action]

## Next steps:
[Todo list from checkpoint]

## Important context:
[Key decisions and gotchas]
```

## Step 5: Ready to Continue

Ask:
```
Ready to continue? I can:
1. Read the key files and start working
2. Show you what changed since checkpoint
3. Continue with specific file/task
4. List all available checkpoints

What would you like to do?
```

## Efficiency Notes

- **Token usage**: ~1-3k tokens (just the checkpoint + summary)
- **vs Full Compact**: ~60-70% savings
- **Fresh slate**: No conversation history loaded
- **Clean context**: Only structured data, no noise
