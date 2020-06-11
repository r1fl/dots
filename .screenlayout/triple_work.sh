#!/bin/sh

RES="2560x1440"
set -x

STATUSFILE=$1
if [[ $STATUSFILE == '' ]]; then exit 1; fi
touch $STATUSFILE

if [[ `cat $STATUSFILE` == 'double' ]]; then
	exit 0
fi

xrandr \
	--output DP-1 --primary --mode $RES --pos 0x0 --rotate normal -r 60 \
	--output HDMI-1 --mode 1920x1080 --pos 2560x256 --rotate normal \
	--output eDP-1 --off \
	--output DP-1-2 --off \
	--output DP-1-1 --off \
	--output HDMI-2 --off \
	--output DP-1-3 --off

bspc monitor 'DP-1' -d I II III IV V
bspc monitor 'HDMI-1' -d VI VII VIII IX X

bspc monitor 'eDP-1' -r

$HOME/.config/polybar/launch.sh top
bspc config top_padding 30

$HOME/.fehbg
echo 'double' > $STATUSFILE
