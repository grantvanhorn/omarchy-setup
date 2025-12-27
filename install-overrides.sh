#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/dotfiles"

# --- Hyprland Overrides ---

HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
OVERRIDES_CONFIG="$SCRIPT_DIR/hyprland-overrides.conf"
SOURCE_LINE="source = $OVERRIDES_CONFIG"

# Check if hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Hyprland config not found at $HYPRLAND_CONFIG"
    echo "Please install hyprland first"
    exit 1
fi

# Check if overrides config exists
if [ ! -f "$OVERRIDES_CONFIG" ]; then
    echo "Overrides config not found at $OVERRIDES_CONFIG"
    exit 1
fi

# Check if source line already exists in hyprland.conf
if grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    echo "Source line already exists in $HYPRLAND_CONFIG"
else
    echo "Adding source line to $HYPRLAND_CONFIG"
    echo "" >> "$HYPRLAND_CONFIG"
    echo "$SOURCE_LINE" >> "$HYPRLAND_CONFIG"
    echo "Source line added successfully"
fi

echo "Hyprland overrides setup complete!"

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
