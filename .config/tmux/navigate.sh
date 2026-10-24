#!/bin/sh
# Move to the tmux pane in a direction. At the window edge (or when zoomed),
# hand off to Hammerspoon to focus the macOS window in that direction instead.
# Usage: navigate.sh <left|down|up|right> [pane-id]

direction=$1
pane=${2:-$TMUX_PANE}

case $direction in
    left) edge=pane_at_left flag=-L ;;
    down) edge=pane_at_bottom flag=-D ;;
    up) edge=pane_at_top flag=-U ;;
    right) edge=pane_at_right flag=-R ;;
    *) echo "usage: $0 <left|down|up|right> [pane-id]" >&2; exit 1 ;;
esac

# Kept out of the command substitution: macOS /bin/sh (bash 3.2) brace-expands it there.
at_edge="#{||:#{$edge},#{window_zoomed_flag}}"
if [ "$(tmux display-message -p -t "$pane" "$at_edge")" = 1 ]; then
    hs -q -c "navigateWindow('$direction')" >/dev/null
else
    tmux select-pane -t "$pane" "$flag"
fi
