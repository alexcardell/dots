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
export PS1="%(?. .%F{yellow}%B!%b%f)%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%F{red}%B%(!.#.$)%b%f "

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
# shared aliases
source $ZDOTDIR/aliases.zsh
# private
if [[ -e $ZOTDIR/aliases.private ]]; then
  source $ZDOTDIR/aliases.private
fi
# OS specific
if [[ -e $ZDOTDIR/aliases.$OS ]]; then
  source $ZDOTDIR/aliases.$OS
fi

#-------
# Other
#-------
# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept
# Syntax highlighting
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
