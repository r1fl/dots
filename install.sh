#!/bin/bash

TEMPD=$(mktemp -d)
echo "[*] saving install files to $TEMPD"

echo "[*] installing pikaur"
pushd $(pwd) > /dev/null
sudo pacman -S --needed base-devel git
cd $TEMPD
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri
popd

echo "[*] installing dependencies"
pikaur -S `cat dependencies`
usermod -s $(which zsh) $USER

echo "[*] exporting dots to $HOME"
pushd $(pwd) > /dev/null
cd $TEMPD
git clone https://github.com/r1fl/dots.git
cd dots
cp ./.* $HOME -r
mv $HOME/.git $HOME/.dots.git
rm $HOME/README.md
popd
git --git-dir=$HOME/.dots.git/ --work-tree=$HOME --local config status showUntrackedFiles no

echo "[*] setting up vim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "[?] dont forget to build youcompleteme"
