#!/bin/sh

# Install all programs
. ./install-cursor.sh
. ./install-eza.sh
. ./install-ghostty.sh
. ./install-nvm.sh
. ./install-stow.sh
. ./install-tmux.sh
. ./install-zsh.sh

# Install overrides after everything is installed
. ./install-overrides.sh

# Final step after everything else is installed
. ./set-shell.sh
