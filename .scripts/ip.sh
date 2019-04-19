#!/bin/sh

DEV=`nmcli connection | sed '2q;d' | grep -oP '\s+\w+\s*$'`
(echo $DEV | grep -cP '[a-zA-Z]') &> /dev/null
if [[ $? == 0 ]]; then
	ip addr show dev $DEV | grep -oP '(?<=inet )[\d\.]+'
else
	echo "N/A"
fi
