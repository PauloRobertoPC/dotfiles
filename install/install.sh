#!/usr/bin/env bash

# updating
sudo pacman -Syyu --noconfirm

# installing packages
sudo pacman -S --noconfirm \
    wget github-cli base-devel python-pip \
    jdk-openjdk go ruby perl npm yarn \
    ripgrep fd xsel bat zip unzip cmake \
    stow gvim kitty tmux rofi firefox \
    telegram-desktop discord mpd mplayer \
    qtile nitrogen flameshot neofetch \
    alsa alsa-utils lsd polkit alacritty \
    gdb

# installing AUR
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# polkit and font
yay -S --noconfirm xfce-polkit nerd-fonts-complete

# fetching dotfiles
cd $HOME
git clone https://github.com/PauloRobertoPC/dotfiles

# stowing rofi, tmux and kitty
cd $HOME/dotfiles
stow tmux
stow vim
stow kitty
stow alacritty
stow rofi

#installing neovim
cd $HOME/dotfiles/install/
./neovim.sh

# installing twm
cd $HOME/dotfiles/install/
./i3.sh

# intalling heavy apps
yay -S -noconfirm megasync-bin visual-studio-code-bin anki-git openboard
yay -S -noconfirm texlive-full 
