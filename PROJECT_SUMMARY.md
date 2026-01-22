# Developer Kits - 项目总结

## 📦 项目概述

这是一个 Claude Code 插件市场，包含 4 个插件和完整的自动化版本管理系统。

**项目位置：** `~/Documents/workspace/developer-kits/`

**GitHub 仓库：** https://github.com/zlyv587/marketplace

---

## 🔌 插件列表

### 1. claude-md-sync (v1.0.0)
**分类：** Productivity

**功能：** 自动保持 CLAUDE.md 与项目状态同步

**特性：**
- 自动检测项目类型（K8s/Infra, Node.js, Python, Go, Java, Monorepo）
- 智能分析代码库结构、依赖和模式
- 基于差异的更新建议
- 项目特定的模板

**安装：**
```bash
/plugin install claude-md-sync@developer-kits
```

**文档：** [README](./plugins/claude-md-sync/README.md) | [CHANGELOG](./plugins/claude-md-sync/CHANGELOG.md)

---

### 2. claude-mem0 (v1.6.1)
**分类：** Productivity

**功能：** 使用 mem0 云 API 为 Claude Code 提供持久化记忆

**特性：**
- 会话开始时自动检索记忆
- 任务完成和会话结束时自动捕获记忆
- 全局记忆（用户偏好，跨所有项目）
- 项目记忆（代码库特定知识）
- 语义搜索相关上下文
- 基于云的存储（无需本地数据库）

**安装：**
```bash
/plugin install claude-mem0@developer-kits
```

**前置要求：**
- mem0 API Key（从 https://app.mem0.ai 获取）
- uv（Python 包管理器）

**文档：** [README](./plugins/claude-mem0/README.md) | [CHANGELOG](./plugins/claude-mem0/CHANGELOG.md)

---

### 3. gui-agent-dev (v1.1.0)
**分类：** Development

**功能：** GUI 自动化代理开发工具包

**特性：**
- `/dev` 命令（6 步开发工作流）
- 8 个专业代理：
  - **领域代理（5个）：** prompt-engineer, plan-debugger, context-optimizer, action-designer, screenshot-analyzer
  - **工作流代理（3个）：** code-explorer, code-architect, code-reviewer
- 代码审查技能，涵盖所有 5 个领域代理

**安装：**
```bash
/plugin install gui-agent-dev@developer-kits
```

**适用项目：**
- 使用多模态 LLM（Gemini, Claude, GPT-4V）进行视觉自动化
- 使用 PyAutoGUI 进行鼠标/键盘控制
- 归一化坐标（0.0-1.0）实现分辨率独立
- 带网格叠加的截图分析

**文档：** [README](./plugins/gui-agent-dev/README.md) | [CHANGELOG](./plugins/gui-agent-dev/CHANGELOG.md)

---

### 4. plugin-updater (v1.0.0) ⭐ 新增
**分类：** Maintenance

**功能：** 检查 developer-kits 市场中已安装插件的更新

**特性：**
- 自动版本检查
- 清晰的更新通知（当前版本 vs 最新版本）
- 直接更新命令
- 变更日志链接
- 简单的 `/check-updates` 命令

**安装：**
```bash
/plugin install plugin-updater@developer-kits
```

**使用：**
```bash
/check-updates
```

**文档：** [README](./plugins/plugin-updater/README.md) | [CHANGELOG](./plugins/plugin-updater/CHANGELOG.md)

---

## 🔄 版本管理系统

### 自动化组件

#### 1. 版本生成脚本
**文件：** `scripts/generate-versions.sh`

**功能：**
- 自动扫描所有插件的 `plugin.json`
- 生成 `versions.json` 文件
- 无需手动维护版本信息

**使用：**
```bash
bash scripts/generate-versions.sh
```

#### 2. GitHub Actions 工作流
**文件：** `.github/workflows/update-versions.yml`

**触发条件：**
- 推送到 main 分支
- 修改 `plugins/*/.claude-plugin/plugin.json` 文件
- 手动触发

**自动操作：**
1. 运行版本生成脚本
2. 更新 `versions.json`
3. 提交并推送更改

#### 3. 版本索引文件
**文件：** `versions.json`

**内容：**
- 最后更新时间
- 所有插件的版本信息
- 描述、变更日志和仓库链接

**示例：**
```json
{
  "lastUpdated": "2026-01-22T03:51:39Z",
  "plugins": {
    "claude-mem0": {
      "version": "1.6.1",
      "releaseDate": "2026-01-22",
      "description": "...",
      "changelog": "https://...",
      "repository": "https://..."
    }
  }
}
```

---

## 📖 使用指南

### 用户安装流程

#### 1. 添加插件市场
```bash
/plugin marketplace add marketplace
```

#### 2. 安装插件
```bash
# 安装单个插件
/plugin install claude-mem0@developer-kits

# 安装多个插件
/plugin install claude-md-sync@developer-kits
/plugin install claude-mem0@developer-kits
/plugin install gui-agent-dev@developer-kits
/plugin install plugin-updater@developer-kits
```

#### 3. 检查更新
```bash
# 方法 1：使用 plugin-updater（推荐）
/check-updates

# 方法 2：手动查看
# 访问 https://github.com/zlyv587/marketplace/blob/main/versions.json
```

#### 4. 更新插件
```bash
# 更新市场（获取最新插件信息）
/plugin marketplace update developer-kits

# 更新特定插件
/plugin install <plugin-name>@developer-kits
```

---

## 🚀 开发者发布流程

### 发布新版本

#### 1. 更新版本号
编辑插件的 `plugin.json`：
```json
{
  "name": "your-plugin",
  "version": "1.2.0",
  "description": "..."
}
```

#### 2. 更新 CHANGELOG
编辑 `CHANGELOG.md`：
```markdown
## [1.2.0] - 2026-01-22

### Added
- 新功能描述

### Fixed
- 修复的问题

### Changed
- 变更的内容
```

#### 3. 提交并推送
```bash
git add plugins/your-plugin/.claude-plugin/plugin.json
git add plugins/your-plugin/CHANGELOG.md
git commit -m "chore: bump your-plugin to v1.2.0"
git push
```

#### 4. 自动化处理
- GitHub Actions 自动运行
- 自动更新 `versions.json`
- 自动提交更改

#### 5. 创建 GitHub Release（可选）
```bash
git tag your-plugin-v1.2.0
git push origin your-plugin-v1.2.0
```

然后在 GitHub 上创建 Release。

---

## 📁 项目结构

```
developer-kits/
├── .github/
│   └── workflows/
│       └── update-versions.yml          # GitHub Actions 自动化
│
├── plugins/
│   ├── claude-md-sync/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json              # 插件配置
│   │   ├── agents/
│   │   │   └── claude-md-updater.md
│   │   ├── commands/
│   │   │   └── sync-claude-md.md
│   │   ├── skills/
│   │   │   ├── claude-md-authoring/
│   │   │   └── project-analysis/
│   │   ├── CHANGELOG.md                 # 版本历史
│   │   └── README.md                    # 插件文档
│   │
│   ├── claude-mem0/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── .mcp.json                    # MCP 服务器配置
│   │   ├── hooks/
│   │   │   ├── hooks.json
│   │   │   └── scripts/
│   │   ├── skills/
│   │   │   └── mem0-memory/
│   │   ├── scripts/
│   │   ├── CHANGELOG.md
│   │   └── README.md
│   │
│   ├── gui-agent-dev/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── agents/                      # 8 个专业代理
│   │   │   ├── action-designer.md
│   │   │   ├── code-architect.md
│   │   │   ├── code-explorer.md
│   │   │   ├── code-reviewer.md
│   │   │   ├── context-optimizer.md
│   │   │   ├── plan-debugger.md
│   │   │   ├── prompt-engineer.md
│   │   │   └── screenshot-analyzer.md
│   │   ├── commands/
│   │   │   └── dev.md                   # /dev 命令
│   │   ├── skills/
│   │   │   └── code-review/
│   │   ├── CHANGELOG.md
│   │   └── README.md
│   │
│   └── plugin-updater/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── commands/
│       │   └── check-updates.md         # /check-updates 命令
│       ├── scripts/
│       │   └── check-updates.sh         # 更新检查脚本
│       ├── CHANGELOG.md
│       └── README.md
│
├── scripts/
│   ├── check-updates.sh                 # 独立更新检查脚本
│   └── generate-versions.sh             # 版本生成脚本
│
├── versions.json                        # 自动生成的版本索引
├── README.md                            # 主文档
└── .gitignore
```

---

## 🔑 关键特性

### ✅ 完全自动化
- `versions.json` 无需手动维护
- GitHub Actions 自动更新版本信息
- 推送即发布

### ✅ Claude Code 集成
- `/check-updates` 命令直接在 Claude Code 中使用
- 无需离开开发环境
- 实时版本对比

### ✅ 用户友好
- 清晰的版本对比（当前 → 最新）
- 直接提供更新命令
- 变更日志链接一键访问

### ✅ 开发者友好
- 简单的发布流程
- 自动化版本管理
- 标准化的 CHANGELOG 格式

### ✅ 可追溯性
- 每个插件都有完整的 CHANGELOG
- 语义化版本控制（SemVer）
- GitHub Release 支持

---

## 🛠️ 技术栈

- **版本控制：** Git
- **CI/CD：** GitHub Actions
- **脚本语言：** Bash
- **数据格式：** JSON
- **文档格式：** Markdown
- **版本规范：** Semantic Versioning (SemVer)
- **变更日志规范：** Keep a Changelog

---

## 📊 统计信息

- **插件数量：** 4
- **总命令数：** 3 (`/sync-claude-md`, `/dev`, `/check-updates`)
- **总代理数：** 9 (claude-md-updater + 8 个 gui-agent-dev 代理)
- **总技能数：** 4 (claude-md-authoring, project-analysis, mem0-memory, code-review)
- **自动化脚本：** 2 (generate-versions.sh, check-updates.sh)
- **GitHub Actions：** 1 (update-versions.yml)

---

## 📝 待办事项

### 短期
- [ ] 测试 GitHub Actions 工作流
- [ ] 为每个插件创建 GitHub Release
- [ ] 添加插件使用示例和截图

### 中期
- [ ] 添加插件使用统计
- [ ] 创建插件开发指南
- [ ] 添加自动化测试

### 长期
- [ ] 支持插件依赖管理
- [ ] 创建插件模板生成器
- [ ] 添加插件评分和评论系统

---

## 🤝 贡献指南

### 添加新插件

1. 在 `plugins/` 目录创建新插件文件夹
2. 创建 `.claude-plugin/plugin.json` 配置文件
3. 添加插件功能（agents/commands/skills）
4. 创建 `README.md` 和 `CHANGELOG.md`
5. 运行 `bash scripts/generate-versions.sh` 更新版本索引
6. 提交并推送

### 更新现有插件

1. 修改插件的 `plugin.json` 版本号
2. 更新 `CHANGELOG.md`
3. 提交并推送
4. GitHub Actions 自动更新 `versions.json`

---

## 📄 许可证

MIT License

---

## 🔗 相关链接

- **GitHub 仓库：** https://github.com/zlyv587/marketplace
- **Claude Code 文档：** https://docs.anthropic.com/claude/docs/claude-code
- **mem0 官网：** https://mem0.ai
- **Keep a Changelog：** https://keepachangelog.com
- **Semantic Versioning：** https://semver.org

---

## 📞 联系方式

- **作者：** GeekMini
- **GitHub：** https://github.com/geekmini
- **问题反馈：** https://github.com/zlyv587/marketplace/issues

---

**最后更新：** 2026-01-22

**文档版本：** 1.0.0
