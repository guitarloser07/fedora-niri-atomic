#!/usr/bin/env bash
set -oue pipefail

# Enable the first-login setup service for all users
mkdir -p /etc/systemd/user/graphical-session.target.wants
ln -sf /usr/lib/systemd/user/niri-skel-setup.service \
    /etc/systemd/user/graphical-session.target.wants/niri-skel-setup.service
