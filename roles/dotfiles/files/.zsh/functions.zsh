function t() {
  emulate -L zsh
  if [ -x .tmux ]; then
    ./.tmux
    return
  else
    tmux new-session
  fi
}

# Decide cursor shape escape sequence
function set-cursor-sequence {
  case $(uname) in
    "Darwin")
      BLOCK="\E]50;CursorShape=0\C-G"
      LINE="\E]50;CursorShape=1\C-G"
      TMUXBLOCK="\EPtmux;\E\E]50;CursorShape=0\x7\E\\"
      TMUXLINE="\EPtmux;\E\E]50;CursorShape=1\x7\E\\"
      ;;
    "Linux")
      BLOCK="\033[2 q"
      LINE="\033[6 q"
      TMUXBLOCK="\033Ptmux;\033\033[2 q\x7\033\\"
      TMUXLINE="\033Ptmux;\033\033[6 q\x7\033\\"
      ;;
  esac

  if [[ -n $TMUX ]]; then
    BLOCK=$TMUXBLOCK
    LINE=$TMUXLINE
  fi
}

set-cursor-sequence
# Use a line cursor for insert mode, block for normal
function zle-keymap-select zle-line-init zle-line-finish {
case $KEYMAP in
  vicmd)      print -n -- "$BLOCK";; # block cursor
  viins|main) print -n -- "$LINE";; # line cursor
esac
zle reset-prompt
zle -R
}

# Always default to block on ending a command
function zle-line-finish {
  print -n -- "$BLOCK"
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
