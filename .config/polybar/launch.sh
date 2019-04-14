#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $# == 0 ]]
then
	echo "usage: $0 <bar1> <bar2>..."
	exit 0
fi

if [[ $# == 1 ]]
then
	bar=$1
	for mon in `polybar -m | cut -d':' -f1`
	do
		MONITOR=$mon nohup polybar $bar &> /dev/null &
	done
else
	for bar in $@
	do
		nohup polybar $bar &> /dev/null &
	done
fi

while ! [[ $id ]]; do
	id=`xdo id -N Polybar`
done
xdo lower $id
