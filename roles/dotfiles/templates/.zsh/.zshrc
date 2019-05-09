# {{ ansible_managed }}

OS=$(uname)
OS=$OS:l

bindkey -v
bindkey -M viins "jk" vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors
colors

#---------
# History
#---------
bindkey "^R" history-incremental-search-backward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end # cursor up
bindkey "\e[B" history-beginning-search-forward-end # down

#---------
# Options
#---------
setopt autocd
setopt autoparamslash
setopt autopushd
setopt pushdignoredups
setopt pushdsilent
setopt histignorealldups
setopt promptsubst
unsetopt beep

#------------
# Completion
#------------
zstyle ':completion:*' menu select
zmodload zsh/complist

#--------
# Prompt
#--------
# see man zshexpn/zshmisc for explanations
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:*' actionformats \
  '%c%u[%F{cyan}%b%f%|%F{red}%a%f]'
zstyle ':vcs_info:*' formats \
  '%c%u[%F{cyan}%b%f]%m'
zstyle ':vcs_info:git*+set-message:*' hooks git-st

function +vi-git-st() {
  local ahead behind
  local -a gitstatus
  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null \
    | wc -l | tr -d '[:space:]')
  (( $ahead )) && gitstatus+=( "+${ahead}" )
  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null \
    | wc -l | tr -d '[:space:]')
  (( $behind )) && gitstatus+=( "-${behind}" )
  hook_com[misc]+="%F{cyan}${(j:/:)gitstatus}%f"

  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}●%f"
  fi
}

typeset -F SECONDS

preexec() {
  timer=${timer:-$SECONDS}
}

precmd() {
  vcs_info
  if [ $timer ]; then
    timer_value=$(($SECONDS - $timer))
    if (( $timer_value > 0.5 )); then
      timer_show=$(printf "%.3fs" "$timer_value")
    else
      unset timer_show
      unset timer_value
    fi
    unset timer
  fi
}

_ZSH_PROMPT_ICON='%B%F{red}%> %f%b'
function () {
  local INTMUX=$([[ "$TERM" =~ "tmux" ]] && echo tmux)
  if [ -n "$INTMUX" -a -n "$TMUX" ]; then
    LVL=$(($SHLVL - 1))
  else
    LVL=$SHLVL
  fi
  _ZSH_PROMPTARROW=$(printf '%%F{red}%%B>%.0s%%b%%f' {1..$LVL})
}

PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex ${_ZSH_PROMPTARROW} '
RPROMPT='%F{240}${timer_show} %F{grey}%3~ ${vcs_info_msg_0_}%f'

# Functions
function killport {
  pkill -P $(lsof -ntP -iTCP:9229)
}

# function t {
#   # tmux session startup function
#   local project session
#   if [[ -n $1 ]]; then
#     project=$1
#   else
#     # fall back to directory name if no project name given
#     project=$(basename "${$(pwd)//[.]/-}")
#   fi

#   session=$(tmux ls -F '#{session_name}' | grep "$project$")

#   # look for existing session and attach/switch
#   if [[ -n $session ]]; then
#     if [[ -n $TMUX ]]; then
#       tmux switch-client -t $session
#     else
#       tmux attach-session -t $session
#     fi
#     return
#   fi

#   # look for setup script
#   if [[ -f ~/.tmux/$project\.sh ]]; then
#     ~/.tmux/$project\.sh
#     return
#   fi

#   # if all else fails, start new default session
#   tmux new-session -s $project
# }

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
  # case $(uname) in
  {% if ansible_os_family == 'Darwin' %}
    # "Darwin")
    BLOCK="\E]50;CursorShape=0\C-G"
    LINE="\E]50;CursorShape=1\C-G"
    TMUXBLOCK="\EPtmux;\E\E]50;CursorShape=0\x7\E\\"
    TMUXLINE="\EPtmux;\E\E]50;CursorShape=1\x7\E\\"
    # ;;
  {% endif %}
  {% if ansible_os_family == 'Archlinux' %}
    # "Linux")
      BLOCK="\033[2 q"
      LINE="\033[6 q"
      TMUXBLOCK="\033Ptmux;\033\033[2 q\x7\033\\"
      TMUXLINE="\033Ptmux;\033\033[6 q\x7\033\\"
      # ;;
  # esac
  {% endif %}

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

# Aliases
alias :q='exit'
alias cdp='cd $(git rev-parse --show-toplevel 2> /dev/null || echo -n ".")'
alias cl='clear'
alias d='docker'
alias dc='docker-compose'
alias g='git'
alias kctl='kubectl'
alias killtomcat='pkill -9 -f tomcat'
alias py='python'
alias t='tmuxp load'
alias tat='tmux attach\; choose-tree -Zs'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

{% if ansible_os_family == 'Darwin' %}
# Darwin
alias ls='gls --color=auto --group-directories-first'
alias ll='gls --color=auto --group-directories-first -al'
alias pbc='pbcopy'
alias pbp='pbpaste'
{% endif %}

{% if ansible_os_family == 'Archlinux' %}
# Linux
alias ls='ls --color=auto --group-directories-first'
alias ll='ls --color=auto --group-directories-first -al'
{% endif %}

[ -f ~/.fzf/bin/fzf ] \
  && [ -f ~/.fzf.zsh ] \
  && [ -f $ZDOTDIR/fzf.zsh ] \
  && . ~/.fzf.zsh \
  && . $ZDOTDIR/fzf.zsh

# third party
[ -f $ZDOTDIR/lib/tomorrow-night.sh ] && . $ZDOTDIR/lib/tomorrow-night.sh

[ -f /usr/local/etc/profile.d/autojump.sh ] \
  && . /usr/local/etc/profile.d/autojump.sh

[ -f $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
  && . $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f $ZDOTDIR/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] \
  && . $ZDOTDIR/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
bindkey "^P" autosuggest-accept

# fnm
eval "`fnm env --multi --use-on-cd`"
