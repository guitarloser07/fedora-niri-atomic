#!/bin/bash
# Copy default niri and noctalia configs from /etc/skel on first login

SKEL_DIR="/etc/skel/.config"
CONFIG_DIR="$HOME/.config"

for app in niri noctalia; do
    src="$SKEL_DIR/$app"
    dest="$CONFIG_DIR/$app"
    if [ -d "$src" ] && [ ! -d "$dest" ]; then
        cp -r "$src" "$dest"
    fi
done
