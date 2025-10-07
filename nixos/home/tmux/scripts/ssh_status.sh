#!/bin/sh
if [ -n "$SSH_CONNECTION" ]; then
  USERNAME="$USER"
  HOSTNAME="$(hostname -s)"
  printf '#[fg=white,bold,italics]%s@%s#[default]' "$USERNAME" "$HOSTNAME"
fi
