# This file is only read for INTERACTIVE shells
    
# === Plugin Manager (Zinit) ===
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# --- Plugins ---
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# --- Snippets ---
zinit snippet OMZP::git

# --- fzf-tab config ---
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# === History ====
HISTSIZE=5000                           # commands stored in memory
HISTFILE=~/.config/zsh/.zsh_history     # history file
SAVEHIST=$HISTSIZE                      # commands saved to history file
setopt appendhistory                    # appends commands to history file instead of overwriting
setopt sharehistory                     # shares commands across active terminal sessions
setopt hist_ignore_space                # type a space before a command to not save it to history
setopt hist_ignore_all_dups             # removes older duplicate commands
setopt hist_save_no_dups                # older duplicate commands are removed
setopt hist_ignore_dups                 # only saves new commands
setopt hist_find_no_dups                # skips over duplicates when searching history

# === Key Binds ===
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# === Aliases ===
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --grid'
alias tree='eza --tree -L 3'
alias ..='cd ..'
alias c='clear'
alias cat='bat'

# === Other ===
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
