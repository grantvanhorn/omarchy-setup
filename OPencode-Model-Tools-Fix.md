# OpenCode Model Tools Support Fix

## Problem
The error `"registry.ollama.ai/library/deepseek-coder-v2: latest does not support tools"` means your current model doesn't support function calling, which OpenCode requires.

## Solution

You need to use a model that supports tools (function calling). Here are options:

### Option 1: Use qwen2.5-coder (Recommended)

1. **Pull the model** (if you haven't already):
   ```bash
   ollama pull qwen2.5-coder
   ```

2. **Switch to it in OpenCode**:
   - In OpenCode CLI: `/models` then select `qwen2.5-coder`
   - Or update your config to set it as default

### Option 2: Try Other Models That Support Tools

Try pulling and testing these models:
```bash
# Qwen models (often support tools)
ollama pull qwen2.5-coder
ollama pull qwen2.5:32b

# Llama 3.2 models (newer, may support tools)
ollama pull llama3.2:3b
ollama pull llama3.2:1b

# Mistral models
ollama pull mistral
```

### Option 3: Check Model Support

To check if a model supports tools, you can test it:
```bash
ollama run qwen2.5-coder
# Then try asking it about function calling capabilities
```

## Update OpenCode Config

The config has been updated to prioritize `qwen2.5-coder` first. After pulling the model, restart OpenCode and it should use the new model.

## Verify It Works

After switching models, try your OpenCode command again. The tools error should be resolved.
