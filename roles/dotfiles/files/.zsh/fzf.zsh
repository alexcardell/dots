export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Moving
#--------
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }

# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Opening files
#---------------
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# Git
#-----

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
    fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
    cut -c4- | sed 's/.* -> //'
  }

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
  }

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
    fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
  }

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
    fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
    grep -o "[a-f0-9]\{7,\}"
  }

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
    cut -d$'\t' -f1
  }

join-lines() {
local item
while read item; do
  echo -n "${(q)item} "
done
}

bind-git-helper() {
local char
for c in $@; do
  eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
  eval "zle -N fzf-g$c-widget"
  eval "bindkey '^g^$c' fzf-g$c-widget"
done
}
bind-git-helper f b t r h
unset -f bind-git-helper

# Processes
#-----------
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Homebrew
#----------
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m --query="$1" --preview 'brew info {}')

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
    fi
  }

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf -m --query="$1" --preview 'brew info {}')

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
    fi
  }

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m --query="$1" --preview 'brew info {}')

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
    fi
  }

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
bcup() {
    local token
    token=$(brew cask list | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepage of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew cask uninstall $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew cask home $token
        fi
    fi
}
