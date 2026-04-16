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

# Move these to a conf file later
DOTFILES_DIR=$HOME/dotfiles
INSTALLERS_DIR=$HOME/installers

source $INSTALLERS_DIR/functions.sh

DEBUG=1
install_app zsh

get_home_dir() {
  if [ "$REAL_USER" = "root" ]; then
    HOME_DIR="/root"
  else
    HOME_DIR=$(getent passwd "$REAL_USER" | cut -d: -f6)
  fi
}

get_real_user() {
  if [ "$(id -u)" -eq 0 ]; then
    if [ -n "$SUDO_USER" ]; then
      REAL_USER="$SUDO_USER"
    else
      REAL_USER="root"
    fi
  else
    REAL_USER="$(whoami)"
  fi
  get_home_dir
}

get_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
    ubuntu) OS_NAME="ubuntu" ;;
    debian) OS_NAME="debian" ;;
    arch) OS_NAME="arch" ;;
    manjaro) OS_NAME="manjaro" ;;
    fedora) OS_NAME="fedora" ;;
    centos) OS_NAME="centos" ;;
    rocky) OS_NAME="rocky" ;;
    alma) OS_NAME="alma" ;;
    opensuse* | suse) OS_NAME="opensuse" ;;
    raspbian) OS_NAME="raspbian" ;;
    *) OS_NAME="$ID" ;;
    esac
  elif [ "$(uname)" = "Darwin" ]; then
    OS_NAME="macos"
  else
    OS_NAME="unknown"
  fi
}

remkdir() {
  if [ -d $1 ]; then
    rm -rf $1
  fi
  mkdir -p $1
}

link_dotfile() {
  echo "link_dotfile $1 $2 $3"
  SOURCE=$1
  DEST_PATH=$2
  DEST_FILENAME=$3
  DEST_FULL=$DEST_PATH/$DEST_FILENAME
  if [[ -f $DEST_FULL ]]; then
    #  echo "deleting $DEST_FULL"
    rm $DEST_FULL
  fi
  mkdir -p $DEST_PATH
  ln -s $SOURCE $DEST_PATH/$DEST_FILENAME

}

install_app() {

  if $(is_installed $1); then
    echo "install_app: $1 is already installed"
  else
    echo "install_app: installing $1"
    if [ -x /usr/bin/pacman ]; then
      sudo pacman -S $1 --noconfirm
    elif [[ -x /usr/bin/apt ]]; then
      sudo apt install $1 -y
    fi
  fi

}

is_installed() {
  if [ -x /usr/bin/$1 ]; then
    return 0 # true
  else
    return 1 # false
  fi
}

function debug {
  [ $DEBUG -eq -0 ] && printf "======\n%s\n======\n" "$1"
}
install_app unzip
install_app git
install_app python
install_app python-pip
install_app ansible
install_app tmux
install_app fzf
install_app less
source $INSTALLERS_DIR/neovim.sh
source $INSTALLERS_DIR/yay.sh
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
