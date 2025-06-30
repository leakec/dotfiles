# Yay install
* From [GitHub](https://github.com/Jguer/yay)
* `sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si`
* `yay -Y --gendb`
* `yay -Syu --devel`
* `yay -Y --devel --save`

# Yay packages
* `yay -Sy rsync neovim fzf ripgrep python-click python-colorthief python-pywal16 python-pywalfox swww swayidle dunst cmake npm yarn zsh waybar zip unzip inotify-tools clip-hist zoxide meld lm_sensors sway-audio-idle-inhibit-git libnotify eza zellij bat ttf-font-awesome ttf-nerd-fonts-symbols-common ttf-jetbrains-mono-nerd ttf-hack-nerd pamixer lazygit tmux rofi`

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

# Sensors
* Run `lm_sensors --auto`
