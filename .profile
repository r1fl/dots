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
alias rwd='cd "$(cat /tmp/tmp.termwd)"' # restore working directory

alias pwnthon='ipython2 --profile=pwn2'
alias objdump='objdump -M intel'
alias docker='sudo docker'

alias du='du -h'
alias df='df -h'

alias pandoc='pandoc --data-dir=$HOME/.local/share/pandoc'
alias diff='diff --color=auto'
alias stopwatch="$HOME/.scripts/stopwatch.py"
alias whatami='echo 0x1ee7'

alias vim='echo "zsh: command not found: vim"'
alias xfreerdp='xfreerdp /dynamic-resolution'

#
# FUNCTIONS
#

export MDVIEWDIR="/tmp/mdview"

function mdview {
	# Render markdown files in browser

	mkdir $MDVIEWDIR 2> /dev/null
	#tmpfp=$(TMPDIR=$MDVIEWDIR mktemp)

	tmpfp="/tmp/$1.html"
	tmpfp="$1.html"
	touch $tmpfp

	pandoc --template=github.html5 $1 -o $tmpfp 2> /dev/null
	firefox $tmpfp

	#sleep 5
	#rm $tmpfp
}

function colortest256 {
	# Draw colortable

	for i in {0..255}; do
		printf "%03d: \e[38;5;${i}m" $i
		printf "\e[48;5;${i}m"

		printf "% 100s\e[0m\n" .
	done
}

function pwndock {
	# Start pwndocks

	if [[ $# != 0 ]]; then
		NAME=$1
	else
		NAME='pwn'
	fi

	docker create -it --net=host \
				--hostname pwndock-$NAME \
				--name $NAME \
				--cap-add 'SYS_PTRACE' \
				-p '22:4141' \
				-v `pwd`:/mnt\
				mypwndock

	docker start $NAME
	docker exec -it $NAME zsh
}

#
# ENVIROMENT VARS
#

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export VISUAL='nvim'

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R -N -S' 

export _JAVA_AWT_WM_NONREPARENTING=1 # java gui
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S' # time command output format
export PYTHONDONTWRITEBYTECODE=1

export PYTHONPATH=$PYTHONPATH:$HOME/Workspace/py/
export IPYTHONDIR=$XDG_CONFIG_HOME'/ipython/'
export PATH=$HOME/opt/cross/bin/:$HOME/.local/bin:$PATH

export VAGRANT_DEFAULT_PROVIDER='libvirt'

source virtualenvwrapper.sh

xset -b
