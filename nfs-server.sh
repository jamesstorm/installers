#!/bin/sh

sudo apt update
sudo apt install nfs-kernel-server nfs-common -y
sudo systemctl is-enabled nfs-server
sudo systemctl status nfs-server
