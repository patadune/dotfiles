#!/bin/sh

userxkb=$HOME/.local/share/xkb

if [ -d "$userxkb" ]; then
    setxkbmap qwerty-fr -option ctrl:nocaps -print | xkbcomp -I"$userxkb" - $DISPLAY
fi

xset -b # Remove speaker beep

nm-applet &
blueman-applet &
redshift &

eval $(ssh-agent)

exec i3
