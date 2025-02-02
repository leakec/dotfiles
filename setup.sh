#!/bin/bash

PKGS=("zshrc" "zellij" "wal" "vim" "rofi" "nvim" "kitty" "hypr")

# Setup symlink in hypr
if [ ! -L "~/.config/hypr/monitors.conf" ]; then
    ln -rs ~/.config/hypr/laptop_monitors.conf ~/.config/hypr/monitors.conf
fi

for pkg in ${PKGS[@]}; do
    stow --adopt -nv $pkg
done
