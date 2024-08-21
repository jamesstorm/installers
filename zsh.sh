#!/bin/bash

# install all the things I like in my zsh environment
source $HOME/installers/functions.sh
DEBUG=0

OMP_INSTALL_DIR=$HOME/.local/bin
OMP_CONFIG_DIR=$XDG_CONFIG_HOME/ohmyposh

function main {
  if [ "$(id -u)" -eq 0 ]; then # root user uid is 0
    echo "Do not run as root."
    exit 1
  fi

  # Alias my dotfiles
  [ -f $HOME/.zshenv ] && rm $HOME/.zshenv
  ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
  [ -d $ZDOTDIR ] && rm -rf $ZDOTDIR #purge existing if exists
  mkdir -p $ZDOTDIR/plugins
  ln -s $HOME/dotfiles/zsh/.zshrc $ZDOTDIR/.zshrc
  ln -s $HOME/dotfiles/zsh/options.zsh $ZDOTDIR/options.zsh
  ln -s $HOME/dotfiles/zsh/aliases.zsh $ZDOTDIR/aliases.zsh

  # PLUGINS

  ## OHMYPOSH

  #### INSTALL
  debug "starting omp install"
  debug "installing to: ${OMP_INSTALL_DIR}"
  [ -d $OMP_INSTALL_DIR ] && rm -rf $OMP_INSTALL_DIR
  mkdir -p $OMP_INSTALL_DIR
  ls -al $OMP_INSTALL_DIR
  export PATH=$PATH:$OMP_INSTALL_DIR
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $OMP_INSTALL_DIR

  #### CONFIG
  [ -d $OMP_CONFIG_DIR ] && rm -rf $OMP_CONFIG_DIR
  mkdir -p $OMP_CONFIG_DIR
  ln -s $HOME/dotfiles/omp.toml $OMP_CONFIG_DIR/omp.toml

  ## ZSH_AUTOSUGGESTIONS
  [ -d $ZDOTDIR/plugins/zsh-autosuggestions ] && rm -rf $ZDOTDIR/plugins/zsh-autosuggestions
  mkdir -p $ZDOTDIR/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions

  ## ZSH SYNTAX highlighting
  [ -d $ZDOTDIR/plugins/zsh-syntax-highlighting ] && rm -rf $ZDOTDIR/plugins/zsh-syntax-highlighting
  mkdir -p $ZDOTDIR/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting

  ## TMUX PACKAGE MANAGER
  debug "===== tmux package manager"

  [ -d $HOME/.tmux ] && rm -rf $HOME/.tmux
  mkdir -p $HOME/.tmux/plugins/tpm
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

  ## TMUX CONFIG
  [ -f $HOME/.tmux.conf ] && rm -rf $HOME/.tmux.conf
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

}

main
