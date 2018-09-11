ZSH=$HOME/.zsh

if [ $DISPLAY ]; then
	source $ZSH/.ohmyzsh
else
	source $ZSH/.postomz
fi
