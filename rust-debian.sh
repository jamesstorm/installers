#!/bin/sh

#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl https://sh.rustup.rs >./installrust.sh
chmod +x installrust.sh
./installrust.sh -y
rm installrust.sh
