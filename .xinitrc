#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
userprofile=$HOME/.profile
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

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$userprofile" ]; then
    source "$userprofile"
fi

$HOME/.scripts/mouse_accel.sh "SteelSeries Rival" -1
exec bspwm
