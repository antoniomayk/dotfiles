#!/bin/bash

# lxsession &
flameshot &
picom --config ~/.config/picom/picom.conf -b &
conky -c "$HOME/.config/conky/catppuccin.conf"
nitrogen --restore &
nordvpn connect United_States &
