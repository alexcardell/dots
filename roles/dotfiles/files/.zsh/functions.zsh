function killport {
  pkill -P $(lsof -ntP -iTCP:9229)
}

function t {
  # tmux session startup function
  local project
  if [[ -n $1 ]]; then
    project=$1
  else
    project=$(basename "${$(pwd)//[.]/-}")
  fi

  if [[ -f ~/.tmux/$project\.sh ]]; then
    ~/.tmux/$project\.sh
    return
  fi

  tmux new-session -s $project
}

function tmux2 {
  local project tmuxFile session
  # tmux session startup function
  if [[ -n $1 ]]; then
    project=$1
  else
    project=$(basename "${$(pwd)//[.]/_}")
  fi

  # follow symlinks for true project name
  tmuxFile=~/.tmux/$project\.sh
  project=$(echo $(test -L $tmuxFile && readlink $tmuxFile || echo $project) \
    | sed 's/\.[^.]*$//')

  session=$(tmux ls -F '#{session_name}' | grep $project)
  if [[ -n $TMUX && -n $session ]]; then
    tmux switch-client -t $session
    return
  fi
  tmux attach -t $session

  # if [[ -f $tmuxFile ]]; then
  #   $tmuxFile
  #   return
  # fi

  # tmux new-session
}


function ask {
  local prompt reply
  prompt="y/n"

  while true; do
    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply="n"
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
    return 0;

  done
}

function set-cursor-sequence {
  # Decide cursor shape escape sequence
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
