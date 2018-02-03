# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
# java
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
# maven
# export M2_HOME=/usr/local/Cellar/maven/3.5.2/libexec
# export M2=$M2_HOME/bin
# export PATH=$M2:$PATH
# mysql
MYSQL_HOME=/usr/local/mysql
MYSQL=$MYSQL_HOME/bin
PATH=$MYSQL:$PATH
{% endif %}
{% if ansible_os_family == 'Archlinux' %}
EDITOR=vim
{% endif %}

ZDOTDIR=$HOME/.zsh
