#!/bin/bash

read -sp 'password: ' VAULTPWD
echo "${VAULTPWD}" >>pwd.txt

# remove existing gh config
rm -rf ~/.config/gh

cp -R ./secrets/gh ~/.config/

ansible-vault decrypt --vault-password-file ./pwd.txt ~/.config/gh/config.yml
ansible-vault decrypt --vault-password-file ./pwd.txt ~/.config/gh/hosts.yml

rm pwd.txt

# also use stow to link my .gitconfig
stow -d $HOME/dotfiles git
