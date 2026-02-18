# OpenCode with Ollama Setup

This guide will help you set up OpenCode with Ollama for free, local AI coding assistance in Neovim.

## Overview

- **OpenCode**: Free AI coding agent (already installed)
- **Ollama**: Free, local AI model runner
- **Neovim Plugin**: `opencode.nvim` - integrates OpenCode into Neovim

## Quick Setup

### 1. Install Ollama

Run the installation script:
```bash
./install-opencode-ollama.sh
```

Or manually:
```bash
# On Arch Linux
paru -S ollama-bin
# or
yay -S ollama-bin

# Start the service
sudo systemctl enable --now ollama
```

### 2. Download a Coding Model

Choose one of these models (recommended: `deepseek-coder-v2`):

```bash
# Recommended: DeepSeek Coder v2 (best for coding)
ollama pull deepseek-coder-v2

# Alternatives:
ollama pull codellama        # Meta's CodeLlama
ollama pull qwen2.5-coder    # Qwen Coder
ollama pull mistral          # General purpose (also good for code)
```

**Note**: Model downloads can be large (several GB) and may take time.

### 3. Configure OpenCode to Use Ollama

**Important**: The `/connect` UI may only show "Ollama Cloud". To use local Ollama, you need to manually configure it.

Run the configuration script:
```bash
./configure-opencode-ollama.sh
```

This will add the local Ollama provider to your OpenCode config.

Alternatively, manually edit `~/.config/opencode/opencode.json` and add:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "system",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "deepseek-coder-v2": {
          "name": "deepseek-coder-v2"
        }
      }
    }
  }
}
```

Then restart OpenCode and run:
```bash
opencode
/connect
```

You should now see "Ollama" (not just "Ollama Cloud") in the provider list. Select it and choose your model.

### 4. Restart Neovim

The plugin will be automatically loaded by lazy.nvim. Restart Neovim to ensure everything loads properly.

## Usage in Neovim

### Keybindings

- `<leader>oc` - Open OpenCode chat window
- `<leader>or` - Refactor selected code (visual mode)

### Commands

- `:OpenCode` - Open OpenCode interface
- `:OpenCodeChat` - Open chat window
- `:OpenCodeRefactor` - Refactor selected code

### Features

- **Chat**: Ask questions about your codebase
- **Refactor**: Select code and ask OpenCode to refactor it
- **Context-aware**: OpenCode understands your current file and project structure

## Configuration

The plugin is configured in `lua/plugins/opencode.lua`. You can customize:

- `model`: Change the model name
- `api_endpoint`: Change Ollama endpoint (default: `http://localhost:11434`)
- `max_tokens`: Maximum tokens per request
- `temperature`: Model creativity (0.0-1.0)

## Troubleshooting

### Ollama not running

```bash
# Check status
systemctl status ollama

# Start service
sudo systemctl start ollama

# Or run manually
ollama serve
```

### Model not found

Make sure you've pulled the model:
```bash
ollama list  # List installed models
ollama pull deepseek-coder-v2  # Pull if missing
```

### OpenCode can't connect to Ollama

1. Verify Ollama is running: `curl http://localhost:11434/api/tags`
2. Check the endpoint in OpenCode config matches your Ollama setup
3. Make sure the model name matches exactly (case-sensitive)

### Plugin not loading

1. Check lazy.nvim is working: `:Lazy`
2. Verify the plugin file exists: `lua/plugins/opencode.lua`
3. Check for errors: `:messages`

## Model Recommendations

- **deepseek-coder-v2**: Best overall coding model, great for refactoring and explanations
- **codellama**: Good for general coding tasks
- **qwen2.5-coder**: Fast and efficient, good for smaller projects
- **mistral**: General purpose, also works well for code

## Resources

- [OpenCode Docs](https://opencode.ai/docs)
- [Ollama Models](https://ollama.com/library)
- [opencode.nvim Plugin](https://github.com/NickvanDyke/opencode.nvim)
