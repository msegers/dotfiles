#!/bin/bash
WALLPAPER_DIR="/home/skoltr/.config/wp/"

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
