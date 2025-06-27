#!/bin/bash

CONFIG_FILES=(
    "$HOME/.config/hypr/waybar/config"
    "$HOME/.config/hypr/waybar/configs"
    "$HOME/.config/hypr/waybar/style.css"
    "$HOME/.cache/wal/colors-waybar.css"
)

trap "killall waybar" EXIT
STATE_FILE=$HOME/.config/hypr/waybar/waybar_state.txt

config_file=$HOME/.config/hypr/waybar/config
if [ ! -f $config_file ]; then
    ln -sf $HOME/.config/hypr/waybar/configs/main $config_file
fi

style_file=$HOME/.config/hypr/waybar/style.css 
if [ ! -f $style_file ]; then
    ln -sf $HOME/.config/hypr/waybar/styles/main.css $style_file
fi

trap 'echo "Received SIGINT"; exit 1' INT

# Function to start waybar and track its PID
start_waybar() {
    echo "" > "$STATE_FILE"
    cp -r $HOME/.cache/wal/colors-waybar.css $HOME/.config/hypr/waybar/
    setsid waybar -c $HOME/.config/hypr/waybar/config -s $HOME/.config/hypr/waybar/style.css &
    WAYBAR_PID=$!
}

# Function to stop waybar
cleanup() {
    [[ -n "$WAYBAR_PID" ]] && kill "$WAYBAR_PID"
}

while true; do
    start_waybar
    inotifywait -P -e modify,attrib ${CONFIG_FILES[@]}
    cleanup
    sleep 0.1
done
