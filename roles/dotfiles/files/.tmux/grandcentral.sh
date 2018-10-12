#!/bin/bash
set -e

name=grandcentral

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

root=~/bg/rides/website
cd $root

tmux new-session -d -s $name -n edit

# 1. Editing
tmux send-keys -t edit "vim" Enter

# 2. Terminal
tmux new-window -n term
tmux send-keys -t term "git status" Enter

# 3. Build
tmux new-window -n build
tmux send-keys "npm run webpack --watch" Enter

tmux split-window
tmux send-keys "npm run sass:watch" Enter

tmux split-window
tmux send-keys "npm run postcss:watch" Enter

tmux split-window
tmux send-keys "docker-compose up" Enter

tmux select-layout tiled

tmux attach -t $name:edit.1
