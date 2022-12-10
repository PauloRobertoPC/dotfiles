#!/usr/bin/env bash

change_theme_command="$HOME/.config/i3/change_theme.sh"
rofi_command="rofi -dmenu -theme $HOME/.config/i3/rofi/rofi.rasi"

# Options
black_hole="Black Hole"

options="$black_hole\n"

selected=$(echo -e $options | $rofi_command)
case $selected in
    $black_hole)
        $change_theme_command black_hole
        i3-msg restart
        ;;				
esac

exit 0
