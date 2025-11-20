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

DEBUG=0

echo "XDG_CONFIG_HOME = ${XDG_CONFIG_HOME}" 


#exit 1

install_app zsh
install_app unzip
install_app python3
install_app python3-pip
install_app ansible
install_app tmux

debug 'sourcing neovim-rpi.sh'
source $INSTALLERS_DIR/neovim-rpi.sh
debug "sourcing gh.sh"
source $INSTALLERS_DIR/gh.sh

# This needs to happen first so we have our environment
# in scenarios where this is the first run on a fresh
# system
debug "stow: zsh"
stow -d $DOTFILES_DIR zsh
debug "sourcing .zshenv"
source $HOME/.zshenv

# bat
debug "installing bat"
install_app bat
debug "batcat cache"
batcat cache --build
debug "adding bat alias"
echo "alias bat=batcat" >> $DOTFILES_DIR/zsh/.config/zsh/aliases.zsh


# git config
debug "git config"
stow -d $DOTFILES_DIR git

# nvim/lazy config
#stow -d $DOTFILES_DIR nvim

# install lazy
#source $INSTALLERS_DIR/lazy.sh

## OMYMPOSH  CONFIG
debug "stow: ohmyposh"
stow -d $DOTFILES_DIR ohmyposh

## OHMYPOSH INSTALL
debug "sourcing ohmyposh.sh"
source $INSTALLERS_DIR/ohmyposh.sh

## ZSH_AUTOSUGGESTIONS
debug "ZSH autosuggestions"
VAR=$XDG_CONFIG_HOME/.zsh-plugins/zsh-autosuggestions
remkdir $VAR
git clone https://github.com/zsh-users/zsh-autosuggestions $VAR


## ZSH SYNTAX highlighting
debug "ZSH syntax highlighting"
VAR=$XDG_CONFIG_HOME/.zsh-plugins/zsh-syntax-highlighting
remkdir $VAR
git clone https://github.com/zsh-users/zsh-syntax-highlighting $VAR

## TMUX PACKAGE MANAGER
debug "tmux"
remkdir $HOME/.tmux
remkdir $HOME/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

## TMUX CONFIG

#link_dotfile $DOTFILES_DIR/.tmux.conf $HOME .tmux.conf
stow -d $DOTFILES_DIR tmux

