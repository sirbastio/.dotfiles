typeset -U path PATH

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# === History ===
HISTSIZE=5000                           # commands stored in memory
HISTFILE="$XDG_STATE_HOME/zsh/history"  # history file
SAVEHIST=$HISTSIZE                      # commands saved to history file
setopt appendhistory                    # appends commands to history file instead of overwriting
setopt sharehistory                     # shares commands across active terminal sessions
setopt hist_ignore_space                # type a space before a command to not save it to history
setopt hist_ignore_all_dups             # removes older duplicate commands
setopt hist_save_no_dups                # older duplicate commands are removed
setopt hist_find_no_dups                # skips over duplicates when searching history
setopt hist_reduce_blanks               # cleans up accidental extra spaces

# === Key Binds ===
bindkey -v   # vim mode 
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^y' autosuggest-accept

# === Shell Integrations ===
source "$XDG_DATA_HOME/zinit/zinit.git/zinit.zsh"
zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init --cmd cd zsh)"

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive tab matches
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
zstyle ':completion:*' menu no                          # use fzf-tab for completion matches
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview \
    'eza -1 --color=always --group-directories-first $realpath'

# === Aliases ===
if (( $+commands[eza] )); then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --grid'
    alias tree='eza --group-directories-first --tree -L 3 '
else
    alias ls='ls --color'
fi

alias ..='cd ..'
alias c='clear'

alias n='nvim'
alias gg='lazygit'
