ZDOT=$HOME/.zsh
ZPLUGINS=/usr/share/zsh/plugins

if [ $DISPLAY ]; then
	source $ZDOT/.ohmyzsh
	source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
	#source $ZPLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	source $ZDOT/.ttyrc
fi

autoload -Uz compinit
compinit

#source zsh-autosuggestions.zsh
#eval "$(starship init zsh)"
