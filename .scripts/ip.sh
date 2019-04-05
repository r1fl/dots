#!/bin/sh

DEV=`nmcli connection | sed '2q;d' | grep -oP '\s+\w+\s*$'`
ip addr show dev $DEV | grep -oP '(?<=inet )[\d\.]+'

