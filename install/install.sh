#!/usr/bin/env bash

# updating
echo -e "UPDATING..."
sudo pacman -Syyu --noconfirm
echo -e "UPDATE FINISHED"

# installing packages
echo -e "INSTALLING PACKAGES..."
sudo pacman -S --noconfirm \
    wget github-cli base-devel python-pip \
    jdk-openjdk go ruby perl npm yarn \
    ripgrep fd xsel bat zip unzip cmake \
    stow gvim kitty tmux rofi firefox \
    telegram-desktop discord mpd mplayer \
    qtile nitrogen flameshot neofetch \
    alsa alsa-utils
echo -e "PACKAGES INSTALLED"

# installing AUR
echo -e "INSTALLING AUR..."
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo -e "AUR INSTALLED"

# fetching dotfiles
echo -e "FETCHING DOTFILES"
cd $HOME
git clone https://github.com/PauloRobertoPC/dotfiles
echo -e "DOTFILES FETCHED"

# stowing rofi, tmux and kitty
echo -e "STOWING"
cd $HOME/dotfiles
stow tmux
stow vim
# stow kitty
stow alaccrity
stow rofi
echo -e "STOW DONE"

# installing twm
echo -e "INSTALLING TWM"
cd $HOME/dotfiles/install/
./i3.sh
echo -e "TWM INSTALLED"

# intalling heavy apps
echo -e "INSTALLING HEAVY APPS"
yay -S -noconfirm megasync-bin visual-studio-code-bin anki-git openboard
yay -S -noconfirm texlive-full 
echo -e "HEAVY APPS INSTALLED"
