# {{ ansible_managed }}

if [ "${PROFILE}" ]; then
   zmodload zsh/zprof
fi

OS=$(uname)
OS=$OS:l

bindkey -v
bindkey -M viins "jk" vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors && colors

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xx' edit-command-line
bindkey '^x^x' edit-command-line
bindkey -M vicmd '^xx' edit-command-line
bindkey -M vicmd '^x^x' edit-command-line

#---------
# History
#
# Only used as a fallback for fzf
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

  {% if arch %}
  # Arch adds a level since we're
  # starting Xserver from the tty
  LVL=$(($LVL - 1))
  {% endif %}

  _ZSH_PROMPTARROW=$(printf '%%F{red}%%B>%.0s%%b%%f' {1..$LVL})
}

PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex ${_ZSH_PROMPTARROW} '
RPROMPT='%F{240}${timer_show} %F{grey}%3~ ${vcs_info_msg_0_}%f'

#-----------
# Functions
#-----------
function set-cursor-sequence {
  # Cursor shape escape sequence
  {% if darwin %}
    # Darwin
    BLOCK="\E]50;CursorShape=0\C-G"
    LINE="\E]50;CursorShape=1\C-G"
    TMUXBLOCK="\EPtmux;\E\E]50;CursorShape=0\x7\E\\"
    TMUXLINE="\EPtmux;\E\E]50;CursorShape=1\x7\E\\"
  {% endif %}
  {% if arch %}
    # Linux
    BLOCK="\033[2 q"
    LINE="\033[6 q"
    TMUXBLOCK="\033Ptmux;\033\033[2 q\x7\033\\"
    TMUXLINE="\033Ptmux;\033\033[6 q\x7\033\\"
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

# Enable text objects for ",',`,(),{},<>, etc
autoload -U select-quoted
zle -N select-quoted

autoload -U select-bracketed
zle -N select-bracketed

for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>'}; do
    bindkey -M $m $c select-bracketed
  done
done

#---------
# Aliases
#---------
alias :q='exit'
alias cdp='cd $(git rev-parse --show-toplevel 2> /dev/null || echo -n ".")'
alias cl='clear'
alias d='docker'
alias db='dropbox-cli'
alias dc='docker-compose'
alias g='git'
alias h='helm'
alias k='kubectl'
alias kctl='kubectl'
alias py='python'
alias r='ranger'
alias t='tmuxp load'
alias tat='echo "Use new alias \`tms\`"'
alias tms='tmux attach\; choose-tree -Zs'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias y='yarn'

{% if darwin %}
# Darwin
alias ls='gls --color=auto --group-directories-first'
alias ll='gls --color=auto --group-directories-first -alh'
alias pbc='pbcopy'
alias pbp='pbpaste'

# source private work aliases
[ -f $ZDOTDIR/.private.aliases.zsh ] && . $ZDOTDIR/.private.aliases.zsh
{% endif %}

{% if arch %}
# Linux
alias ll='ls --color=auto --group-directories-first -alh'
alias ls='ls --color=auto --group-directories-first'
alias open='xdg-open'

alias vpnon='systemctl start openvpn-client@work.service'
alias vpnoff='systemctl stop openvpn-client@work.service'
alias vpns='systemctl status openvpn-client@work.service'
{% endif %}

[ -f ~/.fzf/bin/fzf ] \
  && [ -f ~/.fzf.zsh ] \
  && [ -f $ZDOTDIR/fzf.zsh ] \
  && . ~/.fzf.zsh \
  && . $ZDOTDIR/fzf.zsh

{% if arch %}
[ -f /usr/share/autojump/autojump.zsh ] \
  && . /usr/share/autojump/autojump.zsh
{% endif %}
{% if darwin %}
[ -f /usr/local/etc/profile.d/autojump.sh ] \
  && . /usr/local/etc/profile.d/autojump.sh
{% endif %}

[ -f $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
  && . $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept

[ -f $ZDOTDIR/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] \
  && . $ZDOTDIR/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

[ -s $HOME/.jabba/jabba.sh ] && . $HOME/.jabba/jabba.sh

# fnm
eval "$(fnm env --use-on-cd)"

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
