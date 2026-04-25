# This file is only read for INTERACTIVE shells

# ===============================================================================================
# Theme Configuration (Instant Prompt)
# ===============================================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
    
# ===============================================================================================
# Plugin Manager Configuratoin (Zinit)
# ===============================================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git

# fzf-tab config
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ===============================================================================================
# History Configuration
# ===============================================================================================
HISTSIZE=5000                           # commands stored in memory
HISTFILE=~/.config/zsh/.zsh_history     # history file
SAVEHIST=$HISTSIZE                      # commands saved to history file
setopt appendhistory                    # appends commands to history file insted of overwriting
setopt sharehistory                     # shares commands across active terminsal sessions
setopt hist_ignore_space                # type a space before a command to not save it to history
setopt hist_ignore_all_dups             # removes older duplicate commands
setopt hist_save_no_dups                # older duplicate commands are removed
setopt hist_ignore_dups                 # only saves new commands
setopt hist_find_no_dups                # skips over duplicates when searching history

# ===============================================================================================
# Keybinds
# ===============================================================================================
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ===============================================================================================
# Aliases
# ===============================================================================================
alias ls='ls --color'
alias ..='cd ..'
alias c='clear'

# ===============================================================================================
# Other Configuration
# ===============================================================================================
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

