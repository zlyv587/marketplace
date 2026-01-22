# 快速开始指南

本指南帮助你快速开始使用 developer-kits 插件市场。

## 🚀 5 分钟快速开始

### 步骤 1：添加插件市场

在 Claude Code 中运行：

```bash
/plugin marketplace add marketplace
```

### 步骤 2：安装推荐插件

```bash
# 安装更新检查器（强烈推荐）
/plugin install plugin-updater@developer-kits

# 根据需要安装其他插件
/plugin install claude-mem0@developer-kits
/plugin install claude-md-sync@developer-kits
/plugin install gui-agent-dev@developer-kits
```

### 步骤 3：验证安装

```bash
# 检查已安装的插件
/plugin list

# 检查更新
/check-updates
```

### 步骤 4：开始使用

根据你安装的插件，尝试以下命令：

```bash
# 如果安装了 claude-md-sync
/sync-claude-md

# 如果安装了 claude-mem0
"记住我喜欢用 2 空格缩进"

# 如果安装了 gui-agent-dev
/dev "add drag and drop action"
```

---

## 📦 插件选择指南

### 我应该安装哪些插件？

#### 必装插件

**plugin-updater** - 插件更新检查器
- ✅ 所有用户都应该安装
- 用于检查和管理插件更新
- 使用 `/check-updates` 命令

#### 根据需求选择

**claude-mem0** - 持久化记忆
- ✅ 适合：需要跨会话保持上下文的用户
- ✅ 适合：经常在多个项目间切换的用户
- ❌ 不适合：不想使用云服务的用户
- 需要：mem0 API Key

**claude-md-sync** - CLAUDE.md 同步
- ✅ 适合：使用 CLAUDE.md 管理项目的用户
- ✅ 适合：需要自动更新项目文档的团队
- ❌ 不适合：不使用 CLAUDE.md 的项目

**gui-agent-dev** - GUI 自动化开发
- ✅ 适合：开发 GUI 自动化工具的开发者
- ✅ 适合：使用 PyAutoGUI 的项目
- ❌ 不适合：不涉及 GUI 自动化的项目

---

## 🔧 常见配置

### claude-mem0 配置

1. 获取 API Key：访问 https://app.mem0.ai/dashboard/api-keys

2. 添加环境变量到 `~/.zshrc` 或 `~/.bashrc`：

```bash
export MEM0_API_KEY="m0-your-api-key-here"
export MEM0_USER_ID=$USER
```

3. 重新加载配置：

```bash
source ~/.zshrc  # 或 source ~/.bashrc
```

4. 重启 Claude Code

### 验证 claude-mem0 安装

```bash
# 在 Claude Code 中测试
"记住我的名字是张三"
"你记得我的名字吗？"
```

---

## 🔄 日常使用

### 每周检查更新

```bash
# 更新市场信息
/plugin marketplace update developer-kits

# 检查插件更新
/check-updates

# 如果有更新，安装它们
/plugin install <plugin-name>@developer-kits
```

### 查看插件信息

```bash
# 列出所有已安装的插件
/plugin list

# 查看特定插件的详细信息
# 访问 https://github.com/zlyv587/marketplace/tree/main/plugins/<plugin-name>
```

---

## 🐛 故障排除

### 问题 1：插件安装失败

**症状：** `/plugin install` 命令失败

**解决方案：**
```bash
# 1. 确保市场已添加
/plugin marketplace list

# 2. 如果没有，重新添加
/plugin marketplace add marketplace

# 3. 更新市场
/plugin marketplace update developer-kits

# 4. 重试安装
/plugin install <plugin-name>@developer-kits
```

### 问题 2：/check-updates 命令不可用

**症状：** 运行 `/check-updates` 提示命令不存在

**解决方案：**
```bash
# 确保 plugin-updater 已安装
/plugin install plugin-updater@developer-kits

# 重启 Claude Code
```

### 问题 3：claude-mem0 无法连接

**症状：** mem0 相关功能不工作

**解决方案：**
```bash
# 1. 检查环境变量
echo $MEM0_API_KEY
echo $MEM0_USER_ID

# 2. 如果为空，添加到 shell 配置文件
# 编辑 ~/.zshrc 或 ~/.bashrc

# 3. 重新加载配置
source ~/.zshrc

# 4. 重启 Claude Code
```

### 问题 4：jq 命令未找到

**症状：** `/check-updates` 提示需要 jq

**解决方案：**
```bash
# macOS
brew install jq

# Linux (Ubuntu/Debian)
sudo apt-get install jq

# Linux (CentOS/RHEL)
sudo yum install jq
```

---

## 💡 使用技巧

### 技巧 1：批量安装插件

创建一个脚本 `install-plugins.sh`：

```bash
#!/bin/bash
plugins=(
    "plugin-updater"
    "claude-mem0"
    "claude-md-sync"
)

for plugin in "${plugins[@]}"; do
    echo "Installing $plugin..."
    # 注意：这需要在 Claude Code 中手动运行
    echo "/plugin install $plugin@developer-kits"
done
```

### 技巧 2：定期更新提醒

添加到 crontab（每周一检查）：

```bash
# 编辑 crontab
crontab -e

# 添加以下行（每周一上午 9 点）
0 9 * * 1 echo "记得运行 /check-updates 检查插件更新" | mail -s "Claude Code 插件更新提醒" your@email.com
```

### 技巧 3：查看插件源码

```bash
# 插件安装在
cd ~/.claude/plugins/<plugin-name>

# 查看插件结构
ls -la

# 查看命令定义
cat commands/*.md

# 查看代理定义
cat agents/*.md
```

### 技巧 4：自定义插件

基于现有插件创建自己的插件：

```bash
# 1. Fork developer-kits 仓库
# 2. 复制一个现有插件作为模板
cp -r plugins/plugin-updater plugins/my-plugin

# 3. 修改 plugin.json
# 4. 添加你的功能
# 5. 提交并推送
# 6. 添加你的市场
/plugin marketplace add https://github.com/your-username/developer-kits.git
```

---

## 📚 进阶使用

### 使用多个市场

```bash
# 添加多个市场
/plugin marketplace add marketplace
/plugin marketplace add https://github.com/other-user/other-marketplace.git

# 从不同市场安装插件
/plugin install plugin-name@developer-kits
/plugin install other-plugin@other-marketplace
```

### 锁定插件版本

如果你想使用特定版本的插件：

```bash
# 1. 查看可用版本
# 访问 https://github.com/zlyv587/marketplace/releases

# 2. 克隆市场到本地
git clone marketplace ~/my-plugins

# 3. 切换到特定版本
cd ~/my-plugins
git checkout plugin-name-v1.0.0

# 4. 添加本地市场
/plugin marketplace add ~/my-plugins
```

### 开发自己的插件

参考 [PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md) 的"贡献指南"部分。

---

## 🔗 相关资源

- **主文档：** [README.md](./README.md)
- **项目总结：** [PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md)
- **版本信息：** [versions.json](./versions.json)
- **GitHub 仓库：** https://github.com/zlyv587/marketplace
- **问题反馈：** https://github.com/zlyv587/marketplace/issues

---

## 📞 获取帮助

### 遇到问题？

1. **查看文档：** 先查看插件的 README.md
2. **搜索 Issues：** https://github.com/zlyv587/marketplace/issues
3. **提交 Issue：** 如果问题未解决，创建新 Issue
4. **社区讨论：** GitHub Discussions

### 功能建议？

欢迎在 GitHub Issues 中提交功能建议，使用 `enhancement` 标签。

---

**祝你使用愉快！** 🎉

如果这个指南对你有帮助，请给项目一个 ⭐️
