#!/bin/bash

#### INSTALL

OMP_INSTALL_DIR=$HOME/.local/bin/
OMP_NAME=ohmyposh
debug "installing to: ${OMP_INSTALL_DIR}"
[ -x $OMP_INSTALL_DIR/$OMP_NAME ] && rm -rf $OMP_INSTALL_DIR/$OMP_NAME
mkdir -p $OMP_INSTALL_DIR
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $OMP_INSTALL_DIR
