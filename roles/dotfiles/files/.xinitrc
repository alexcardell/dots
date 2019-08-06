[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset -b
unclutter & \
  exec i3
