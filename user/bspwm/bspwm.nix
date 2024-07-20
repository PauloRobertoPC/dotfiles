{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        betterlockscreen
        blueman
        brightnessctl
        bspwm
        cmus
        dunst
        feh
        flameshot
        killall
        libnotify
        lxappearance
        networkmanager
        networkmanagerapplet
        pamixer
        pavucontrol
        picom-jonaburg
        polybar
        pulseaudio
        rofi
        sxhkd
        upower
        xorg.xrandr
	];

	home.file.".config/bspwm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/bspwm/bspwm";
	home.file.".config/sxhkd/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/bspwm/sxhkdrc";
}
