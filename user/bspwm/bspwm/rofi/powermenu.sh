#!/bin/sh
chooses="Lock\nLog out\nReboot\nPower Off\n"
choosen=$(printf "$chooses" | rofi -dmenu)

case "$choosen" in
    "Lock") betterlockscreen -l;;
    "Logout") bspc quit;;
    "Reboot") reboot;;
    "Power Off") poweroff;;
    *) exit 1;;
esac
