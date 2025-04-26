#!/bin/bash
git clone https://github.com/mpromonet/rpicam-rtsp-server ~/rpicamserver
cd ~/rpicamserver
cmake .
make
sudo make install
