#!/bin/bash

sed -i 's/Modules=()/Modules=(apple-bce)/' /etc/mkinitcpio.conf
mkinitcpio -P
