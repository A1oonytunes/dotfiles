# ============================================================
# Alon's .zshrc - Fedora Linux / Ghostty / Zinit
# ============================================================

# --------------- Zinit Plugin Manager ---------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# --------------- Completion ---------------
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# --------------- History ---------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# --------------- Key Bindings ---------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# --------------- Modern CLI Aliases ---------------
alias ls="eza --icons"
alias ll="eza -l --git --icons"
alias la="eza -la --git --icons"
alias lt="eza --tree --icons --level=2"
alias cat="bat"
alias grep="rg"
alias find="fd"
alias top="btop"
alias lg="lazygit"
alias preview="fzf --preview 'bat --color=always {}'"
alias cls="clear"
alias reload="exec zsh"
alias zshconfig="$EDITOR ~/.zshrc"
alias ghosttyconfig="$EDITOR ~/.config/ghostty/config"

# --------------- Tool Integrations ---------------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# --------------- Environment ---------------
export EDITOR="nano"
export VISUAL="$EDITOR"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"
