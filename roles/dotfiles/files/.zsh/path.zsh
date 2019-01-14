OLD_PATH=$PATH
unset PATH

PATH=$HOME/bin
PATH=$PATH:$HOME/local/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
# use project specific node modules
PATH=node_modules/.bin:$PATH
PATH=$PATH:$OLD_PATH

typeset -U PATH
export PATH
