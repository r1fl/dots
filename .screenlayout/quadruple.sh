#!/bin/sh

set -x

STATUSFILE=$1
if [[ $STATUSFILE == '' ]]; then exit 1; fi
touch $STATUSFILE

if [[ `cat $STATUSFILE` == 'quadruple' ]]; then # check if layout is already set
	exit 0
fi

while ! (xrandr | grep -oP 'DP-1-3.*primary'); do
	xrandr  --output DP-2-1 --off \
			--output DP-1-3 --primary --mode 1920x1080 --pos 1080x736 --rotate normal \
			--output DP-2-2 --mode 1920x1080 --pos 0x0 --rotate left \
			--output DP-1-2 --mode 1920x1080 --pos 3000x736 --rotate normal \
			--output DP-2-3 --off \
			--output eDP-1 --off \
			--output DP-1-1 --off \
			--output HDMI-2 --off \
			--output HDMI-1 --off \
			--output DP-2 --off \
			--output DP-1 --off
done

if ! pgrep bspwm; then exit 0; fi # no bspwm instance is running yet

bspc monitor 'DP-2-2' -g '1080x1920+0+0'
bspc monitor 'DP-1-3' -g '1920x1080+1080+736'
bspc monitor 'DP-1-2' -g '1920x1080+3000+736'

# Create new desktops and import all nodes from old ones
PREFIX='n'

bspc monitor 'DP-2-2' -a ${PREFIX}I ${PREFIX}III ${PREFIX}IV # left
bspc monitor 'DP-1-3' -a ${PREFIX}II ${PREFIX}V ${PREFIX}VI ${PREFIX}VII ${PREFIX}VIII # middle
bspc monitor 'DP-1-2' -a ${PREFIX}IX ${PREFIX}X # right

for d in `bspc query -D --names`; do
	if [[ $d  == $PREFIX* ]]; then continue; fi # do not replicate new desktops

	bspc node "@$d:/" -d "${PREFIX}${d}" # move to new monitor
	bspc desktop $d -r # remove old desktop
	bspc desktop ${PREFIX}${d} -n $d # rename
done

# cleanup in case no desktops existed on run
for d in `bspc query -D --names`; do
	if [[ $d  != $PREFIX* ]]; then continue; fi # only rename new desktops
	original_name=`echo $d | grep -oP "(?<=^$PREFIX).*"`
	bspc desktop $d -n $original_name # rename
done

# Remove non-active monitors
for m in `bspc query -M --names`; do
	if [[ $m == 'DP-1-3' ]]; then continue; fi
	if [[ $m == 'DP-2-2' ]]; then continue; fi
	if [[ $m == 'DP-1-2' ]]; then continue; fi

	bspc monitor $m -r
done

$HOME/.config/polybar/launch.sh top
bspc config top_padding 30

$HOME/.fehbg

# Sign the statusfile
echo 'quadruple' > $STATUSFILE

