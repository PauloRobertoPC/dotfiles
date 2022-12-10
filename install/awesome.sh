#!/usr/bin/env bash

yay -S --noconfirm \
    awesome-git

cd $HOME/dotfiles/
stow awesome
