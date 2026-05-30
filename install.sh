#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

link() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME_DIR/$1"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up existing $dst -> $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked $dst"
}

# Shell
link .zshrc
link .bashrc
link .bash_profile
link .profile
link .nanorc
link .gitconfig

# App configs
link .config/starship.toml
link .config/ghostty/config
link .config/fuzzel/fuzzel.ini
link .config/swaync/config.json
link .config/swaync/style.css
link .config/waybar/config.jsonc
link .config/waybar/style.css

# Sway
link .config/sway/config
link .config/sway/power-menu.sh
link .config/sway/config.d/20-swayidle.conf
link .config/sway/config.d/90-swayidle.conf

# Ghostty themes
for theme in "$DOTFILES_DIR/.config/ghostty/themes/"*; do
    name="$(basename "$theme")"
    link ".config/ghostty/themes/$name"
done

chmod +x "$HOME_DIR/.config/sway/power-menu.sh"

echo ""
echo "Done. Reload your shell or sway to apply changes."
