{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        blueman
        brightnessctl
        cliphist
        grim
        hypridle
        hyprland
        hyprlock
        hyprpaper
        hyprshot
        libnotify
        networkmanager
        networkmanagerapplet
        nwg-look
        rofi-wayland
        wl-clipboard
        xdg-desktop-portal-hyprland
	];

	home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/hyprland.conf";
	home.file.".config/hypr/hyprpaper.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/hyprpaper.conf";
	home.file.".config/hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/hyprlock.conf";
	home.file.".config/hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/hypridle.conf";
	home.file.".config/hypr/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/rofi";
	home.file.".config/hypr/assets".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/assets";
}
