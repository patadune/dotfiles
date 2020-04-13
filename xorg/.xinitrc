#!/bin/sh

userxkb=$HOME/.local/share/xkb

if [ -d "$userxkb" ]; then
    setxkbmap qwerty-fr -option ctrl:nocaps -print | xkbcomp -I"$userxkb" - $DISPLAY
fi

xset -b # Remove speaker beep

redshift &

eval $(ssh-agent)

export TERMINAL=alacritty

exec i3
