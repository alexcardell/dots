OS=$(uname)
OS=$OS:l

bindkey -v
bindkey -M viins "jk" vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors
colors

# Prompt
export PS1=" %F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "


#
# History
#
export HISTSIZE=10000
export HISTFILE="$HOME/.zsh/history"
export SAVEHIST=$HISTSIZE
bindkey "^R" history-incremental-search-backward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end # cursor up
bindkey "\e[B" history-beginning-search-forward-end # down

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


#
# Source
#
source $ZDOTDIR/tomorrow-night.sh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/path.zsh
source $ZDOTDIR/functions.zsh

# OS specific
if [[ -e $ZDOTDIR/aliases.$OS ]]; then
  source $ZDOTDIR/aliases.$OS
fi

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept
