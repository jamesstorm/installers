#!/bin/bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /usr/bin/nvim
sudo rm -rf /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo rm nvim-linux64.tar.gz
echo "PATH=/opt/nvim-linux64/bin:$PATH" >>~/.zshrc
echo "PATH=/opt/nvim-linux64/bin:$PATH" >>~/.profile
source ~/.profile
