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
    gdb sox 

# installing AUR
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# polkit and font
yay -S --noconfirm gnome-browser-connector nerd-fonts-complete

# stowing rofi, tmux and kitty
cd $HOME/dotfiles
stow tmux
stow vim
stow kitty
stow alacritty
stow rofi

#installing zsh
cd $HOME/dotfiles/install/
./zsh.sh

#installing neovim
cd $HOME/dotfiles/install/
./neovim.sh

# installing twm
cd $HOME/dotfiles/install/
./i3.sh

# intalling heavy apps
yay -S --noconfirm \
    megasync-bin nautilus-megasync \
    visual-studio-code-bin anki-git \
    jdownloader2 amberol ferdium-bin \
    koodo-reader-bin rnote \
    bcm20702a1-firmware

yay -S --noconfirm texlive-full
