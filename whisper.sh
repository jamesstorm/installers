#!/bin/bash

sudo pacman -S --noconfirm --needed ffmpeg
pip install setuptools-rust
pip install -U openai-whisper
