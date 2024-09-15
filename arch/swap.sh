#!/bin/bash

btrfs filesystem mkswapfile size 4g --uuid clear /swap/swapfile
swapon /swap/swapfile

echo "" >>/etc/fstab
echo "/swap/swapfile none swap defaults 0 0" >>/etc/fstab
