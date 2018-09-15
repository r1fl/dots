#!/bin/bash

#
# usage: mouse_accel.sh "SteelSeries Rival 300" "Accel Speed" -1
#

if [ $# -lt 2 ]; then
	echo "usage: mouse_accel.sh "SteelSeries Rival 300" "Accel Speed" -1"
	exit 1
else
	SEARCH=$1
#	PROPERTY=$2
	VALUE=$2
fi

ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
	xinput set-prop $i "libinput Accel Speed" $VALUE 2> /dev/null
done

exit 0

