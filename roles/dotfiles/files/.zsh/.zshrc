OS=$(uname)
OS=$OS:l

bindkey -v
bindkey -M viins "jk" vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors
colors

#--------
# Prompt
#--------
# see man zshexpn/zshmisc for explanations
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}]%F{2}%c%F{red}%u %m%f'

zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
  local ahead behind
  local -a gitstatus
  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
  (( $ahead )) && gitstatus+=( "+${ahead}" )
  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
  (( $behind )) && gitstatus+=( "-${behind}" )
  hook_com[misc]+="%F{blue}${(j:/:)gitstatus}%f"
}

precmd () { vcs_info }
PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}alex %B%F{red}> %f%b'
RPROMPT='%F{3}%3~ ${vcs_info_msg_0_}%f'

#---------
# History
#---------
export HISTSIZE=10000
export HISTFILE="$ZDOTDIR/history"
export SAVEHIST=$HISTSIZE
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
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#---------
# Sources
#---------
source $ZDOTDIR/tomorrow-night.sh
source $ZDOTDIR/path.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/fzf.zsh
# shared aliases
source $ZDOTDIR/aliases.zsh
# private
if [[ -e $ZOTDIR/aliases.private.zsh ]]; then
  source $ZDOTDIR/aliases.private.zsh
fi
# OS specific
if [[ -e $ZDOTDIR/aliases.$OS.zsh ]]; then
  source $ZDOTDIR/aliases.$OS.zsh
fi
if [[ -e $ZDOTDIR/settings.$OS.zsh ]]; then
  source $ZDOTDIR/settings.$OS.zsh
fi
if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

#-------
# Other
#-------
# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept
# Syntax highlighting
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
