#!/bin/bash

# Assumptions:
# - fresh Debain 12 install
# - a user named james
#
#
#
#
# install the things
apt install stow ansible curl build-essential -y

source ./gh-debian.sh

cd ~

git clone https://github.com/jamesstorm/installers
source ./installers/dotfiles.sh

cd ~/dotfiles
stow git
cd ../installers
source ./gh_secrets.sh

# get git secrets
#
#
# get the
