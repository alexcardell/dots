DEFAULT_PATH=$PATH
unset PATH

PATH=$HOME/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin

### Custom ###
# Use project specific node modules
PATH=node_modules/.bin:$PATH
# fnm -- fast node version manager
PATH=$PATH:$HOME/.fnm

# Add defaults back
PATH=$PATH:$DEFAULT_PATH

typeset -U PATH
export PATH
