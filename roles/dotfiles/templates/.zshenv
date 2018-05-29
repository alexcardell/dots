# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
# java
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home

# mysql
MYSQL_HOME=/usr/local/mysql
MYSQL=$MYSQL_HOME/bin
PATH=$MYSQL:$PATH
{% endif %}

{% if ansible_os_family == 'Archlinux' %}
VISUAL=vim
EDITOR="${VISUAL}"
{% endif %}

# use project specific node modules
PATH=node_modules/.bin:$PATH

NVM_DIR="$HOME/.nvm"

ZDOTDIR=$HOME/.zsh
