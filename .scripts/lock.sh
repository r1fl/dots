#!/bin/bash

notify-send -u critical 'Computer is locking now.'
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop

#physlock

IMAGE=/tmp/i3lock.png
SCREENSHOT="scrot $IMAGE" # 0.46s
# SCREENSHOT="import -window root $IMAGE" # 1.35s

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
#BLURTYPE="5x2" # 3.80s
#BLURTYPE="2x8" # 2.90s
#BLURTYPE="2x3" # 2.92s

$SCREENSHOT
convert $IMAGE -blur $BLURTYPE $IMAGE
i3lock -nfi $IMAGE
rm $IMAGE

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
