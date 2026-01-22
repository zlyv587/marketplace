# GUI Agent Dev

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Development toolkit for GUI automation agents - specialized Claude Code agents, commands, and skills for building AI-powered desktop automation using multimodal LLMs and PyAutoGUI.

**[📋 Changelog](./CHANGELOG.md)** | **[🔄 Check for Updates](https://github.com/zlyv587/marketplace#checking-for-updates)**

## Features

### Commands (1)

| Command | Purpose |
|---------|---------|
| `/dev` | Automated 6-step development workflow with auto-selected domain agents |

### Agents (8)

**Domain Agents** - Specialized expertise for GUI automation:

| Agent | Purpose | Color |
|-------|---------|-------|
| `prompt-engineer` | Optimize LLM system prompts for GUI automation | Cyan |
| `plan-debugger` | Debug failed automation tasks and execution traces | Yellow |
| `context-optimizer` | Improve token efficiency and KV-cache performance | Green |
| `action-designer` | Design new action types with proper schemas | Magenta |
| `screenshot-analyzer` | Analyze coordinates and grid overlay issues | Blue |

**Workflow Agents** - General development workflow:

| Agent | Purpose | Color |
|-------|---------|-------|
| `code-explorer` | Analyze codebase, trace execution paths, map patterns | Yellow |
| `code-architect` | Design solutions, provide 2-3 options with trade-offs | Green |
| `code-reviewer` | Review code for bugs, quality, and convention compliance | Red |

### Skills (1)

| Skill | Purpose |
|-------|---------|
| `gui-agent-code-review` | Domain-specific code review covering all 5 domain agents |

## Installation

```bash
/plugin install gui-agent-dev@developer-kits
```

## Usage

### /dev Command (Recommended)

The `/dev` command runs an automated 6-step development workflow:

```bash
/dev "add drag and drop action"
/dev "fix click coordinates being off by 10%"
/dev "optimize token usage in context manager"
```

**Workflow Steps:**

| Step | Action | Agent Used |
|------|--------|------------|
| 1 | Clarify requirements | Command + auto-selected domain agent |
| 2 | Explore codebase | `code-explorer` + domain context |
| 3 | Draft 2-3 solutions | `code-architect` + interactive selection |
| 4 | Implement chosen plan | Domain agent leads |
| 5 | Review code changes | `code-reviewer` + domain agent |
| 6 | Generate test plan | Domain agent |

**Auto-Selection:** The command automatically detects the task type and selects 1-2 relevant domain agents:

| Keywords | Domain Agent Selected |
|----------|----------------------|
| action, drag, click, mouse, keyboard | `action-designer` |
| prompt, instruction, LLM | `prompt-engineer` |
| token, context, memory, KV-cache | `context-optimizer` |
| coordinate, screenshot, grid | `screenshot-analyzer` |
| fail, debug, error, fix | `plan-debugger` |

### Direct Agent Usage

Agents also trigger automatically based on context:

- **prompt-engineer**: "Help me improve this system prompt"
- **plan-debugger**: "The agent clicked on the wrong button"
- **context-optimizer**: "The agent is using too many tokens"
- **action-designer**: "I need to add a drag action"
- **screenshot-analyzer**: "Why are the coordinates off?"

### Code Review Skill

The code-review skill triggers on:
- "review code", "code review", "check my changes"
- "review this PR", "review my implementation"

It applies review criteria from all 5 domain agents.

## Structure

```
gui-agent-dev/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── dev.md                    # 6-step dev workflow
├── agents/
│   ├── prompt-engineer.md        # Domain: prompts
│   ├── plan-debugger.md          # Domain: debugging
│   ├── context-optimizer.md      # Domain: context
│   ├── action-designer.md        # Domain: actions
│   ├── screenshot-analyzer.md    # Domain: screenshots
│   ├── code-explorer.md          # Workflow: exploration
│   ├── code-architect.md         # Workflow: planning
│   └── code-reviewer.md          # Workflow: review
└── skills/
    └── code-review/
        ├── SKILL.md
        └── references/
            ├── review-checklist.md
            └── common-patterns.md
```

## Target Projects

This plugin is designed for GUI automation agents that use:
- **Multimodal LLMs** (Gemini, Anthropic Claude, GPT-4V) for vision-based automation
- **PyAutoGUI** for mouse/keyboard control
- **Normalized coordinates** (0.0-1.0) for resolution independence
- **Screenshot analysis** with grid overlays for element location
- **Structured outputs** (Pydantic/JSON) for action planning

### Typical Project Structure

```
your-gui-agent/
├── agent.py              # Main agent orchestrator
├── context_manager.py    # LLM context/history management
├── config.py             # Configuration settings
└── screenshots/          # Debug screenshots
```

## License

MIT
