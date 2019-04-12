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
  '%c%u[%F{cyan}%b%f%|%a]'
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

# precmd () { vcs_info }
PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex %B%F{red}> %f%b'
RPROMPT='%F{240}${timer_show} %F{grey}%3~ ${vcs_info_msg_0_}%f'
