#!/bin/sh
# Executed by startx (run your window manager from here)

setxkbmap us altgr-intl
xmodmap .Xmodmap &
xsetroot -cursor_name left_ptr &
feh --bg-tile ~/stuff/lizards.jpg &
unclutter -idle 1 &
xset -b

exec xmonad
