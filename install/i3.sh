#!/usr/bin/env bash

sudo pacman -S --noconfirm \
    i3-gaps betterlockscreen \
    polybar

cd $HOME/dotfiles/
stow i3
stow polybar

# applying initial theme
cd $HOME/.config/i3
./change_theme.sh black_hole
i3-msg restart
