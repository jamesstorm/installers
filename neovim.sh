#!/bin/bash

INSTALL_DIR="/usr/local/bin"

if [ -x /usr/bin/pacman ]; then
  sudo pacman -S $1
elif [[ -x /usr/bin/apt ]]; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo tar -C $INSTALL_DIR -xzf nvim-linux-x86_64.tar.gz
  rm -rf nvim-linux-x86_64.tar.gz
fi
