bindkey -v
bindkey -M viins "jk" vi-cmd-mode

autoload -U compinit && compinit

autoload -U colors
colors

# Prompt
export PS1=" %F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "

# Decide cursor shape escape sequence
BLOCK="\E]50;CursorShape=0\C-G"
LINE="\E]50;CursorShape=1\C-G"
if [[ -n $TMUX ]]; then
  BLOCK="\EPtmux;\E\E]50;CursorShape=0\x7\E\\"
  LINE="\EPtmux;\E\E]50;CursorShape=1\x7\E\\"
fi

# Use a line cursor for insert mode, block for normal
function zle-keymap-select zle-line-init {
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
source ~/.zsh/tomorrow-night.sh
source ~/.zsh/aliases
source ~/.zsh/aliases.private
source ~/.zsh/path
source ~/.zsh/functions

# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey "^P" autosuggest-accept
