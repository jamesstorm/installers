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
apt install stow ansible curl build-essential -y

source ./gh-debian.sh

git clone https://github.com/jamesstorm/installers
source ./installers/dotfiles.sh
mkdir -p ~/.config
stow -d ~/dotfiles git
stow -d ~/dotfiles nvim

cd ~/installers

source ./gh_secrets.sh
source ./neovim-tar.sh
source ./lazy.sh

# get git secrets
#
#
# get the
