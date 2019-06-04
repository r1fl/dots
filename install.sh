#!/bin/bash
# Quick n ez configuration installer for new setups.

# Color Constants

CLR_RESET="\e[39m\e[49m"

CLR_RED="\e[31m"
CLR_GREEN="\e[32m"
CLR_WHITE="\e[1;37m"

CLR_PURPLE="\e[1;45m"

# Usefull functions

announce() {
	echo -e $2
	echo $1
	echo -e $CLR_RESET
	echo -e $CLR_WHITE # ?!? TODO: save n restore color instead

	sleep 1
}

load_animation() {
	MSG=$1
	T=$2

	while true; do
		echo -en "$CLR_GREEN[\\]$CLR_WHITE $MSG\r"
		sleep $T
		echo -en "$CLR_GREEN[|]$CLR_WHITE $MSG\r"
		sleep $T
		echo -en "$CLR_GREEN[/]$CLR_WHITE $MSG\r"
		sleep $T
		echo -en "$CLR_GREEN[-]$CLR_WHITE $MSG\r"
		sleep $T
	done
}

clear_line() {
	printf "\r%*s" $COLUMNS " "
}

install_pkg() {
	# Casually cache password
	while [[ `sudo whoami` != "root" ]]; do true; done

	# Install packages
	for pkg in $@; do
		load_animation "Installing $pkg" 0.5 &

		sudo pikaur -S --needed --noconfirm $pkg &>/dev/null
		ret=$?

		kill %1 # kill animation

		if [[ $ret != 0 ]]; then
			clear_line
			echo "[!] Installation of $pkg exited with a non-zero return code."

			while true; do
				echo "Continue/Retry/Exit? [C/r/e]"
				read input
				if [[ $input == "" || $input == "c" ]]; then break; fi # Continue
				if [[ $input == "r" ]]; then install_pkg $pkg; fi # Retry
				if [[ $input == "e" ]]; then exit $ret; fi # Retry
			done
		else
			clear_line
			echo "[*] $pkg done."
			echo
		fi
	done
}


# First stage (Preparation)
# ?!?

clear
echo -en "$CLR_WHITE" # Clean up term

announce "[0/2] Preparing environment" $CLR_PURPLE 40
install_pkg pacman-contrib

pushd `pwd`
cd /etc/pacman.d/
load_animation "[*] Sorting mirrors" 0.5 &

sudo curl -s -o ./mirrorlist "https://www.archlinux.org/mirrorlist/?protocol=https&use_mirror_status=on"
sudo cp ./mirrorlist ./mirrorlist.backup
sudo sed -i 's/^#Server/Server/' ./mirrorlist.backup
sudo sh -c "rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist"

kill %1
popd >/dev/null

# Second stage (Dependencies)

announce "[1/2] Installing Dependencies" $CLR_PURPLE 40

sudo pacman -S --needed --noconfirm base-devel git

# Cd to tmp dir
dots=`pwd`
mkdir ./install
cd ./install

git clone https://aur.archlinux.org/pikaur.git --depth 1
cd pikaur
makepkg -fsri --needed --noconfirm

pikaur -S --needed --noconfirm `cat $dots/dependencies`
cd ../..
rm -rf ./install

# Third stage (Misc n Configuration)

announce "[2/2]  Loading Config" $CLR_PURPLE 40
cp ./.* ~/ -r # copy all dot files recursively
mv ~/.git ~/.dots

# Install vimplug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Change default shell
# ?!?

echo -en $CLR_RESET

