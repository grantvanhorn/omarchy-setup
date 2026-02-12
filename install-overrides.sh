#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/dotfiles"

# --- Waybar Overrides ---

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"

# Check if waybar config directory exists
if [ ! -d "$WAYBAR_CONFIG_DIR" ]; then
    echo "Waybar config directory not found at $WAYBAR_CONFIG_DIR"
    echo "Please install waybar first"
    exit 1
fi

# Check if waybar dotfiles exist
if [ ! -d "$STOW_DIR/waybar" ]; then
    echo "Waybar dotfiles not found at $STOW_DIR/waybar"
    exit 1
fi

# Remove existing waybar config files to prevent stow conflicts
echo "Removing existing waybar config files..."
rm -f "$WAYBAR_CONFIG_DIR/config.jsonc"
rm -f "$WAYBAR_CONFIG_DIR/style.css"

# Stow waybar config
echo "Stowing waybar config..."
stow --dir="$STOW_DIR" --target="$WAYBAR_CONFIG_DIR" waybar

if [ $? -eq 0 ]; then
    echo "Waybar overrides setup complete!"
else
    echo "Failed to stow waybar config"
    exit 1
fi

# --- Hyprland Stow Overrides ---

HYPR_CONFIG_DIR="$HOME/.config/hypr"

# Check if hypr config directory exists
if [ ! -d "$HYPR_CONFIG_DIR" ]; then
    echo "Hypr config directory not found at $HYPR_CONFIG_DIR"
    echo "Please install hyprland first"
    exit 1
fi

# Check if hypr dotfiles exist
if [ ! -d "$STOW_DIR/hypr" ]; then
    echo "Hypr dotfiles not found at $STOW_DIR/hypr"
    exit 1
fi

# Remove existing hypr config files that we're replacing to prevent stow conflicts
echo "Removing existing hypr config files we're replacing..."
rm -f "$HYPR_CONFIG_DIR/monitors.conf"
rm -f "$HYPR_CONFIG_DIR/looknfeel.conf"
rm -f "$HYPR_CONFIG_DIR/bindings.conf"
rm -f "$HYPR_CONFIG_DIR/input.conf"

# Stow hypr config
echo "Stowing hypr config..."
stow --dir="$STOW_DIR" --target="$HYPR_CONFIG_DIR" hypr

if [ $? -eq 0 ]; then
    echo "Hypr overrides setup complete!"
else
    echo "Failed to stow hypr config"
    exit 1
fi
