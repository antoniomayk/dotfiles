#!/bin/bash

light-locker &
flameshot &
picom --config ~/.config/picom/picom.conf -b &
conky -c "$HOME/.config/conky/catppuccin_latte.conf"
nitrogen --restore &
