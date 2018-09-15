#!/bin/bash

#
# start synergy
#

pkill synergys
synergys -f --no-tray --debug 'ERROR' --name 'DESKTOP-ALH8NSA' -c "$XDG_CONFIG_HOME/synergy.conf" --address "192.168.122.1:24800" 
