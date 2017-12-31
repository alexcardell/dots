bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors
colors

export PS1=" %F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

function zle-line-int zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/--nml}/(main|viins)/--ins}"
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-int
zle -N zle-keymap-select

#
# History
#
export HISTSIZE=10000
export HISTFILE="$HOME/.zsh/history"
export SAVEHIST=$HISTSIZE

#
# Options
#
setopt autocd
setopt autoparamslash
setopt autopushd
setopt pushdignoredups
setopt pushdsilent
setopt histignorealldups
unsetopt beep

# History
bindkey '^R' history-incremental-search-backward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end # cursor up
bindkey "\e[B" history-beginning-search-forward-end # down

#
# Source
#
source ~/.zsh/tomorrow-night.sh
source ~/.zsh/aliases
source ~/.zsh/aliases.private
source ~/.zsh/path
source ~/.zsh/functions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
