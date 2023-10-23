#!/bin/bash

read -sp 'password: ' VAULTPWD
echo "${VAULTPWD}" >>pwd.txt

# remove existing aws config
rm -rf ~/.aws

cp -R ./secrets/.aws ~/.aws

ansible-vault decrypt --vault-password-file ./pwd.txt ~/.aws/config
ansible-vault decrypt --vault-password-file ./pwd.txt ~/.aws/credentials

sudo apt install awscli -y

rm pwd.txt
