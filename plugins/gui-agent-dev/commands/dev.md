---
name: dev
description: Automated development workflow for GUI automation agents - analyzes task, explores codebase, drafts solutions, implements, reviews, and generates test plan
argument-hint: "<task description>"
---

# GUI Agent Development Workflow

You are orchestrating an automated 6-step development workflow for a GUI automation agent project. Follow each step in order, using the appropriate agents and tools.

## Task Description

The user wants to: $ARGUMENTS

## Step 0: Detect Task Type and Select Domain Agents

Analyze the task description to determine:

1. **Task Type**: feature | fix | optimize
2. **Domain Agent(s)**: Select 1-2 based on keywords

**Domain Agent Selection Rules:**

| Keywords in Task | Select Agent |
|-----------------|--------------|
| action, drag, click, input, mouse, keyboard, hotkey, scroll | `action-designer` |
| prompt, instruction, system prompt, LLM, message | `prompt-engineer` |
| token, context, memory, KV-cache, compression, history | `context-optimizer` |
| coordinate, screenshot, grid, position, resolution, pixel | `screenshot-analyzer` |
| fail, debug, error, stuck, wrong, broken, fix | `plan-debugger` |

If multiple domains apply, select up to 2 most relevant agents.

**Announce your selection:**
```
Task Type: [feature/fix/optimize]
Domain Agent(s): [agent-name(s)]
```

---

## Step 1: Clarify Requirements

Ask 2-4 clarifying questions about the task. Include at least one domain-specific question based on your selected domain agent(s).

**General questions to consider:**
- What specific behavior should change?
- Are there any constraints or requirements?
- Should this maintain backward compatibility?

**Domain-specific questions:**

For `action-designer`:
- What parameters should this action accept?
- Should it support any variations (e.g., with modifiers)?

For `prompt-engineer`:
- What output format do you need from the LLM?
- Are there specific edge cases to handle in instructions?

For `context-optimizer`:
- What's the current token budget concern?
- Should this work with existing compression?

For `screenshot-analyzer`:
- What screen resolutions should this support?
- How precise do coordinates need to be?

For `plan-debugger`:
- Can you describe the failure scenario?
- Do you have screenshots of the failure?

Use the AskUserQuestion tool to collect answers before proceeding.

---

## Step 2: Explore Codebase

Launch the `code-explorer` agent to analyze the codebase.

**Prompt for code-explorer:**
```
Analyze the codebase to understand how to implement: [task description]

Focus on:
1. Entry points and core files related to this task
2. Existing patterns for similar functionality
3. Dependencies and integration points
4. [Domain-specific focus based on selected agent]

Provide file:line references for all key findings.
```

**After exploration, summarize:**
- Key files to modify
- Existing patterns to follow
- Dependencies to consider
- Domain-specific insights from [selected domain agent]

---

## Step 3: Draft Solution Plans

Launch the `code-architect` agent to draft 2-3 solutions.

**Prompt for code-architect:**
```
Based on the codebase exploration, design 2-3 solution options for: [task description]

Requirements from user:
[Include answers from Step 1]

Key files identified:
[Include findings from Step 2]

For each option, provide:
- Approach summary
- Pros and cons
- Effort level
- Files to modify
- Key implementation steps
```

**Present options to user using AskUserQuestion:**
Create an interactive choice with the solution options. Each option should include:
- Option name
- Brief description (1-2 sentences)

Example:
```
Option 1: [Name] - [Brief description]
Option 2: [Name] - [Brief description]
Option 3: [Name] - [Brief description]
```

Wait for user to select before proceeding.

---

## Step 4: Implement Solution

After user selects a plan, implement it using the selected domain agent's expertise.

**Implementation guidance by domain:**

For `action-designer`:
1. Add to ActionType enum
2. Add fields to NextAction model
3. Add dispatch case in InputController.execute()
4. Implement the action method with proper error handling
5. Update system prompt to document the new action

For `prompt-engineer`:
1. Identify prompt location(s)
2. Draft improved prompt text
3. Ensure structured output format is specified
4. Verify token efficiency
5. Test prompt clarity

For `context-optimizer`:
1. Identify context management code
2. Implement optimization
3. Verify KV-cache stability (stable prefix)
4. Test compression behavior
5. Verify token budget compliance

For `screenshot-analyzer`:
1. Identify coordinate handling code
2. Implement changes with normalized coordinates
3. Verify resolution independence
4. Test grid overlay if applicable
5. Add logging for debugging

For `plan-debugger`:
1. Identify failure point
2. Add error handling/logging
3. Implement fix
4. Add recovery mechanism if needed
5. Verify fix addresses root cause

**Write the code changes using Edit/Write tools.**

---

## Step 5: Review Code

Launch the `code-reviewer` agent to review the implementation.

**Prompt for code-reviewer:**
```
Review the code changes made for: [task description]

Focus on:
1. Bug detection and logic errors
2. Project convention compliance
3. [Domain-specific checks based on selected agent]
4. Error handling completeness
5. Performance implications

Only report issues with confidence >= 80.
```

Also apply the `gui-agent-code-review` skill criteria for domain-specific review.

**If issues found:**
1. Present issues to user
2. Fix critical issues
3. Re-review if needed

---

## Step 6: Generate Test Plan

Generate an e2e test plan for the user to execute manually.

**Test plan format:**

```markdown
## E2E Test Plan: [Feature Name]

### Prerequisites
- [ ] [Any setup required]

### Test Cases

#### Test 1: [Basic functionality]
**Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Result:**
[What should happen]

**How to Verify:**
[How to confirm it worked]

#### Test 2: [Edge case]
**Steps:**
1. [Step 1]
2. [Step 2]

**Expected Result:**
[What should happen]

#### Test 3: [Error handling]
**Steps:**
1. [Step 1 that should fail gracefully]

**Expected Result:**
[Expected error behavior]

### Domain-Specific Tests
[Include tests based on selected domain agent expertise]

### Rollback Plan
If tests fail:
1. [How to revert changes]
2. [What to check]
```

Present the test plan to the user.

---

## Workflow Complete

Summarize what was accomplished:
1. Task analyzed and domain agents selected
2. Requirements clarified
3. Codebase explored
4. Solution options presented and one selected
5. Implementation completed
6. Code reviewed and issues addressed
7. Test plan generated

Ask if the user needs any adjustments or has questions.
