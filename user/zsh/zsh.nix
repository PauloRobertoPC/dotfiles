{ config, lib, pkgs, ...}:
let
  home = builtins.getEnv "HOME";
in
{
	home.packages = with pkgs; [
        zsh
        lsd
        btop
        bat
	];

	home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/zsh/.zshrc";
	home.file.".zsh_aliases".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/zsh/.zsh_aliases";
	home.file.".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/zsh/.p10k.zsh";
}
