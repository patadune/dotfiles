#!/bin/sh

userbin=$HOME/.local/bin

if [ -d "$userbin" ]; then
    $userbin/keymap
fi

xset -b # Remove speaker beep


eval $(ssh-agent)

export TERMINAL=alacritty

exec i3
