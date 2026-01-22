#!/bin/bash
# generate-versions.sh - 自动生成 versions.json 文件

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGINS_DIR="$REPO_ROOT/plugins"
OUTPUT_FILE="$REPO_ROOT/versions.json"

# 检查 jq 是否安装
if ! command -v jq &> /dev/null; then
    echo "错误: 需要安装 jq 工具"
    echo "安装: brew install jq (macOS) 或 apt-get install jq (Linux)"
    exit 1
fi

echo "🔍 扫描插件目录: $PLUGINS_DIR"

# 初始化 JSON 结构
PLUGINS_JSON="{}"

# 遍历所有插件目录
for plugin_dir in "$PLUGINS_DIR"/*; do
    if [ -d "$plugin_dir" ]; then
        PLUGIN_JSON_FILE="$plugin_dir/.claude-plugin/plugin.json"

        if [ -f "$PLUGIN_JSON_FILE" ]; then
            PLUGIN_NAME=$(jq -r '.name' "$PLUGIN_JSON_FILE")
            PLUGIN_VERSION=$(jq -r '.version' "$PLUGIN_JSON_FILE")
            PLUGIN_DESC=$(jq -r '.description' "$PLUGIN_JSON_FILE")

            echo "  ✓ 发现插件: $PLUGIN_NAME (v$PLUGIN_VERSION)"

            # 构建插件信息
            PLUGIN_INFO=$(jq -n \
                --arg version "$PLUGIN_VERSION" \
                --arg releaseDate "$(date -u +"%Y-%m-%d")" \
                --arg description "$PLUGIN_DESC" \
                --arg changelog "https://github.com/zlyv587/marketplace/blob/main/plugins/$PLUGIN_NAME/CHANGELOG.md" \
                --arg repository "https://github.com/zlyv587/marketplace/tree/main/plugins/$PLUGIN_NAME" \
                '{
                    version: $version,
                    releaseDate: $releaseDate,
                    description: $description,
                    changelog: $changelog,
                    repository: $repository
                }')

            # 添加到 plugins 对象
            PLUGINS_JSON=$(echo "$PLUGINS_JSON" | jq \
                --arg name "$PLUGIN_NAME" \
                --argjson info "$PLUGIN_INFO" \
                '.[$name] = $info')
        fi
    fi
done

# 生成最终的 versions.json
FINAL_JSON=$(jq -n \
    --arg lastUpdated "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --argjson plugins "$PLUGINS_JSON" \
    '{
        lastUpdated: $lastUpdated,
        plugins: $plugins
    }')

# 写入文件
echo "$FINAL_JSON" | jq '.' > "$OUTPUT_FILE"

echo ""
echo "✅ 成功生成 versions.json"
echo "📄 文件位置: $OUTPUT_FILE"
echo ""
echo "插件数量: $(echo "$PLUGINS_JSON" | jq 'length')"
