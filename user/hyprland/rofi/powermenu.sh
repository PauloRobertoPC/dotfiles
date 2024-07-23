#!/bin/sh
chooses="Lock\nLog out\nReboot\nPower Off\n"
choosen=$(printf "$chooses" | rofi -dmenu -theme ~/.config/hypr/rofi/style.rasi
)

case "$choosen" in
    "Lock") betterlockscreen -l;;
    "Logout") hyprctl dispatch quit;;
    "Reboot") reboot;;
    "Power Off") poweroff;;
    *) exit 1;;
esac
