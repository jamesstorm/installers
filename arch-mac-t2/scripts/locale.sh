#!/bin/bash

sed -i 's/#en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen
echo "LANG=en_CA.UTF-8" >>/etc/locale.conf
locale-gen
