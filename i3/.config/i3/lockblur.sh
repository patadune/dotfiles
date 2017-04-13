#!/bin/sh -e

if ! pgrep "i3lock" > /dev/null
then
    scrot /tmp/screen_locked.png
    mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
    i3lock -i /tmp/screen_locked.png
fi
