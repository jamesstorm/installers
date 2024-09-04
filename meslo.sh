#!/bin/bash

reg_fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"
bol_fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Bold/MesloLGLNerdFontMono-Bold.ttf"
ita_fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Italic/MesloLGLNerdFontMono-Italic.ttf"
itb_fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Bold-Italic/MesloLGLNerdFontMono-BoldItalic.ttf"
wget -P ~/.local/share/fonts/ ${reg_fonturl}
wget -P ~/.local/share/fonts/ ${bol_fonturl}
wget -P ~/.local/share/fonts/ ${ita_fonturl}
wget -P ~/.local/share/fonts/ ${itb_fonturl}
