#!/bin/bash

read -sp 'password: ' VAULTPWD
echo "${VAULTPWD}" >>/tmp/pwd.txt

ansible-vault decrypt ./secrets/secretkey --vault-password-file /tmp/pwd.txt --output /tmp/deleteme
cat /tmp/deleteme
rm /tmp/pwd.txt
rm /tmp/deleteme
