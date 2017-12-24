#!/bin/bash
set -e

SESSION=dots

if tmux has-session -t $SESSION 2> /dev/null; then
  tmux attach -t $SESSION
  exit
fi

tmux new-session -d -s $SESSION -n vim

# 1. Editing
tmux send-keys -t vim "vim -c CommandT" Enter

# 2. Shell
tmux new-window -n zsh
tmux send-keys -t zsh "git status" Enter

tmux attach -t $SESSION:vim
