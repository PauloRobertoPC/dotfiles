{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        tmux
	];

	home.file.".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/tmux/tmux.conf";
	home.file.".config/tmux/plugins".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/tmux/plugins";
}
