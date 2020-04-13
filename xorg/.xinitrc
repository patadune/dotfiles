#!/bin/sh

userbin=$HOME/.local/bin

if [ -d "$userbin" ]; then
    $userbin/keymap
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xset -b # Remove speaker beep

export LANG=en_US.UTF-8

eval $(ssh-agent)

export TERMINAL=alacritty

exec i3
