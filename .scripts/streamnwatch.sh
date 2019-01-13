#!/bin/sh
#
# stream audio over http
#
# me:em@localhost:80/stream.sh
#

if [ $# -eq 0 ]; then
	echo 'insufficient args'
	exit 1
fi

if ! [ $STREAM_NET ]; then
	STREAM_NET="HOTFiber-KN42"
fi

#if [ nmcli d wifi list | grep 'HOTFiber-KN42' ]; then
	# nmcli d wifi connect "HOTFiber-KN42"
#	true
#fi

nohup vlc "$1" &> /dev/null &
sleep 2;

dev=$(pactl list | grep "Monitor Source" | grep HyperX | awk '{ print $3 }')
cvlc -v pulse://$dev --sout '#transcode{acodec=mp3,ab=128,channels=2}:standard{access=http,dst=0.0.0.0:8888/stream.mp3}' 2> /dev/null


