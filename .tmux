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
tmux split-window -h -l 90
tmux send-keys -t vim.2 "git status" Enter

tmux attach -t $SESSION:vim.1
