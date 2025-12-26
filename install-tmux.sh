#!/bin/bash

# Install tmux
yay -S --noconfirm --needed tmux

# Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install plugins (runs TPM's install script)
~/.tmux/plugins/tpm/bin/install_plugins
