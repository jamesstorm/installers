#!/bin/bash

# check some things before proceeding

if [ ! -x /usr/bin/stow ]; then
  echo "stow not found"
  exit 1
fi

#if [[ ! -x /usr/bin/zsh ]] || [[ ! -x /bin/zsh ]]; then
#  echo "zsh not found"
#  exit 1
#fi

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Move these to a conf file later
DOTFILES_DIR=$HOME/dotfiles
INSTALLERS_DIR=$HOME/installers

source $INSTALLERS_DIR/functions.sh

DEBUG=1
install_app zsh
install_app unzip
install_app python3
install_app python3-pip
install_app ansible
install_app tmux
install_app bat
source $INSTALLERS_DIR/neovim-rpi.sh
source $INSTALLERS_DIR/gh.sh

# This needs to happen first so we have our environment
# in scenarios where this is the first run on a fresh
# system
stow -d $DOTFILES_DIR zsh
source $HOME/.zshenv

# git config
rm $HOME/.config/nvim/lua/config/keymaps.lua
stow -d $DOTFILES_DIR git

# nvim/lazy config
#stow -d $DOTFILES_DIR nvim

# install lazy
#source $INSTALLERS_DIR/lazy.sh

## OMYMPOSH  CONFIG
stow -d $DOTFILES_DIR ohmyposh

## OHMYPOSH INSTALL
source $INSTALLERS_DIR/ohmyposh.sh

## ZSH_AUTOSUGGESTIONS
VAR=$XDG_CONFIG_HOME/.zsh-plugins/zsh-autosuggestions
remkdir $VAR
git clone https://github.com/zsh-users/zsh-autosuggestions $VAR

## ZSH SYNTAX highlighting
VAR=$XDG_CONFIG_HOME/.zsh-plugins/zsh-syntax-highlighting
remkdir $VAR
git clone https://github.com/zsh-users/zsh-syntax-highlighting $VAR

## TMUX PACKAGE MANAGER
remkdir $HOME/.tmux
remkdir $HOME/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

## TMUX CONFIG

#link_dotfile $DOTFILES_DIR/.tmux.conf $HOME .tmux.conf
stow -d $DOTFILES_DIR tmux

BAT_CMD=bat
if [ ! -x /usr/bin/bat ]; then
  echo "bat not found"
  BAT_CMD=batcat
fi
$(BAT_CMD) cache --build
echo "alias bat=batcat" >>$DOTFILES/zsh/.config/zsh/aliases.zsh
