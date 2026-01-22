# plugin-updater

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Check for updates to installed Claude Code plugins from the developer-kits marketplace.

**[📋 Changelog](./CHANGELOG.md)** | **[🔄 Check for Updates](https://github.com/zlyv587/marketplace#checking-for-updates)**

## Features

- **Automatic version checking** - Compares installed plugins with latest versions
- **Clear update notifications** - Shows current vs latest version for each plugin
- **Direct update commands** - Provides ready-to-use update commands
- **Changelog links** - Quick access to see what changed
- **Flexible scope** - Check global plugins, project plugins, or both
- **Simple command** - Just type `/check-updates`

## Installation

```bash
/plugin install plugin-updater@developer-kits
```

## Usage

### Check for updates

**Default: Check global plugins only**

```bash
/check-updates
```

**Check project plugins only**

```bash
/check-updates --local
```

**Check all plugins (global + project)**

```bash
/check-updates --all
```

Aliases:
```bash
/plugin-updates
```

### Check Scope

- **Global plugins** (default): Plugins installed via `/plugin install` in `~/.claude/plugins`
- **Project plugins**: Plugins in the current project's `./plugins/` directory
- **All plugins**: Both global and project plugins

### Example Output

```
🔍 检查 Claude Code 插件更新...

📦 Updates Available:

1. claude-mem0
   当前版本: 1.6.0
   最新版本: 1.6.1
   更新日志: https://github.com/zlyv587/marketplace/blob/main/plugins/claude-mem0/CHANGELOG.md
   更新命令: /plugin install claude-mem0@developer-kits

✅ 已是最新版本:
   - claude-md-sync (1.0.0)
   - gui-agent-dev (1.1.0)

发现 1 个插件有更新
```

## How It Works

1. Fetches the latest version information from `versions.json` in the marketplace
2. Compares with installed plugin versions
   - **Global**: Checks `~/.claude/plugins` (default)
   - **Project**: Checks `./plugins/` in current directory
3. Reports any available updates with changelog links
4. Provides ready-to-use update commands

## Command Line Usage

You can also run the script directly:

```bash
# Check global plugins (default)
bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh

# Check project plugins only
bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh --local

# Check all plugins
bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh --all

# Show help
bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh --help
```

## Requirements

- **jq** - JSON parser (install with `brew install jq` on macOS)
- **curl** - For fetching version information (usually pre-installed)
- **Internet connection** - To check for updates

## Troubleshooting

### "jq: command not found"

Install jq:
```bash
# macOS
brew install jq

# Linux
sudo apt-get install jq
```

### "Cannot fetch version information"

Check your internet connection and ensure you can access:
```
https://raw.githubusercontent.com/james-heidi/developer-kits/main/versions.json
```

### No plugins detected

Ensure your plugins are installed in `~/.claude/plugins` and have a `.claude-plugin/plugin.json` file.

## Structure

```
plugin-updater/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/
│   └── check-updates.md     # /check-updates command
├── scripts/
│   └── check-updates.sh     # Update checking script
├── CHANGELOG.md
└── README.md
```

## License

MIT
