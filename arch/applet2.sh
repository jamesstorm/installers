#!/bin/bash

sed -i 's/MODULES=()/MODULES=(apple-bce)/' /etc/mkinitcpio.conf

mkinitcpio -P
