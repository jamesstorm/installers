#!/bin/bash
echo "Downloading nvim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

sudo rm /usr/bin/nvim
sudo cp nvim.appimage /usr/bin/nvim
sudo chmod +x /usr/bin/nvim
rm nvim.appimage
