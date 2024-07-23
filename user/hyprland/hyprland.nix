{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        blueman
        brightnessctl
        dunst
        flameshot
        hyprland
        libnotify
        networkmanager
        networkmanagerapplet
        rofi-wayland
        wl-clipboard
        xdg-desktop-portal-hyprland
	];

	home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/hyprland.conf";
	home.file.".config/hypr/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/hyprland/rofi";
}
