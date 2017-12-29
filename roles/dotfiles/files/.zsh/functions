function t() {
  emulate -L zsh
  if [ -x .tmux ]; then
    ./.tmux
    return
  else
    tmux new-session
  fi
}
