# Claude Code Marketplace

A collection of plugins for Claude Code.

## Available Plugins

| Plugin                                         | Version | Description                                                                                                                                      | Category     |
| ---------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------ |
| [claude-md-sync](./plugins/claude-md-sync)     | 1.0.0   | Automatically keeps CLAUDE.md synchronized with project state. Detects project type, analyzes current state, and proposes documentation updates. | Productivity |
| [claude-mem0](./plugins/claude-mem0)           | 1.6.1   | Persistent memory for Claude Code using mem0 cloud API. Automatically captures and retrieves global user-level and project-level memories.       | Productivity |
| [gui-agent-dev](./plugins/gui-agent-dev)       | 1.1.0   | Development toolkit for GUI automation agents with `/dev` command (6-step workflow), 8 agents (5 domain + 3 workflow), and code review skill.    | Development  |
| [plugin-updater](./plugins/plugin-updater)     | 1.0.0   | Check for updates to installed Claude Code plugins from the developer-kits marketplace. Use `/check-updates` command.                            | Maintenance  |

## Installation

### 1. Add this marketplace

```
/plugin marketplace add marketplace
```

### 2. Install a plugin

```
/plugin install claude-md-sync@developer-kits
/plugin install claude-mem0@developer-kits
/plugin install gui-agent-dev@developer-kits
/plugin install plugin-updater@developer-kits
```

## Checking for Updates

### Method 1: Using the plugin-updater plugin (Recommended)

Install the plugin-updater and use the `/check-updates` command:

```bash
# Install the plugin
/plugin install plugin-updater@developer-kits

# Check for updates anytime
/check-updates
```

This will automatically:
- Check all installed plugins against the latest versions
- Display available updates with version numbers
- Provide commands to update each plugin
- Show changelog links for each update

### Method 2: Using the update check script

```bash
# Clone or download the repository
git clone marketplace
cd developer-kits

# Run the update checker
bash scripts/check-updates.sh
```

The script will:
- Check all installed plugins against the latest versions
- Display available updates with version numbers
- Provide commands to update each plugin
- Show changelog links for each update

### Method 3: Manual check

Check the [versions.json](./versions.json) file for the latest version numbers, or visit the [Releases](https://github.com/zlyv587/marketplace/releases) page.

### Method 4: Using Claude Code commands

```bash
# Update a specific plugin
/plugin install <plugin-name>@developer-kits

# This will fetch and install the latest version
```

## Updating Plugins

To update a plugin to the latest version:

```bash
/plugin install <plugin-name>@developer-kits
```

Example:
```bash
/plugin install claude-mem0@developer-kits
```

## Version History

Each plugin maintains its own changelog:
- [claude-md-sync CHANGELOG](./plugins/claude-md-sync/CHANGELOG.md)
- [claude-mem0 CHANGELOG](./plugins/claude-mem0/CHANGELOG.md)
- [gui-agent-dev CHANGELOG](./plugins/gui-agent-dev/CHANGELOG.md)
- [plugin-updater CHANGELOG](./plugins/plugin-updater/CHANGELOG.md)

## For Plugin Developers

### Automatic Version Management

The `versions.json` file is automatically generated from each plugin's `plugin.json` file. You don't need to manually maintain it.

#### Local Generation

To regenerate `versions.json` locally:

```bash
bash scripts/generate-versions.sh
```

#### Automatic Updates via GitHub Actions

When you push changes to any `plugins/*/.claude-plugin/plugin.json` file, GitHub Actions will automatically:
1. Run the generation script
2. Update `versions.json`
3. Commit and push the changes

You can also manually trigger the workflow from the GitHub Actions tab.

### Publishing a New Version

1. Update the version in your plugin's `.claude-plugin/plugin.json`:
   ```json
   {
     "name": "your-plugin",
     "version": "1.1.0",
     ...
   }
   ```

2. Update the plugin's `CHANGELOG.md` with the new version details

3. Commit and push:
   ```bash
   git add plugins/your-plugin/.claude-plugin/plugin.json
   git add plugins/your-plugin/CHANGELOG.md
   git commit -m "chore: bump your-plugin to v1.1.0"
   git push
   ```

4. GitHub Actions will automatically update `versions.json`

5. (Optional) Create a GitHub Release with tag `your-plugin-v1.1.0`

## License

MIT
