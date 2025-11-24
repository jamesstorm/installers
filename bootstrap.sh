#!/bin/bash

FUNCTIONS_URL="https://raw.githubusercontent.com/jamesstorm/installers/refs/heads/master/functions.sh"

# run as root
if [ $(id -u) -ne 0 ]; then
  echo "please run as root"
  exit 1
fi

# Download and source it
. /dev/stdin <<EOF
$(curl -fsSL "$FUNCTIONS_URL")
EOF

get_real_user
get_os

echo "Hello, $REAL_USER"
echo "Home dir: $HOME_DIR"
echo "Detected OS: $OS_NAME"

if [ "$OS_NAME" = "debian" ]; then
	apt update -y
	apt upgrade -y 
	apt install -y git gh stow ansible
elif [ "$OS_NAME" = "arch" ]; then
	pacman -Syu git stow ansible
	#echo "pacman calls not implemented... yet"
	#exit 1
fi

sudo -u $REAL_USER git clone https://github.com/jamesstorm/installers $HOME_DIR/installers
sudo -u $REAL_USER git clone https://github.com/jamesstorm/dotfiles $HOME_DIR/dotfiles
