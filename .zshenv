# ensures cli tools/desktop apps store their files in here instead of ~/
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# sets the zsh directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# PATH
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"
