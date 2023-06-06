[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset -b
xset s 24000
xset -dpms
unclutter & \
picom & \
  exec i3
