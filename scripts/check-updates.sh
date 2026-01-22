#!/bin/bash
# check-updates.sh - 检查 Claude Code 插件更新

set -e

MARKETPLACE_URL="https://raw.githubusercontent.com/zlyv587/marketplace/main/versions.json"
INSTALLED_PLUGINS_DIR="$HOME/.claude/plugins"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 检查 Claude Code 插件更新...${NC}\n"

# 检查 jq 是否安装
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  需要安装 jq 工具来解析 JSON${NC}"
    echo "请运行: brew install jq (macOS) 或 apt-get install jq (Linux)"
    exit 1
fi

# 检查插件目录是否存在
if [ ! -d "$INSTALLED_PLUGINS_DIR" ]; then
    echo -e "${YELLOW}⚠️  未找到插件目录: $INSTALLED_PLUGINS_DIR${NC}"
    echo "请确保已安装 Claude Code 插件"
    exit 1
fi

# 获取最新版本信息
echo "正在获取最新版本信息..."
LATEST_VERSIONS=$(curl -s "$MARKETPLACE_URL")

if [ -z "$LATEST_VERSIONS" ]; then
    echo -e "${YELLOW}⚠️  无法获取版本信息，请检查网络连接${NC}"
    exit 1
fi

UPDATES_FOUND=0

# 遍历已安装的插件
for plugin_dir in "$INSTALLED_PLUGINS_DIR"/*; do
    if [ -d "$plugin_dir" ] && [ -f "$plugin_dir/.claude-plugin/plugin.json" ]; then
        PLUGIN_NAME=$(jq -r '.name' "$plugin_dir/.claude-plugin/plugin.json" 2>/dev/null)
        CURRENT_VERSION=$(jq -r '.version' "$plugin_dir/.claude-plugin/plugin.json" 2>/dev/null)

        if [ "$PLUGIN_NAME" != "null" ] && [ "$CURRENT_VERSION" != "null" ]; then
            LATEST_VERSION=$(echo "$LATEST_VERSIONS" | jq -r ".plugins[\"$PLUGIN_NAME\"].version" 2>/dev/null)

            if [ "$LATEST_VERSION" != "null" ] && [ -n "$LATEST_VERSION" ]; then
                if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
                    CHANGELOG_URL=$(echo "$LATEST_VERSIONS" | jq -r ".plugins[\"$PLUGIN_NAME\"].changelog")
                    echo -e "${YELLOW}📦 $PLUGIN_NAME${NC}"
                    echo -e "   当前版本: ${CURRENT_VERSION}"
                    echo -e "   最新版本: ${GREEN}${LATEST_VERSION}${NC}"
                    echo -e "   更新日志: ${CHANGELOG_URL}"
                    echo -e "   更新命令: ${BLUE}/plugin install ${PLUGIN_NAME}@developer-kits${NC}"
                    echo ""
                    UPDATES_FOUND=$((UPDATES_FOUND + 1))
                fi
            fi
        fi
    fi
done

if [ $UPDATES_FOUND -eq 0 ]; then
    echo -e "${GREEN}✅ 所有插件都是最新版本！${NC}"
else
    echo -e "${YELLOW}发现 ${UPDATES_FOUND} 个插件有更新${NC}"
    echo -e "\n💡 提示: 使用上面的命令更新插件，或运行以下命令更新所有插件:"
    echo -e "${BLUE}   /plugin update --all${NC}"
fi
