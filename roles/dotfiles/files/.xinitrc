[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset -b
exec i3
