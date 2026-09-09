#!/bin/bash
# Copy default configs from /etc/skel on first login
# (niri config lives at /etc/niri/config.kdl, applied system-wide)

SKEL_DIR="/etc/skel/.config"
CONFIG_DIR="$HOME/.config"

for app in noctalia kitty gtk-3.0 gtk-4.0; do
    src="$SKEL_DIR/$app"
    dest="$CONFIG_DIR/$app"
    if [ -d "$src" ] && [ ! -d "$dest" ]; then
        cp -r "$src" "$dest"
    fi
done

# Ensure square-corner GTK override is present even if Noctalia already
# created ~/.config/gtk-*/gtk.css with only the noctalia.css import.
for ver in gtk-3.0 gtk-4.0; do
    skel_css="$SKEL_DIR/$ver/gtk.css"
    dest_css="$CONFIG_DIR/$ver/gtk.css"
    if [ -f "$skel_css" ] && [ -d "$CONFIG_DIR/$ver" ] && [ ! -f "$dest_css" ]; then
        cp "$skel_css" "$dest_css"
    fi
done

# Mirror Noctalia's Tauon theme into the Flatpak data dir.
# (A symlink won't work: inside the sandbox ~/.local/share is the app's own
# data dir, so a link pointing at the host theme path would dangle/loop.
# Copy when the Noctalia-rendered source is newer. Runs every login, so the
# first login can seed configs while a later login picks up the theme once
# Noctalia has fetched the community template and rendered it.)
TAUON_SRC="${XDG_DATA_HOME:-$HOME/.local/share}/TauonMusicBox/theme/Noctalia.ttheme"
TAUON_DEST="$HOME/.var/app/com.github.taiko2k.tauonmb/data/TauonMusicBox/theme/Noctalia.ttheme"
if [ -f "$TAUON_SRC" ]; then
    mkdir -p "$(dirname "$TAUON_DEST")"
    if [ ! -f "$TAUON_DEST" ] || [ "$TAUON_SRC" -nt "$TAUON_DEST" ]; then
        cp "$TAUON_SRC" "$TAUON_DEST"
    fi
fi
