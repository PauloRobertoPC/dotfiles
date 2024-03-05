{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        betterlockscreen
        blueman
        brightnessctl
        cmus
        dunst
        feh
        flameshot
        awesome
        picom-jonaburg
        libnotify
        lxappearance
        networkmanager
        networkmanagerapplet
        pulseaudio
        rofi
        upower
        xorg.xrandr
	];

	home.file.".config/awesome/rc.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/awesome/rc.lua";
	home.file.".config/awesome/assets".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/awesome/assets";
	home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/awesome/rofi";
	home.file.".config/picom/picom.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/awesome/picom.conf";
}
