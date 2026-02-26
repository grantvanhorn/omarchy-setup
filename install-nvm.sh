#!/bin/sh

# Remove system Node.js if installed (we want NVM only)
if command -v pacman &> /dev/null; then
    # Check if nodejs or nodejs-git is installed
    if pacman -Q nodejs &> /dev/null || pacman -Q nodejs-git &> /dev/null; then
        echo "Removing system Node.js installation to use NVM only..."
        sudo pacman -R nodejs nodejs-git --noconfirm 2>/dev/null || true
    fi
fi

# Download and install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Add nvm to .bashrc if not already present
if ! grep -q 'NVM_DIR' "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# NVM configuration' >> "$HOME/.bashrc"
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.bashrc"
    echo 'set -h' >> "$HOME/.bashrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.bashrc"
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> "$HOME/.bashrc"
    echo 'set +h' >> "$HOME/.bashrc"
fi

# Source nvm for current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js via nvm
nvm install node
nvm use node