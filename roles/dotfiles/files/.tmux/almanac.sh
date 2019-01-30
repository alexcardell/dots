#!/bin/bash
set -e

name=almanac

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd ~/Code/$name

tmux new-session -d -s $name -n edit

# 1. Editing
tmux split-window -h -t $name:edit
tmux send-keys -t $name:edit.2 "git status" Enter

tmux attach -t $name:edit.1
