#!/bin/bash

# Configure OpenCode to use local Ollama
# This adds the local Ollama provider to OpenCode's config

set -e

CONFIG_FILE="$HOME/.config/opencode/opencode.json"
BACKUP_FILE="$CONFIG_FILE.backup"

echo "🔧 Configuring OpenCode to use local Ollama..."

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating OpenCode config file..."
    mkdir -p "$HOME/.config/opencode"
    cat > "$CONFIG_FILE" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "system"
}
EOF
fi

# Backup existing config
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo "✅ Backed up existing config to $BACKUP_FILE"
fi

# Check if Ollama provider already exists
if grep -q '"ollama"' "$CONFIG_FILE"; then
    echo "⚠️  Ollama provider already exists in config"
    echo "   You may need to manually edit $CONFIG_FILE"
    exit 0
fi

# Create temporary file with updated config
TEMP_FILE=$(mktemp)

# Use Python to properly merge the JSON (more reliable than sed)
python3 << PYTHON_SCRIPT > "$TEMP_FILE"
import json
import sys

config_file = "$CONFIG_FILE"

# Read existing config
try:
    with open(config_file, 'r') as f:
        config = json.load(f)
except:
    config = {"\$schema": "https://opencode.ai/config.json", "theme": "system"}

# Add Ollama provider configuration
if "provider" not in config:
    config["provider"] = {}

config["provider"]["ollama"] = {
    "npm": "@ai-sdk/openai-compatible",
    "name": "Ollama",
    "options": {
        "baseURL": "http://localhost:11434/v1"
    },
    "models": {
        "deepseek-coder-v2": {
            "name": "deepseek-coder-v2"
        },
        "codellama": {
            "name": "codellama"
        },
        "qwen2.5-coder": {
            "name": "qwen2.5-coder"
        }
    }
}

# Write updated config
print(json.dumps(config, indent=2))
PYTHON_SCRIPT

# Replace config file
mv "$TEMP_FILE" "$CONFIG_FILE"

echo "✅ OpenCode configured to use local Ollama!"
echo ""
echo "📝 Configuration added:"
echo "   - Provider: Ollama (local)"
echo "   - Endpoint: http://localhost:11434/v1"
echo "   - Models: deepseek-coder-v2, codellama, qwen2.5-coder"
echo ""
echo "🔍 Next steps:"
echo "1. Make sure Ollama is running: systemctl status ollama"
echo "2. Pull a model: ollama pull deepseek-coder-v2"
echo "3. Restart OpenCode and select 'Ollama' from /connect"
echo ""
echo "💡 If you don't see 'Ollama' in /connect, try:"
echo "   - Restart OpenCode completely"
echo "   - Check that Ollama is running: curl http://localhost:11434/api/tags"
