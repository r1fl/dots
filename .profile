#!/bin/sh

# XINIT

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

setxkbmap -layout us,il -option grp:win_space_toggle

#
# ALIASES
#

alias l='ls -al --color=auto'
alias ls='ls --color=auto'
alias lock='i3lock -i $HOME/.local/share/fehbg/starwars_kylo.png'

alias unprivdo='sudo -u nobody'
alias dots='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'

#
# ENVIROMENT VARS
#

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=vim

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R -N -S' 

export _JAVA_AWT_WM_NONREPARENTING=1 # java gui
export DOTNET_CLI_TELEMETRY_OPTOUT=1 # dotnet telemetry

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S' # time command output format

export PYTHONPATH=$PYTHONPATH:$HOME/Workspace/py/
