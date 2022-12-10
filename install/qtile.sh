#!/usr/bin/env bash

sudo pacman -S --noconfirm \
    qtile

cd $HOME/dotfiles/
rm -r ~/.config/qtile/
stow qtile
