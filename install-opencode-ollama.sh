#!/bin/bash

# Install OpenCode with Ollama setup script
# This sets up OpenCode to use Ollama for free, local AI coding assistance

set -e

echo "🚀 Setting up OpenCode with Ollama (Free Local AI)"

# Check if running on Arch Linux
if [ -f /etc/arch-release ]; then
    echo "📦 Detected Arch Linux"

    # Install Ollama
    if ! command -v ollama &> /dev/null; then
        echo "Installing Ollama..."
        # Check if yay or paru is available
        if command -v paru &> /dev/null; then
            paru -S ollama-bin --noconfirm
        elif command -v yay &> /dev/null; then
            yay -S ollama-bin --noconfirm
        else
            echo "⚠️  Please install paru or yay first, or install Ollama manually:"
            echo "   curl -fsSL https://ollama.com/install.sh | sh"
            exit 1
        fi
    else
        echo "✅ Ollama is already installed"
    fi

    # Start Ollama service
    echo "🔧 Starting Ollama service..."
    if ! systemctl is-active --quiet ollama; then
        sudo systemctl enable --now ollama
    else
        echo "✅ Ollama service is already running"
    fi
else
    echo "📦 Installing Ollama via official installer..."
    if ! command -v ollama &> /dev/null; then
        curl -fsSL https://ollama.com/install.sh | sh
    else
        echo "✅ Ollama is already installed"
    fi
fi

# Check if OpenCode is installed
if ! command -v opencode &> /dev/null; then
    echo "⚠️  OpenCode is not installed. Installing..."
    # Try different installation methods
    if command -v pacman &> /dev/null; then
        sudo pacman -S opencode --noconfirm || echo "⚠️  Could not install via pacman, try: npm install -g opencode-ai"
    elif command -v npm &> /dev/null; then
        npm install -g opencode-ai
    else
        echo "⚠️  Please install OpenCode manually:"
        echo "   curl -fsSL https://opencode.ai/install | bash"
        exit 1
    fi
else
    echo "✅ OpenCode is already installed"
fi

echo ""
echo "📥 Next steps:"
echo "1. Download a coding model (this may take a while):"
echo "   ollama pull deepseek-coder-v2"
echo ""
echo "2. Alternative models you can try:"
echo "   ollama pull codellama        # Meta's CodeLlama"
echo "   ollama pull qwen2.5-coder    # Qwen Coder"
echo ""
echo "3. Configure OpenCode to use Ollama:"
echo "   opencode"
echo "   /connect"
echo "   (Select 'ollama' as provider)"
echo ""
echo "4. Restart Neovim to load the OpenCode plugin"
echo ""
echo "✅ Setup complete! The Neovim plugin is configured in:"
echo "   dotfiles/nvim/lua/plugins/opencode.lua"
echo ""
echo "Usage in Neovim:"
echo "  <leader>oc  - Open OpenCode chat"
echo "  <leader>or  - Refactor selected code"
