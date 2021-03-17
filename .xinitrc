#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 37 = Escape"

bspwm &
redshift &
exec alacritty
