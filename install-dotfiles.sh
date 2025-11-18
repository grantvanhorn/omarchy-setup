#!/bin/bash

# --- Custom Setup Variables ---
# The target directory for the symlinks (your home directory)
TARGET_DIR="$HOME"
# The directory where your dotfiles repository lives
STOW_DIR="/home/ransom/Development/omarchy-setup/dotfiles"

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
