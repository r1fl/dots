#!/bin/sh

set -x

STATUSFILE=$1
if [[ $STATUSFILE == '' ]]; then exit 1; fi
touch $STATUSFILE

if [[ `cat $STATUSFILE` == 'single' ]]; then
	exit 0
fi

xrandr	--output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
		--output DP-2-1 --off \
		--output DP-2-2 --off \
		--output DP-2-3 --off \
		--output DP-1-2 --off \
		--output HDMI-2 --off \
		--output HDMI-1 --off \
		--output DP-1 --off \
		--output DP-1-3 --off \
		--output DP-2 --off \
		--output DP-1-1 --off

if ! pgrep bspwm; then exit 0; fi

bspc monitor 'eDP-1' -g '1920x1080+0+0'

# Create new desktops and import all nodes from old ones
PREFIX='n'

for d in `bspc query -D --names`; do
	bspc monitor 'eDP-1' -a ${PREFIX}${d}

	bspc node "@$d:/" -d "${PREFIX}${d}" # move to new monitor
	bspc desktop $d -r # remove old desktop
	bspc desktop ${PREFIX}${d} -n $d # rename
done

# Set order and get rid of temporary desktops
bspc monitor 'eDP-1' -o I II III IV V VI VII VIII IX X
bspc monitor 'eDP-1' -d I II III IV V VI VII VIII IX X

# Remove non-active monitors
for m in `bspc query -M --names`; do
	if [[ $m == 'eDP-1' ]]; then continue; fi
	bspc monitor $m -r
done

$HOME/.config/polybar/launch.sh top
bspc config top_padding 30

$HOME/.fehbg

# Sign the statusfile
echo 'single' > $STATUSFILE

