# Waybar Configuration for Hyprland

> **Note:** Built for Omarchy. Change application commands if your setup differs.

![Waybar Screenshot](images/waybar.png)

A simple and clean Waybar setup for Hyprland with optional Omarchy integration.
Focused on readability, low clutter, and predictable behavior.

## Features
- Omarchy menu and Hyprland workspaces
- Kernel version and now playing info
- Clock with date (12h / 24h toggle)
- Updates, screen recording, and voxtype status
- Tray, network, audio, CPU, and battery indicators

## Dependencies
- waybar, hyprland, playerctl, curl, imv  
- Nerd Font (recommended)

## Install
```bash
# Backup existing config (if any)
mkdir -p ~/.config/waybar-backup
[ -d ~/.config/waybar ] && cp -r ~/.config/waybar ~/.config/waybar-backup/waybar-$(date +%Y%m%d-%H%M%S)

# Install
mkdir -p ~/.config/waybar/scripts
cp -r . ~/.config/waybar/
chmod +x ~/.config/waybar/scripts/*.sh

# Reload
pkill waybar && waybar