#!/bin/sh

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $# > 0 ]]
then
	for i in $@
	do
		nohup polybar $i &> /dev/null &
	done
fi
