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
alias black='sleep 1; xset dpms force off'

alias unprivdo='sudo -u nobody'
alias dots='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'

alias swd='pwd > /tmp/tmp.termwd' # save working directory
alias rwd='cd $(cat /tmp/tmp.termwd)' # restore working directory

alias pwnthon='ipython2 --profile=pwn2'
alias objdump='objdump -M intel'
alias docker='sudo docker'

alias du='du -h'
alias df='df -h'

alias pandoc='pandoc --data-dir=$HOME/.local/share/pandoc'
alias diff='diff --color=auto'
alias stopwatch="$HOME/.scripts/stopwatch.py"
alias whatami='echo 0xB055'

alias octopus='rdesktop -d AD -u itamarne octopus'

#
# FUNCTIONS
#

export MDVIEWDIR="/tmp/mdview"

function mdview {
	mkdir $MDVIEWDIR 2> /dev/null
	tmpfp=$(TMPDIR=$MDVIEWDIR mktemp)

	pandoc --template=github.html5 $1 -o $tmpfp 2> /dev/null
	firefox $tmpfp
}

COLORS=('black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white')

function colortest {
	for i in `seq ${#COLORS}`; do
		let color=30+$i
		printf "\e[${color}m${COLORS[$i]}"
		printf "\e[1;37m\e[s | \e[0m"
	done

	printf "\e[u  \n"
}

#function sleep {
#	for i in `seq $1 -1 0`; do; echo -n "$i        \r"; /usr/bin/sleep 1; done 
#}

#
# ENVIROMENT VARS
#

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=nvim

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R -N -S' 

export _JAVA_AWT_WM_NONREPARENTING=1 # java gui
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S' # time command output format

export PYTHONPATH=$PYTHONPATH:$HOME/Workspace/py/
export IPYTHONDIR=$XDG_CONFIG_HOME'/ipython/'
export PATH=$HOME/opt/cross/bin/:$PATH

export VAGRANT_DEFAULT_PROVIDER='libvirt'

xset -b

