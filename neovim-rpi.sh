#!/bin/bash

NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"

FILE_NAME="nvim-linux-arm64"

curl -LO $NVIM_URL 
sudo rm -rf /usr/bin/nvim
sudo rm -rf /opt/nvim-linux64
sudo tar -C /opt -xzf $FILE_NAME.tar.gz
sudo rm $FILE_NAME.tar.gz
echo "PATH=/opt/$FILE_NAME/bin:$PATH" >>~/.zshrc
echo "PATH=/opt/$FILE_NAME/bin:$PATH" >>~/.profile
source ~/.profile
