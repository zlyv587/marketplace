# Changelog

All notable changes to the plugin-updater plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-22

### Added
- Initial release
- `/check-updates` command to check for plugin updates
- `/plugin-updates` alias command
- Automatic version comparison with marketplace
- Clear update notifications showing current vs latest versions
- Direct update commands for each plugin
- Changelog links for each update
- Support for developer-kits marketplace
- Colorized terminal output for better readability

### Features
- Fetches latest versions from `versions.json`
- Compares with installed plugins in `~/.claude/plugins`
- Shows plugins that are up-to-date
- Provides ready-to-use update commands
- Displays changelog URLs for review

[1.0.0]: https://github.com/zlyv587/marketplace/releases/tag/plugin-updater-v1.0.0
