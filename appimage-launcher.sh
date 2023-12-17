#/bin/bash

curl --remote-name https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo nala install appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
rm -rf appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
