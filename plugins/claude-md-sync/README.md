# claude-md-sync

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Automatically keeps CLAUDE.md synchronized with project state.

**[📋 Changelog](./CHANGELOG.md)** | **[🔄 Check for Updates](https://github.com/zlyv587/marketplace#checking-for-updates)**

## Features

- **Auto-detection**: Identifies project type (K8s/Infra, Node.js, Python, Go, Java, Monorepo)
- **Smart analysis**: Analyzes codebase structure, dependencies, and patterns
- **Diff-based updates**: Shows proposed changes before applying
- **Project-specific templates**: Tailored CLAUDE.md sections per project type

## Components

| Component                   | Description                                   |
| --------------------------- | --------------------------------------------- |
| `project-analysis` skill    | Detects project type from files and structure |
| `claude-md-authoring` skill | Templates and best practices for CLAUDE.md    |
| `claude-md-updater` agent   | Proactively suggests and applies updates      |
| `/sync-claude-md` command   | Manual trigger for sync workflow              |

## Usage

### Automatic (Recommended)

The `claude-md-updater` agent activates proactively when:
- Starting a session in a project with CLAUDE.md
- After significant codebase changes
- When discussing project documentation

### Manual

```
/sync-claude-md
```

Forces a full analysis and update proposal.

## Supported Project Types

- **Infrastructure**: Kubernetes, ArgoCD, Helm, Terraform
- **Node.js**: npm/yarn/pnpm projects
- **Python**: pip, poetry, pipenv projects
- **Go**: Go modules
- **Java**: Maven, Gradle projects
- **Monorepo**: Nx, Turborepo, Lerna

## Installation

```bash
/plugin install claude-md-sync
```
