#!/bin/bash
source $HOME/installers/functions.sh
yay -S --noconfirm kitty

[ -d $XDG_CONFIG_HOME/kitty ] && rm -rf $XDG_CONFIG_HOME/kitty
ln -s $HOME/dotfiles/kitty $XDG_CONFIG_HOME
