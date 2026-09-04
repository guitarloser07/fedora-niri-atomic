#!/bin/bash
# Copy default configs from /etc/skel on first login
# (niri config lives at /etc/niri/config.kdl, applied system-wide)

SKEL_DIR="/etc/skel/.config"
CONFIG_DIR="$HOME/.config"

for app in noctalia kitty; do
    src="$SKEL_DIR/$app"
    dest="$CONFIG_DIR/$app"
    if [ -d "$src" ] && [ ! -d "$dest" ]; then
        cp -r "$src" "$dest"
    fi
done
