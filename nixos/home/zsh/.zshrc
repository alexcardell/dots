if [ "${PROFILE}" ]; then
   zmodload zsh/zprof
fi

OS=$(uname)
OS=$OS:l

if [ -e ${ZDOTDIR} ]; then
  ZDOTDIR="${HOME}/.zsh"
fi

# autoload -U compinit && compinit
# autoload -U colors && colors

#---------
# History
#
# Only used as a fallback for fzf
#---------
# bindkey "^R" history-incremental-search-backward
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "\e[A" history-beginning-search-backward-end # cursor up
# bindkey "\e[B" history-beginning-search-forward-end # down

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
# zstyle ':completion:*' menu select
# zmodload zsh/complist

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

# _ZSH_PROMPT_ICON='%B%F{red}%> %f%b'
# _ZSH_PROMPTARROW='>'

function () {
  local INTMUX=$([[ "$TERM" =~ "tmux" ]] && echo tmux)
  if [ -n "$INTMUX" -a -n "$TMUX" ]; then
    LVL=$(($SHLVL - 1))
  else
    LVL=$SHLVL
  fi

  # {% if arch %}
  # Arch adds a level since we're
  # starting Xserver from the tty
  # LVL=$(($LVL - 1))
  # {% endif %}

  _ZSH_PROMPTARROW=$(printf '%%F{red}%%B>%.0s%%b%%f' {1..$LVL})
}

PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex ${_ZSH_PROMPTARROW} '
RPROMPT='%F{240}${timer_show} %F{grey}%3~ ${vcs_info_msg_0_}%f'

#---------
# Aliases
#---------
alias :q='exit'
alias cdp='cd $(git rev-parse --show-toplevel 2> /dev/null || echo -n ".")'
alias cl='clear'
alias d='docker'
alias dc='docker-compose'
alias g='git'
alias gs='git s'
alias py='python'
alias r='ranger'
alias t='tmux'
alias tm='tmux'
alias tms='tmux attach\; choose-tree -Zs'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias y='yarn'

# alias ll='ls --color=auto --group-directories-first -alh'
# alias ls='ls --color=auto --group-directories-first'
# alias open='xdg-open'

# load fzf integration 
# zsh-vi-mode causes a clash with the home-manager
# module, so load explicitly
function zvm_after_init() {
  # if [ -n "${commands[fzf-share]}" ]; then
    [ -f "$(fzf-share)/key-bindings.zsh" ] &&  source "$(fzf-share)/key-bindings.zsh"
    [ -f "$(fzf-share)/completion.zsh" ] &&  source "$(fzf-share)/completion.zsh"
    [ -f "${ZDOTDIR}/lib/fzf-git.zsh" ] && source "${ZDOTDIR}/lib/fzf-git.zsh"
  # fi
}

# Autoload custom functions
fpath=("$ZDOTDIR/autoloaded" $fpath)
autoloaded="${ZDOTDIR}/autoloaded"
if [[ -d "${autoloaded}" ]]; then
  for func in $autoloaded/*; do
    autoload -Uz ${func:t}
  done
fi
unset autoloaded


if [ "${PROFILE}" ]; then
    zprof
fi
