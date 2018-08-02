#!/bin/sh

userresources=$HOME/.Xresources
userfonts=$HOME/.local/share/fonts
userxkb=$HOME/.local/share/xkb
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -d "$userfonts" ]; then
    xset +fp "$userfonts"
    xset fp rehash
fi

if [ -d "$userxkb" ]; then
    setxkbmap qwerty-fr -option -print | xkbcomp -I"$userxkb" - $DISPLAY
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xset -b # Remove speaker beep

eval $(ssh-agent)

exec i3
