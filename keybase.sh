#!/bin/bash

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb -y
run_keybase
rm keybase_amd64.deb
