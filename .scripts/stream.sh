#!/bin/sh
#
# stream audio over http
#

dev=$(pactl list | grep "Monitor Source" | grep HyperX | awk '{ print $3 }')
cvlc -v pulse://$dev --sout '#transcode{acodec=mp3,ab=128,channels=2}:standard{access=http,dst=0.0.0.0:8888/stream.mp3}'


