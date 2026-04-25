# This file is ALWAYS read, whether its an interactive terminal or background script

# sets the zsh directory
export ZDOTDIR="$HOME/.config/zsh"

# ensures cli tools/desktop apps store their files in here instead of ~/
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# keep custom scripts organised
export PATH="$HOME/.local/bin:$PATH"
