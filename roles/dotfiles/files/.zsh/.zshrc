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

#-------
# Other
#-------
# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept
# Syntax highlighting
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#--------
# Prompt
#--------
# see man zshexpn/zshmisc for explanations
PROMPT='%(?. .%F{yellow}%B!%b)%F{blue}%n %B%F{red}> %f%b'
RPROMPT='%F{yellow}%1~ %F{magenta}$(prompt#git)%f'
