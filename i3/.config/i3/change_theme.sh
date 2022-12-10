#!/usr/bin/env bash

[ $# -ne 1 ] && exit 1

curr_dir="$HOME/.config/i3"
theme_dir="$HOME/.config/i3/themes/$1"

# wallpaper
cp $theme_dir/images/wall.webp $curr_dir/images/wall.webp
# betterlockscreen wallpaper
cp $theme_dir/images/betterlockscreen.webp $curr_dir/images/betterlockscreen.webp
# rofi
cp $theme_dir/rofi/rofi.rasi $curr_dir/rofi/rofi.rasi
# polybar or eww
cp $theme_dir/polybar/config.ini $HOME/.config/polybar/config.ini
cp $theme_dir/polybar/launch.sh $HOME/.config/polybar/launch.sh

# gaps and rounded corners
# alacritty, fonts
# picom
# dunst

exit 0
