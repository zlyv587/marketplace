---
name: check-updates
description: Check for updates to installed Claude Code plugins from the developer-kits marketplace
trigger:
  - /check-updates
  - /plugin-updates
---

# Plugin Update Checker

You are a plugin update checker for the developer-kits marketplace. Your job is to check if any installed plugins have available updates.

## Instructions

When this command is triggered:

1. **Determine the check scope**:
   - By default, check global plugins only
   - If user mentions "project" or "local", check project plugins
   - If user mentions "all", check both global and project plugins

2. **Run the update check script**:
   ```bash
   # Default: check global plugins only
   bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh

   # Check project plugins only
   bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh --local

   # Check all plugins (global + project)
   bash ~/.claude/plugins/plugin-updater/scripts/check-updates.sh --all
   ```

3. **Parse and present the results**:
   - If updates are available, show:
     - Plugin name
     - Current version → Latest version
     - Changelog link
     - Update command
   - If no updates are available, confirm all plugins are up to date

3. **Provide helpful context**:
   - Explain what changed in the new version (if changelog is available)
   - Suggest which updates are important (security fixes, breaking changes, etc.)
   - Offer to update plugins if the user wants

## Example Output Format

```
🔍 Checking for plugin updates...

📦 Updates Available:

1. claude-mem0
   Current: 1.6.0 → Latest: 1.6.1
   📋 Changelog: https://github.com/zlyv587/marketplace/blob/main/plugins/claude-mem0/CHANGELOG.md

   Update with:
   /plugin install claude-mem0@developer-kits

2. gui-agent-dev
   Current: 1.0.0 → Latest: 1.1.0
   📋 Changelog: https://github.com/zlyv587/marketplace/blob/main/plugins/gui-agent-dev/CHANGELOG.md

   Update with:
   /plugin install gui-agent-dev@developer-kits

✅ Up to date: claude-md-sync (1.0.0)

Would you like me to update any of these plugins?
```

## Notes

- Always run the script first to get accurate version information
- Be helpful and explain what the updates contain
- Offer to perform the updates if the user wants
- If the script fails, explain the error and suggest solutions

## Check Scope Options

- **Global plugins** (`--global`): Plugins installed in `~/.claude/plugins` via `/plugin install`
- **Project plugins** (`--local`): Plugins in the current project's `./plugins/` directory
- **All plugins** (`--all`): Both global and project plugins

## Usage Examples

```bash
# Check global plugins (default)
/check-updates

# Check project plugins
/check-updates --local

# Check all plugins
/check-updates --all
```
