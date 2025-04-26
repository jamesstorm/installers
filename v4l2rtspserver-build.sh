#!/bin/bash


git clone https://github.com/mpromonet/v4l2rtspserver.git
cd v4l2rtspserver
cmake .
make
sudo make install
