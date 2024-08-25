#!/bin/bash
source $HOME/installers/functions.sh
remkdir $HOME/.config/bat/themes
TN_SUB_THEME=$HOME/tokyonight.nvim/extras/sublime
BAT_THEMES=$XDG_CONFIG_HOME/bat/themes
link_dotfile $TN_SUB_THEME/tokyonight_day.tmTheme $BAT_THEMES tokyonight_day.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_moon.tmTheme $BAT_THEMES tokyonight_moon.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_night.tmTheme $BAT_THEMES tokyonight_night.tmTheme
link_dotfile $TN_SUB_THEME/tokyonight_storm.tmTheme $BAT_THEMES tokyonight_storm.tmTheme

bat cache --build
