{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        betterlockscreen
        blueman
        brightnessctl
        feh
        flameshot
        i3
        i3status
        networkmanager
        networkmanagerapplet
        pulseaudio
        rofi
        xorg.xrandr
	];

	home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/config";
	home.file.".config/i3/monitors_workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/monitors_workspaces.conf";
	home.file.".config/i3/rules.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/rules.conf";
	home.file.".config/i3/bindings.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/bindings.conf";
	home.file.".config/i3/assets".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/assets";
	home.file.".config/i3status/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/i3/i3status.config";
}
