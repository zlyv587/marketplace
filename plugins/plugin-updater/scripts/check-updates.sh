#!/bin/bash
# check-updates.sh - 检查 Claude Code 插件更新

set -e

MARKETPLACE_URL="https://raw.githubusercontent.com/james-heidi/developer-kits/main/versions.json"
GLOBAL_PLUGINS_DIR="$HOME/.claude/plugins"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  --global          只检查全局安装的插件（默认）"
    echo "  --local           只检查当前项目的插件"
    echo "  --all             检查全局和项目插件"
    echo "  -h, --help        显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0                # 检查全局插件"
    echo "  $0 --local        # 检查项目插件"
    echo "  $0 --all          # 检查所有插件"
}

# 解析命令行参数
CHECK_GLOBAL=true
CHECK_LOCAL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            CHECK_GLOBAL=true
            CHECK_LOCAL=false
            shift
            ;;
        --local)
            CHECK_GLOBAL=false
            CHECK_LOCAL=true
            shift
            ;;
        --all)
            CHECK_GLOBAL=true
            CHECK_LOCAL=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
done

echo -e "${BLUE}🔍 检查 Claude Code 插件更新...${NC}\n"

# 检查 jq 是否安装
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  需要安装 jq 工具来解析 JSON${NC}"
    echo "请运行: brew install jq (macOS) 或 apt-get install jq (Linux)"
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
UP_TO_DATE_PLUGINS=()

# 函数：检查插件目录
check_plugins_in_dir() {
    local plugins_dir=$1
    local location_label=$2

    if [ ! -d "$plugins_dir" ]; then
        return
    fi

    local found_any=false

    for plugin_dir in "$plugins_dir"/*; do
        if [ -d "$plugin_dir" ] && [ -f "$plugin_dir/.claude-plugin/plugin.json" ]; then
            found_any=true
            PLUGIN_NAME=$(jq -r '.name' "$plugin_dir/.claude-plugin/plugin.json" 2>/dev/null)
            CURRENT_VERSION=$(jq -r '.version' "$plugin_dir/.claude-plugin/plugin.json" 2>/dev/null)

            if [ "$PLUGIN_NAME" != "null" ] && [ "$CURRENT_VERSION" != "null" ]; then
                LATEST_VERSION=$(echo "$LATEST_VERSIONS" | jq -r ".plugins[\"$PLUGIN_NAME\"].version" 2>/dev/null)

                if [ "$LATEST_VERSION" != "null" ] && [ -n "$LATEST_VERSION" ]; then
                    if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
                        CHANGELOG_URL=$(echo "$LATEST_VERSIONS" | jq -r ".plugins[\"$PLUGIN_NAME\"].changelog")
                        echo -e "${YELLOW}📦 $PLUGIN_NAME${NC} ${CYAN}[$location_label]${NC}"
                        echo -e "   当前版本: ${CURRENT_VERSION}"
                        echo -e "   最新版本: ${GREEN}${LATEST_VERSION}${NC}"
                        echo -e "   更新日志: ${CHANGELOG_URL}"
                        echo -e "   更新命令: ${BLUE}/plugin install ${PLUGIN_NAME}@developer-kits${NC}"
                        echo ""
                        UPDATES_FOUND=$((UPDATES_FOUND + 1))
                    else
                        UP_TO_DATE_PLUGINS+=("$PLUGIN_NAME ($CURRENT_VERSION) [$location_label]")
                    fi
                fi
            fi
        fi
    done

    if [ "$found_any" = false ]; then
        echo -e "${CYAN}ℹ️  $location_label: 未找到插件${NC}"
        echo ""
    fi
}

# 检查全局插件
if [ "$CHECK_GLOBAL" = true ]; then
    echo -e "${BLUE}━━━ 检查全局插件 ━━━${NC}\n"

    if [ -d "$GLOBAL_PLUGINS_DIR" ]; then
        check_plugins_in_dir "$GLOBAL_PLUGINS_DIR" "全局"
    else
        echo -e "${YELLOW}⚠️  未找到全局插件目录: $GLOBAL_PLUGINS_DIR${NC}"
        echo ""
    fi
fi

# 检查项目级插件
if [ "$CHECK_LOCAL" = true ]; then
    echo -e "${BLUE}━━━ 检查项目插件 ━━━${NC}\n"

    # 检查当前目录的 plugins/
    if [ -d "./plugins" ]; then
        check_plugins_in_dir "./plugins" "项目"
    fi

    # 检查当前目录的 .claude-plugin/
    if [ -d "./.claude-plugin" ] && [ -f "./.claude-plugin/plugin.json" ]; then
        echo -e "${CYAN}ℹ️  发现项目插件配置: ./.claude-plugin/plugin.json${NC}"
        echo ""
    fi

    if [ ! -d "./plugins" ] && [ ! -d "./.claude-plugin" ]; then
        echo -e "${CYAN}ℹ️  当前目录未找到项目插件${NC}"
        echo ""
    fi
fi

# 显示最新的插件
echo -e "${BLUE}━━━ 检查结果 ━━━${NC}\n"

if [ ${#UP_TO_DATE_PLUGINS[@]} -gt 0 ]; then
    echo -e "${GREEN}✅ 已是最新版本:${NC}"
    for plugin in "${UP_TO_DATE_PLUGINS[@]}"; do
        echo -e "   - $plugin"
    done
    echo ""
fi

if [ $UPDATES_FOUND -eq 0 ]; then
    echo -e "${GREEN}✅ 所有插件都是最新版本！${NC}"
else
    echo -e "${YELLOW}发现 ${UPDATES_FOUND} 个插件有更新${NC}"
fi
