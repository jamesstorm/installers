#!/bin/bash
echo "#####"
echo "Partitioning $INSTALL_PARTITION"
echo "select n, defaults."
echo "select w, Y to write the changes"
gdisk $INSTALL_PARTITION
