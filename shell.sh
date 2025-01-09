#!/bin/bash

# check some things before proceeding

if [ ! -x /usr/bin/stow ]; then
	echo "stow not found"
	exit 1
fi

if [[ ! -x /usr/bin/zsh ]] || [[ ! -x /bin/zsh ]]; then
	echo "zsh not found"
	exit 1
fi

# Move these to a conf file later
DOTFILES_DIR=$HOME/dotfiles
INSTALLERS_DIR=$HOME/installers

source $INSTALLERS_DIR/functions.sh

DEBUG=1

sudo pacman -S unzip git stow neovim python python-pip ansible
source $INSTALLERS_DIR/yay.sh
yay -S github-cli

# This needs to happen first so we have our environment
# in scenarios where this is the first run on a fresh
# system
stow -d $DOTFILES_DIR zsh
source $HOME/.zshenv

# git config
rm $HOME/.config/nvim/lua/config/keymaps.lua
stow -d $DOTFILES_DIR git

# nvim/lazy config
stow -d $DOTFILES_DIR nvim

# install nvim

# install lazy
source $INSTALLERS_DIR/lazy.sh

# Kitty configuration
stow -d $DOTFILES_DIR kitty

## OHMYPOSH INSTALL
source $INSTALLERS_DIR/ohmyposh.sh

## OMYMPOSH  CONFIG
stow -d $DOTFILES_DIR ohmyposh

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

# TOKYONIGHT
rm -rf $/HOME/tokyonight.nvim
cd $HOME
git clone https://github.com/folke/tokyonight.nvim.git

# bat
# already installed above..
#
stow -d $DOTFILES_DIR bat

#remkdir $HOME/.config/bat/themes
TN_SUB_THEME=$HOME/tokyonight.nvim/extras/sublime
BAT_THEMES=$XDG_CONFIG_HOME/bat/themes
link_dotfile $TN_SUB_THEME/tokyonight_day.tmTheme $BAT_THEMES tokyonight_day.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_moon.tmTheme $BAT_THEMES tokyonight_moon.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_night.tmTheme $BAT_THEMES tokyonight_night.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_storm.tmTheme $BAT_THEMES tokyonight_storm.tmTheme

bat cache --build
