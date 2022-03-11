#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f "${HOME}/.local/bin/keymap" ]; then
    ${HOME}/.local/bin/keymap
fi

if command -v feh >/dev/null 2>&1 && [ -f "${HOME}/.fehbg" ]; then
    ${HOME}/.fehbg
fi

xset -b # Remove speaker beep

export LANG=en_US.UTF-8

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

export TERMINAL=alacritty

exec i3
