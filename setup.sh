#!/bin/sh

# Install all programs
. ./install-ghostty.sh
. ./install-nvm.sh
. ./install-cursor.sh

# Install overrides after everything is installed
. ./install-overrides.sh
