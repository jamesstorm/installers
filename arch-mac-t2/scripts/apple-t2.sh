#/bin/bash

sed -i 's/Modules=()/Modules=(apple-bce)/g' /etc/mkinitcpio.conf
mkinitcpio -P
