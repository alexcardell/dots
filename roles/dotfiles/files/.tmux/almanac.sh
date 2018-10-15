#!/bin/bash
set -e

name=almanac

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd ~/projects/$name

tmux new-session -d -s $name -n edit

# 1. Editing
tmux send-keys -t edit "vim" Enter
tmux split-window -h
tmux send-keys "git status" Enter

tmux attach -t $name:edit.1
