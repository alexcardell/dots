#!/bin/bash
set -e

name=alex.cardell.io
sessionname=$(echo $name | tr '.' '-')

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd $CODEPATH/js/$name

tmux new-session -d -s $sessionname -n edit

# 1. Editing
tmux send-keys -t $sessionname:edit "vim" Enter

#2. Shell
tmux new-window -n term
tmux send-keys -t $sessionname:term "git status" Enter

#3. Build
tmux new-window -n build
tmux split-window -h -t $sessionname:build
tmux split-window -v -t $sessionname:build.1
tmux split-window -v -t $sessionname:build.3

tmux send-keys -t $sessionname:build.1 "yarn dev:js" Enter
tmux send-keys -t $sessionname:build.2 "yarn sass --watch" Enter
tmux send-keys -t $sessionname:build.3 "yarn dev:re" Enter
tmux send-keys -t $sessionname:build.4 "yarn dev:server" Enter

tmux attach -t $sessionname:edit.1
