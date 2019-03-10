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
export HISTFILE="$ZDOTDIR/.zhistory"
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

#----------
# Sourcing
#----------
# mine
[ -f $ZDOTDIR/prompt.zsh ]          && . $ZDOTDIR/prompt.zsh
[ -f $ZDOTDIR/path.zsh ]            && . $ZDOTDIR/path.zsh
[ -f $ZDOTDIR/functions.zsh ]       && . $ZDOTDIR/functions.zsh
[ -f $ZDOTDIR/aliases.zsh ]         && . $ZDOTDIR/aliases.zsh
[ -f $ZDOTDIR/aliases.private.zsh ] && . $ZDOTDIR/aliases.private.zsh
[ -f $ZDOTDIR/aliases.$OS.zsh ]     && . $ZDOTDIR/aliases.$OS.zsh
[ -f $ZDOTDIR/settings.$OS.zsh ]    && . $ZDOTDIR/settings.$OS.zsh
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

# Start up in tmux
if [[ -z "$TMUX" ]]; then t alex; fi
