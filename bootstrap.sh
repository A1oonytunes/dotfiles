#!/usr/bin/env bash
# Bootstrap script — installs all packages, then symlinks configs via install.sh
set -euo pipefail

# ── helpers ───────────────────────────────────────────────────────────────────
bold=$'\e[1m'; green=$'\e[32m'; yellow=$'\e[33m'; red=$'\e[31m'; reset=$'\e[0m'
info() { printf '%s==>%s %s\n' "$green$bold" "$reset" "$*"; }
warn() { printf '%swarn:%s %s\n' "$yellow" "$reset" "$*"; }
die()  { printf '%serror:%s %s\n' "$red" "$reset" "$*" >&2; exit 1; }

command -v dnf &>/dev/null || die "dnf not found — this script targets Fedora/RHEL only."
[[ $EUID -eq 0 ]] && SUDO="" || SUDO="sudo"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── COPR repositories ─────────────────────────────────────────────────────────
info "Enabling COPR repositories…"
$SUDO dnf copr enable -y scottames/ghostty            # Ghostty terminal
$SUDO dnf copr enable -y atim/lazygit                 # lazygit
$SUDO dnf copr enable -y erikreider/SwayNotificationCenter  # swaync
$SUDO dnf copr enable -y lihaohong/yazi               # yazi file manager

# ── DNF packages ──────────────────────────────────────────────────────────────
info "Installing packages via dnf…"

$SUDO dnf install -y \
    `# ── Wayland / Sway stack ──` \
    sway waybar fuzzel swayidle swaylock \
    `# ── Screenshots & clipboard ──` \
    grim slurp wl-clipboard \
    `# ── Notifications (COPR: erikreider/SwayNotificationCenter) ──` \
    SwayNotificationCenter \
    `# ── Terminal (COPR: scottames/ghostty) ──` \
    ghostty \
    `# ── Shells ──` \
    zsh fish \
    `# ── CLI tools ──` \
    bat ripgrep fd-find fzf zoxide btop eza \
    `# ── Git tools (COPR: atim/lazygit) ──` \
    lazygit \
    `# ── File manager (COPR: lihaohong/yazi) ──` \
    yazi \
    `# ── System utilities ──` \
    polkit xdg-user-dirs curl git

# ── Starship prompt ───────────────────────────────────────────────────────────
info "Installing Starship prompt…"
if command -v starship &>/dev/null; then
    warn "starship already installed at $(command -v starship), skipping."
else
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

# ── Zinit (zsh plugin manager) ────────────────────────────────────────────────
info "Installing Zinit…"
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ -d "$ZINIT_HOME" ]]; then
    warn "Zinit already present at $ZINIT_HOME, skipping."
else
    bash -c "$(curl --fail --show-error --silent --location \
        https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# ── Flatpak apps ─────────────────────────────────────────────────────────────
info "Installing Flatpak apps…"
# Ensure flatpak and Flathub are available
$SUDO dnf install -y flatpak
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub app.zen_browser.zen   # Zen browser
flatpak install -y flathub dev.vencord.Vesktop   # Vesktop (Discord)

# ── Set Zsh as default shell ──────────────────────────────────────────────────
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    info "Setting Zsh as default shell…"
    ZSH_PATH="$(command -v zsh)"
    grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | $SUDO tee -a /etc/shells
    chsh -s "$ZSH_PATH"
else
    warn "Zsh already the default shell, skipping chsh."
fi

# ── Symlink dotfiles ──────────────────────────────────────────────────────────
info "Symlinking dotfiles…"
bash "$SCRIPT_DIR/install.sh"

echo ""
info "Bootstrap complete!"
echo "  • Start a new Zsh session (or run: exec zsh) to activate Zinit and Starship."
echo "  • Log out and back in (or restart Sway) to load the full desktop config."
