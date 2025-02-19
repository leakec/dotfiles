#!/bin/bash

PKGS=("zshrc" "zellij" "wal" "vim" "rofi" "nvim" "kitty" "hypr" "tmux" "applications" "lazygit")

# Setup symlink in hypr
if [ ! -L "~/.config/hypr/monitors.conf" ]; then
    ln -rs ~/.config/hypr/laptop_monitors.conf ~/.config/hypr/monitors.conf
fi

show_help() {
    echo "Usage: $0 [-h] [-s]"
    echo ""
    echo "Options:"
    echo "  -h    Show this help message"
    echo "  -s    Sync the configs"
}

# Default values
sync_flag=0

# Parse command-line options
while getopts ":hs" opt; do
    case ${opt} in
        h )
            show_help
            exit 0
            ;;
        s )
            sync_flag=1
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done

if [ $sync_flag -eq 1 ]; then
    for pkg in ${PKGS[@]}; do
        stow --adopt $pkg
    done
else
    for pkg in ${PKGS[@]}; do
        stow --adopt -nv $pkg
    done
fi
