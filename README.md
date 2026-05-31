# dotfiles

Alon's Fedora Linux dotfiles — Sway + Waybar + Ghostty setup.

## Stack

| Tool | Role |
|------|------|
| [Sway](https://swaywm.org/) | Wayland compositor / tiling WM |
| [Waybar](https://github.com/Alexays/Waybar) | Status bar (bottom) |
| [Ghostty](https://ghostty.org/) | Terminal emulator |
| [Fish](https://fishshell.com/) | Shell (secondary) |
| [Zsh + Zinit](https://github.com/zdharma-continuum/zinit) | Primary shell |
| [Starship](https://starship.rs/) | Cross-shell prompt |
| [Fuzzel](https://codeberg.org/dnkl/fuzzel) | App launcher / dmenu |
| [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) | Notification center |

### CLI tools
`eza` · `bat` · `ripgrep` · `fd` · `fzf` · `zoxide` · `btop` · `lazygit`

## Install

### Fresh machine (installs everything + symlinks configs)

```bash
git clone git@github.com:A1oonytunes/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh
```

`bootstrap.sh` enables the required COPR repos, installs all packages via `dnf`, installs Starship and Zinit via their official scripts, sets Zsh as the default shell, then calls `install.sh` to symlink the configs.

### Config symlinks only (packages already installed)

```bash
git clone git@github.com:A1oonytunes/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Both scripts back up any existing file with a `.bak` suffix before overwriting.

## Layout

```
dotfiles/
├── .zshrc                         # Zsh (Zinit, aliases, env)
├── .bashrc / .bash_profile        # Bash fallback
├── .nanorc                        # Nano editor prefs
├── .gitconfig                     # Git identity
└── .config/
    ├── starship.toml              # Prompt theme
    ├── sway/
    │   ├── config                 # Sway keybinds, outputs, bar
    │   ├── power-menu.sh          # Fuzzel power menu
    │   └── config.d/              # Swayidle overrides
    ├── waybar/
    │   ├── config.jsonc           # Modules layout
    │   └── style.css              # Dark theme styling
    ├── ghostty/
    │   ├── config                 # Font, opacity, cursor
    │   └── themes/nightlake       # Custom color scheme
    ├── fuzzel/
    │   └── fuzzel.ini             # Launcher appearance
    └── swaync/
        ├── config.json            # Notification behavior
        └── style.css              # Notification styling
```

## Monitors

Configured for a dual-monitor setup:
- `DP-5`: 2560×1440 @ 180 Hz (primary, position 0,0)
- `DP-3`: 1920×1080 @ 144 Hz (left, position −1920,0)

Adjust `output` lines in `.config/sway/config` for your own displays.
