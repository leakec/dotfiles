# Yay install
* From [GitHub](https://github.com/Jguer/yay)
* `sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si`
* `yay -Y --gendb`
* `yay -Syu --devel`
* `yay -Y --devel --save`

# Yay packages
* `yay -Sy rsync neovim fzf ripgrep python-click python-colorthief python-pywal16 python-pywalfox awww hypridle hyprlock dunst cmake zsh waybar zip unzip inotify-tools cliphist zoxide lm_sensors sway-audio-idle-inhibit-git libnotify eza zellij bat ttf-font-awesome ttf-nerd-fonts-symbols-common ttf-jetbrains-mono-nerd ttf-hack-nerd pamixer lazygit rofi fd wl-clipboard less tree-sitter-cli npm pipewire-pulse wireplumber`

# Basic directories
* `mkdir -p ~/Downloads`
* `mkdir -p ~/Documents`
* `mkdir -p ~/Pictures`
* `mkdir -p ~/.config/zellij/themes`

# Change shell
* `touch ~/.zshrc_darts`
* `chsh` - Follow prompts and enter `/usr/bin/zsh` as your shell.

# Rust
* `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

# Run awww manually once. Create symlink
* `(awww-daemon &) && python ~/.config/hypr/wallpaper/sort_wallpapers.py --randomize-list`
* `ln -s ~/.cache/wal/hyprland-colors.lua ~/.config/hypr/hyprland-colors.lua`

# Sensors
* Run `lm_sensors --auto`

# Themes for ssdm if desired
* https://github.com/Keyitdev/sddm-astronaut-theme

# Kvantum QT theme if desired
```
yay -Sy kvantum
mkdir -p ~/.config/Kvantum/pywal
ln -s ~/.cache/wal/pywal.kvconfig ~/.config/Kvantum/pywal
ln -s ~/.cache/wal/pywal.svg ~/.config/Kvantum/pywal
```
Then, open Kvantum manager and choose the pywal theme.

# GTK prefer dark
```
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```
