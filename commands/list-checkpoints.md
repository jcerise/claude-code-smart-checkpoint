---
description: List and compare available checkpoints
---

List all available checkpoints in `.claude/checkpoints/`

## Step 1: Find Checkpoints

1. Run: `ls -lh .claude/checkpoints/*.md`
2. Parse checkpoint files

## Step 2: Generate Summary Table

For each checkpoint, extract:
- Name
- Date created
- Main task (from checkpoint content)
- Size (token estimate)
- Status (from checkpoint)

Present as table:

```
Available Checkpoints:
┌─────────────────────┬─────────────┬──────────────────────┬────────┐
│ Name                │ Date        │ Task                 │ Status │
├─────────────────────┼─────────────┼──────────────────────┼────────┤
│ oauth-impl          │ 2h ago      │ OAuth2 integration   │ 80%    │
│ end-of-day          │ 1 day ago   │ Feature complete     │ Done   │
│ before-refactor     │ 3 days ago  │ API refactor prep    │ -      │
└─────────────────────┴─────────────┴──────────────────────┴────────┘
```

## Step 3: Quick Actions

Offer:
```
Commands:
- /restore [name] - Load a checkpoint
- /diff [name1] [name2] - Compare two checkpoints  
- /delete [name] - Remove a checkpoint
- /show [name] - Display checkpoint contents

Most recent: [checkpoint-name]
```

## Step 4: Recommendations

If multiple checkpoints for same feature:
- "You have 3 checkpoints for 'oauth-impl'. Consider cleaning up old ones."

If no checkpoints:
- "No checkpoints found. Use /smart-save or /checkpoint to create one."

If very old checkpoints:
- "Checkpoint 'feature-x' is 2 weeks old. Archive or delete?"
