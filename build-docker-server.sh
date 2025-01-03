#!/bin/bash

# Assumptions:
# - fresh Debain 12 install
# - a user named james
#
#
#
#

cd ~

# install the things
sudo apt install stow ansible curl build-essential -y


git clone https://github.com/jamesstorm/installers
./installers/gh-debian.sh
./installers/dotfiles.sh

mkdir -p ~/.config

stow -d ~/dotfiles git
stow -d ~/dotfiles nvim

cd ~/installers

./gh_secrets.sh
./neovim-tar.sh
./lazy.sh

# get git secrets
#
#
# get the
