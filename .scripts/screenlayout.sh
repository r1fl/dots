#!/bin/sh

STATUSFILE='/tmp/screenlayout.tmp'

CONNECTED=(`xrandr -q | grep -oP '^.*(?= connected)'`)
DISCONNECTED=(`xrandr -q | grep -oP '^.*(?= disconnected)'`)

if [[ ${#CONNECTED[@]} == 1 ]]; then
	echo "running single"
	$HOME/.screenlayout/single.sh $STATUSFILE
elif [[ ${#CONNECTED[@]} == 2 ]]; then
	echo "running double"
	$HOME/.screenlayout/double.sh $STATUSFILE
elif [[ ${#CONNECTED[@]} == 4 ]]; then
	echo "running quadruple"
	$HOME/.screenlayout/quadruple.sh $STATUSFILE
fi

