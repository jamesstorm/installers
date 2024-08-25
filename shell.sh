#!/bin/bash

# Move these to a conf file later
DOTFILES_DIR=$HOME/dotfiles
INSTALLERS_DIR=$HOME/installers
OMP_ISTALL_DIR=$HOME/.local/bin
OMP_CONFIG_DIR=$XDG_CONFIG_HOME/ohmyposh

source $INSTALLERS_DIR/functions.sh

#Requirements
# unzip

DEBUG=1

# This needs to happen first so we have our environment
# in scenarios where this is the first run on a fres
# system
link_dotfile $DOTFILES_DIR/zsh/zshenv $HOME .zshenv
source $HOME/.zshenv
echo "ZDOTDIR = $ZDOTDIR"
link_dotfile $DOTFILES_DIR/zsh/.zshrc $ZDOTDIR .zshrc
link_dotfile $DOTFILES_DIR/zsh/aliases.zsh $ZDOTDIR aliases.zsh
link_dotfile $DOTFILES_DIR/zsh/options.zsh $ZDOTDIR options.zsh

# git config
link_dotfile $DOTFILES_DIR/.gitconfig $HOME .gitconfig

# install nvim
source $INSTALLERS_DIR/neovim-local.sh
# install lazy
source $INSTALLERS_DIR/lazy.sh
# install nvim config
link_dotfile $DOTFILES_DIR/colorscheme.lua $XDG_CONFIG_HOME/nvim/lua/plugins colorscheme.lua

## OHMYPOSH INSTALL
source $INSTALLERS_DIR/ohmyposh.sh

## OMYMPOSH  CONFIG
link_dotfile $DOTFILES_DIR/omp.toml $OMP_CONFIG_DIR omp.toml

## ZSH_AUTOSUGGESTIONS
remkdir $ZDOTDIR/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions

## ZSH SYNTAX highlighting
remkdir $ZDOTDIR/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting

## TMUX PACKAGE MANAGER
remkdir $HOME/.tmux
remkdir $HOME/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

## TMUX CONFIG
link_dotfile $DOTFILES_DIR/.tmux.conf $HOME .tmux.conf

# TOKYONIGHT
rm -rf $/HOME/tokyonight.nvim
cd $HOME
git clone https://github.com/folke/tokyonight.nvim.git

# bat
# already installed above..
#
remkdir $HOME/.config/bat/themes
TN_SUB_THEME=$HOME/tokyonight.nvim/extras/sublime
BAT_THEMES=$XDG_CONFIG_HOME/bat/themes
link_dotfile $TN_SUB_THEME/tokyonight_day.tmTheme $BAT_THEMES tokyonight_day.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_moon.tmTheme $BAT_THEMES tokyonight_moon.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_night.tmTheme $BAT_THEMES tokyonight_night.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_storm.tmTheme $BAT_THEMES tokyonight_storm.tmTheme

bat cache --build
