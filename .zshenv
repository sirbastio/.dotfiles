# XDG default directories: many tools ignore them unless set, some tools will still ignore regardless
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# sets the zsh directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"
