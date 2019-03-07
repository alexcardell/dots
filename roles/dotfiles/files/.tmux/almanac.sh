#!/bin/bash
set -e

name=almanac

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd ~/Code/js/$name

tmux new-session -d -s $name -n edit

# 1. Editing
tmux send-keys -t $name:edit "vim" Enter

#2. Shell
tmux new-window -n term
tmux send-keys -t $name:term "git status" Enter

#3. Build
tmux new-window -n build
tmux split-window -h -t $name:build
tmux split-window -v -t $name:build.1

tmux send-keys -t $name:build.1 "yarn dev:client" Enter
tmux send-keys -t $name:build.2 "yarn sass --watch" Enter
tmux send-keys -t $name:build.3 "yarn dev:server" Enter

tmux attach -t $name:edit.1
