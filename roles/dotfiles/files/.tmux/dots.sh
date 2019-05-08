#!/bin/bash
set -e

name=dots

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd $CODEPATH/$name

tmux new-session -d -s $name -n edit

# 1. Editing
tmux send-keys -t edit "vim" Enter

tmux new-window -n term
tmux send-keys -t term "git status" Enter
