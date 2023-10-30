#!/bin/sh
#

groupadd --gid 3000 mediausers
useradd --uid 3000 -m mediauser

usermod -aG mediausers mediauser
usermod -aG sudo mediausers
echo "=============================="
echo "Enter a password for mediauser"
echo "=============================="
passwd mediauser
