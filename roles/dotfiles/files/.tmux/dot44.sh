#!/bin/bash
set -e

name=dot44

if tmux has-session -t $name 2> /dev/null; then
  tmux attach -t $name
  exit
fi

cd $CODEPATH/work/cars/$name

tmux new-session -d -s $name -n edit

# 1. Editing
tmux send-keys -t edit "vim" Enter

tmux new-window -n term
tmux split-window -t term -v
tmux send-keys -t term.1 "sbt" Enter
tmux send-keys -t term.2 "git status" Enter

tmux attach -t $name:edit.1
