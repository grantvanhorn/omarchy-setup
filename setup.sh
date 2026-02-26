#!/bin/sh

# Install NVM first so it's available for other scripts
. ./install-nvm.sh

# Install all other programs
. ./install-cursor.sh
. ./install-eza.sh
. ./install-ghostty.sh
. ./install-stow.sh
. ./install-tmux.sh
. ./install-zsh.sh

# Install overrides after everything is installed
. ./install-overrides.sh

# Final step after everything else is installed
. ./set-shell.sh