#!/bin/bash

# --- Custom Setup Variables ---
# The target directory for the symlinks (your home directory)
TARGET_DIR="$HOME"
# The directory where your dotfiles repository lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/dotfiles"

# NOTE: The REPO_URL and REPO_NAME variables are kept, but the
# cloning logic is commented out because you already have the
# repository set up at $STOW_DIR.

# REPO_URL="https://github.com/typecraft-dev/dotfiles"
# REPO_NAME="dotfiles"
# -----------------------------

## 🛠️ Function to Check for Stow
is_stow_installed() {
    # On Arch-based systems, 'pacman -Qi' checks if a package is installed.
    pacman -Qi "stow" &> /dev/null
}

## ➡️ Check Dependencies
if ! is_stow_installed; then
    echo "🚨 Error: GNU Stow is not installed. Install it first (e.g., 'sudo pacman -S stow')."
    exit 1
fi

---

## ☁️ Handle Repository (Modified)

# --- Original cloning logic removed/commented out ---
# Your script assumes the repository is already set up and cloned
# at the location defined by STOW_DIR. We'll check if the package
# directory exists before attempting to stow.

if [ ! -d "$STOW_DIR/zshrc" ]; then
    echo "🚨 Error: The zshrc package directory was not found at $STOW_DIR/zshrc."
    echo "Please ensure your dotfiles are correctly set up at the specified location."
    exit 1
fi

---

## 🔗 Stow the 'zshrc' Package

# Ensure old configs are removed to prevent conflicts before stowing
echo "🧹 Removing old zshrc configuration at $TARGET_DIR/.zshrc (if it exists)."
rm -f "$TARGET_DIR/.zshrc"

# Perform the stow operation
echo "✅ Stowing 'zshrc' package..."
stow --dir="$STOW_DIR" \
     --target="$TARGET_DIR" \
     zshrc

# Check if the stow operation was successful
if [ $? -eq 0 ]; then
    echo "🎉 Success! The symlink for zshrc is now set up:"
    echo "   $TARGET_DIR/.zshrc -> $STOW_DIR/zshrc/.zshrc"
else
    echo "❌ Failed to stow the zshrc package."
    exit 1
fi

---

## 🔗 Stow the 'tmux' Package

# Ensure old configs are removed to prevent conflicts before stowing
echo "🧹 Removing old tmux configuration at $TARGET_DIR/.tmux.conf (if it exists)."
rm -f "$TARGET_DIR/.tmux.conf"

# Perform the stow operation
echo "✅ Stowing 'tmux' package..."
stow --dir="$STOW_DIR" \
     --target="$TARGET_DIR" \
     tmux

# Check if the stow operation was successful
if [ $? -eq 0 ]; then
    echo "🎉 Success! The symlink for tmux is now set up:"
    echo "   $TARGET_DIR/.tmux.conf -> $STOW_DIR/tmux/.tmux.conf"
else
    echo "❌ Failed to stow the tmux package."
    exit 1
fi

---

## 🔗 Stow the 'nvim' Package

NVIM_CONFIG_DIR="$TARGET_DIR/.config/nvim"

# Check if nvim config directory exists
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo "⚠️  Warning: Neovim config directory not found at $NVIM_CONFIG_DIR"
    echo "   Creating directory..."
    mkdir -p "$NVIM_CONFIG_DIR"
fi

# Check if nvim dotfiles exist
if [ ! -d "$STOW_DIR/nvim" ]; then
    echo "🚨 Error: The nvim package directory was not found at $STOW_DIR/nvim."
    echo "Please ensure your dotfiles are correctly set up at the specified location."
    exit 1
fi

# Remove existing nvim plugin files that we're replacing to prevent stow conflicts
echo "🧹 Removing existing nvim plugin files we're replacing..."
rm -f "$NVIM_CONFIG_DIR/lua/plugins/neo-tree-show-hidden.lua"

# Perform the stow operation
echo "✅ Stowing 'nvim' package..."
stow --dir="$STOW_DIR" \
     --target="$NVIM_CONFIG_DIR" \
     nvim

# Check if the stow operation was successful
if [ $? -eq 0 ]; then
    echo "🎉 Success! The symlinks for nvim are now set up:"
    echo "   $NVIM_CONFIG_DIR/lua/plugins/ -> $STOW_DIR/nvim/lua/plugins/"
else
    echo "❌ Failed to stow the nvim package."
    exit 1
fi
