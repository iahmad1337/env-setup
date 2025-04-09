#!/bin/sh

set -eux

if tmux attach-session -d -t dev; then
    return 0
else
    tmux new-session -d -c "$HOME" -s dev -n "htop" "htop"
    tmux new-window -n "editor" -c "$HOME" "nvim $HOME/"
    tmux new-window -n "home" -c "$HOME"
    tmux attach-session -t dev
fi
