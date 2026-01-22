# claude-mem0

![Version](https://img.shields.io/badge/version-1.6.1-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Persistent memory for Claude Code using [mem0](https://mem0.ai) cloud API. Automatically captures and retrieves global user-level and project-level memories to provide personalized, context-aware assistance across sessions.

**[📋 Changelog](./CHANGELOG.md)** | **[🔄 Check for Updates](https://github.com/zlyv587/marketplace#checking-for-updates)**

## Features

- **Automatic memory retrieval** at session start
- **Automatic memory capture** on task completion and session end
- **Global memories** for user preferences (persists across all projects)
- **Project memories** for codebase-specific knowledge
- **Semantic search** for relevant context
- **Cloud-based storage** via mem0 API (no local database)

## Prerequisites

1. **mem0 API Key**: Get one from [mem0.ai](https://app.mem0.ai)
2. **uv** (Python package manager): Install with `curl -LsSf https://astral.sh/uv/install.sh | sh`

## Installation

1. Install the plugin:

   ```bash
   /plugin install claude-mem0
   ```

2. Add environment variables to your shell profile (`~/.zshrc` or `~/.bashrc`):

   ```bash
   export MEM0_API_KEY="m0-your-api-key-here"  # Get from https://app.mem0.ai/dashboard/api-keys
   export MEM0_USER_ID=$USER                    # Your unique identifier for memories
   ```

3. Reload your shell and restart Claude Code:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

## Configuration

| Variable       | Required | Description                                                              |
| -------------- | -------- | ------------------------------------------------------------------------ |
| `MEM0_API_KEY` | Yes      | Your mem0 API key from [mem0.ai](https://app.mem0.ai/dashboard/api-keys) |
| `MEM0_USER_ID` | Yes      | Your unique identifier for memories (recommend: `$USER`)                 |

The `app_id` for project-scoped memories is automatically derived from your git remote URL.

## How It Works

### Memory Scoping

| Scope       | Identifier           | Use Case                                           |
| ----------- | -------------------- | -------------------------------------------------- |
| **Global**  | `user_id` only       | User preferences, coding style, personal info      |
| **Project** | `user_id` + `app_id` | Architecture, patterns, project-specific knowledge |

App ID is automatically derived from your git remote URL (SHA-256 hash), ensuring consistent identification across clones.

### Automatic Hooks

| Hook             | Trigger        | Action                               |
| ---------------- | -------------- | ------------------------------------ |
| **PreToolUse**   | mem0 MCP call  | Auto-fix app_id/agent_id usage       |
| **SessionStart** | Session begins | Search and surface relevant memories |
| **Stop**         | Task completes | Prompt to capture learnings          |
| **SessionEnd**   | Session ends   | Prompt to capture session summary    |

#### Auto-Fix for Project Memory Scoping

The `PreToolUse` hook automatically validates and corrects mem0 tool calls:

- **Fixes `agent_id` → `app_id`**: If `agent_id` is used instead of `app_id`, it's corrected
- **Fixes repo name → hash**: If `app_id` contains a repo name instead of the 16-char hash, it's corrected
- **Non-git directories**: Removes `app_id` entirely (memory stored globally)

### MCP Tools

The plugin configures the official [mem0-mcp-server](https://github.com/mem0ai/mem0-mcp) which provides:

- `add_memory` - Store new memories
- `search_memories` - Semantic search
- `get_memories` - List with filters
- `get_memory` - Get by ID
- `update_memory` - Modify existing
- `delete_memory` - Remove by ID
- `delete_all_memories` - Bulk delete

## Usage Examples

### What to Remember

| Type        | Examples                                     | Scope          |
| ----------- | -------------------------------------------- | -------------- |
| **Global**  | Coding style, preferred tools, personal info | All projects   |
| **Project** | Architecture, tech stack, design decisions   | This repo only |

### Saving Memories

**Global memory** (no app_id - accessible everywhere):

```
"记住我喜欢用 2 空格缩进"
"Remember I prefer dark mode in all editors"
```

**Project memory** (with app_id - only in this repo):

```
"记住这个项目使用 React 18 + TypeScript"
"Remember this API uses JWT authentication"
```

Claude automatically determines the type based on content. To be explicit:

```
"保存为全局记忆：我喜欢简洁的代码注释"
"保存为项目记忆：数据库使用 PostgreSQL 15"
```

### Recalling Memories

```
"What do you know about my coding preferences?"
"这个项目用什么技术栈？"
"What decisions have we made about authentication?"
```

### Managing Memories

```
"Forget what I told you about my email"
"删除关于旧架构的记忆"
"Show me all memories for this project"
```

### How Claude Decides

Claude chooses memory type based on content:

- User preferences, personal info → **Global**
- Architecture, codebase patterns → **Project**

If info is available via other tools (e.g., `git remote`), Claude may use those instead of memories - this is expected behavior.

## Privacy

- Memories are stored in your mem0 cloud account
- Never stores credentials, API keys, or secrets
- Content marked as `<private>` is excluded
- You can delete memories at any time

## Troubleshooting

### MCP Server Not Starting

Ensure `uvx` is available:

```bash
which uvx
# If not found, install uv:
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### No Memories Found

1. Check your `MEM0_API_KEY` is set correctly
2. Verify your `MEM0_USER_ID` matches what was used to store memories
3. For project memories, ensure you're in a git repo with a remote

### Debug Mode

Run Claude Code with debug output:

```bash
claude --debug
```

Look for:

- MCP server initialization
- Hook execution
- Memory tool calls

## Architecture

```
claude-mem0/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── .mcp.json                    # MCP server config (mem0-mcp-server)
├── hooks/
│   ├── hooks.json               # Hook configuration
│   └── scripts/
│       ├── validate-mem0-call.sh # Auto-fix app_id/agent_id on mem0 calls
│       ├── on-session-start.sh  # Memory retrieval at session start
│       ├── on-stop.sh           # Memory capture on task completion
│       └── on-session-end.sh    # Memory capture on session end
├── skills/
│   └── mem0-memory/
│       └── SKILL.md             # Memory best practices
├── scripts/
│   └── get-app-id.sh            # Git remote hash utility for app scoping
└── README.md
```

## License

MIT

## Credits

- [mem0](https://mem0.ai) - Memory layer for AI
- [mem0-mcp-server](https://github.com/mem0ai/mem0-mcp) - Official MCP server
- Inspired by [claude-mem](https://github.com/thedotmack/claude-mem)
