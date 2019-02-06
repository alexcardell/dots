#--------
# Prompt
#--------
# see man zshexpn/zshmisc for explanations
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{red}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats \
  '%c%u%F{white}[%F{cyan}%b%F{grey}|%F{red}%a%F{grey}]%f'
zstyle ':vcs_info:*' formats \
  '%c%u%F{grey}[%F{cyan}%b%F{grey}]%m%f'
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
}

precmd () { vcs_info }
PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex %B%F{red}> %f%b'
RPROMPT='%F{grey}%3~ ${vcs_info_msg_0_}%f'
