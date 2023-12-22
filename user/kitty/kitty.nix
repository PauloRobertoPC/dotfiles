{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        kitty
        kitty-img
	];

	home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/kitty/kitty.conf";
}
