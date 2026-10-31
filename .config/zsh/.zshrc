mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# === History ===
HISTSIZE=5000                           # commands stored in memory
HISTFILE="$XDG_STATE_HOME/zsh/history"  # history file
SAVEHIST=$HISTSIZE                      # commands saved to history file
setopt inc_append_history               # saves each command immediately, but ctrl-p/ctrl-n only walk this session (atuin searches all)
setopt hist_ignore_space                # type a space before a command to not save it to history
setopt hist_ignore_all_dups             # removes older duplicate commands
setopt hist_find_no_dups                # skips over duplicates when searching history
setopt hist_reduce_blanks               # cleans up accidental extra spaces

# === Key Binds ===
bindkey -v   # vim mode
KEYTIMEOUT=1 # wait 10ms (not 400ms) after Esc before switching to normal mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^y' autosuggest-accept

# load ghostty shell integration into tmux
if [[ -n $TMUX && -n $GHOSTTY_RESOURCES_DIR ]]; then
    source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

# vim mode cursor: block in normal mode, bar in insert mode
# (ghostty's shell integration does this locally, but isn't loaded over SSH)
zle-line-init zle-keymap-select() {
    if [[ $KEYMAP == vicmd || $KEYMAP == visual ]]; then
        print -n '\e[1 q' # block
    else
        print -n '\e[5 q' # bar
    fi
}
zle -N zle-line-init
zle -N zle-keymap-select

# Ctrl+h/j/k/l: the prompt has no splits, so hand off straight to tmux panes
# (navigate.sh) or, outside tmux, to macOS windows (Hammerspoon, when installed).
_navigate() {
    local direction=${WIDGET#navigate-}
    if [[ -n $TMUX ]]; then
        ~/.config/tmux/navigate.sh $direction &!
    elif (( $+commands[hs] )); then
        hs -q -c "navigateWindow('$direction')" >/dev/null &!
    fi
}
for key direction in h left j down k up l right; do
    zle -N navigate-$direction _navigate
    bindkey -M viins "^$key" navigate-$direction
    bindkey -M vicmd "^$key" navigate-$direction
done

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
zstyle ':completion:*' menu no                          # remove zsh's menu in favour of fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'       # enable group support for completions
zstyle ':fzf-tab:*' switch-group '<' '>'                # switch group using `<` and `>`
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons --group-directories-first $realpath' # preview folder contents when completing with cd

# === Aliases ===
alias ls='eza --icons --group-directories-first'
alias ll='ls -lh --grid'
alias lsa="ls -a"
alias tree='eza --group-directories-first --tree -L 3'

alias ..='cd ..'
alias c='clear'

alias n='nvim'
alias gg='lazygit'
alias t="tmux"
