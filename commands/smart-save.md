---
description: Analyze context quality and recommend optimal save strategy
argument-hint: [checkpoint-name]
---

# Smart Context Save Analysis

Analyze the current session and recommend the best save strategy for checkpoint: `$ARGUMENTS`

## Step 1: Context Assessment

Evaluate the current session:

1. **Estimate context window usage**:
   - Check how many messages in this conversation
   - Estimate total tokens used (rough calculation)
   - Determine if we're approaching limits (>70% = high, >50% = medium, <50% = low)

2. **Analyze context quality** by reviewing:
   - How many errors or failed attempts occurred?
   - How many "let me try a different approach" moments?
   - How much debugging output or error logs?
   - How many tangents or off-topic discussions?
   - Is the conversation mostly on-track or exploratory?

3. **Session productivity metrics**:
   - How many files successfully created/modified?
   - How many problems solved vs still debugging?
   - Clear progress toward goal vs spinning wheels?

## Step 2: Generate Recommendation

Based on analysis, provide clear recommendation:

### 🟢 COMPACT Recommended
**When**: Context usage <60% AND mostly clean, on-track session
**Benefit**: Preserve conversational flow and reasoning
**Token Impact**: Minimal savings, maintains continuity
```
Current context: ~45% full
Quality: High (minimal failed attempts, clear progress)
Recommendation: Use /compact to preserve reasoning flow
```

### 🟡 CHECKPOINT + COMPACT Recommended  
**When**: Context 60-80% full OR moderate noise but good progress
**Benefit**: Persistent backup + continued work with compressed context
**Token Impact**: ~30-50% savings after compact, plus persistent backup
```
Current context: ~65% full
Quality: Medium (some failed attempts, but good insights)
Recommendation: Create checkpoint, then /compact
This gives you a persistent backup and cleaner context
```

### 🔴 CHECKPOINT + CLEAR + RESTORE Recommended
**When**: Context >80% full OR high noise (many failures, errors, rabbit holes)
**Benefit**: Fresh start with only essential information
**Token Impact**: ~60-80% savings, cleanest possible slate
```
Current context: ~85% full
Quality: Low (many failed approaches, error dumps, tangents)
Recommendation: Save checkpoint, /clear, then restore
This will give you a fresh start with ~70% token savings
```

## Step 3: Execute Recommended Strategy

After presenting the recommendation, ask:
```
Would you like me to proceed with the [RECOMMENDED STRATEGY]?
Options:
1. Yes, proceed with recommendation
2. Use a different strategy (tell me which)
3. Just create checkpoint without clearing
```

## Step 4: Implementation

**If COMPACT selected:**
1. Run `/compact`
2. Confirm completion

**If CHECKPOINT + COMPACT selected:**
1. Create comprehensive checkpoint (use structured format below)
2. Save to `.claude/checkpoints/$ARGUMENTS.md`
3. Run `/compact`
4. Confirm both completed

**If CHECKPOINT + CLEAR + RESTORE selected:**
1. Create comprehensive checkpoint (use structured format below)
2. Save to `.claude/checkpoints/$ARGUMENTS.md`
3. Show me the checkpoint summary
4. Run `/clear`
5. Read the checkpoint file back
6. Provide context summary to continue working
7. Report token savings achieved

## Checkpoint Format (for all strategies)

Create `.claude/checkpoints/$ARGUMENTS.md`:

```markdown
# Checkpoint: $ARGUMENTS
**Date:** [ISO timestamp]
**Strategy Used:** [COMPACT/CHECKPOINT+COMPACT/CHECKPOINT+CLEAR]
**Estimated Token Savings:** [percentage]

## Session Analysis
- **Duration**: [estimate based on conversation]
- **Context Usage**: [percentage]
- **Quality Assessment**: [High/Medium/Low]
- **Primary Goal**: [what we were trying to accomplish]

## Executive Summary
[2-3 sentences: What was done, current state, what's next]

## Files Changed
```
[Output of git status --short or list of files discussed]
```

## Key Decisions
- **[Decision topic]**: [Choice made] - [Brief rationale]
- **[Decision topic]**: [Choice made] - [Brief rationale]

## Problems Solved
- **[Problem]**: [Solution] - [File/line reference if relevant]

## Current Todo
- [ ] [Next immediate task]
- [ ] [Following task]
- [ ] [Future task]

## Important Code Patterns
```[language]
[Any key code snippet worth preserving]
```

## Open Questions
- [Unresolved question or decision needed]

## Next Steps
1. [Immediate next action]
2. [Following action]
3. [After that]

## Session Metrics
- Files created: [number]
- Files modified: [number]
- Tests written: [number]
- Commits made: [number]

## Context for Next Session
[Anything critical for someone (or yourself) to know when picking this up]
```

## Final Output

Provide clear summary:
```
✅ Strategy Executed: [STRATEGY NAME]
📁 Checkpoint saved: .claude/checkpoints/$ARGUMENTS.md
💾 Token savings: ~[X]% ([Y]k → [Z]k tokens)
🎯 Current focus: [Brief description]
🚀 Next step: [Immediate next action]
```
