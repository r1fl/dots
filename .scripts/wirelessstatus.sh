#!/bin/sh

CON=$(awk 'NR == 3 {print $4}' /proc/net/wireless)
if [[ $CON ]]; then
	echo "$CON db"
else
	echo "N/A"
fi

