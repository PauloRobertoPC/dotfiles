{ config, pkgs, ... }:

{
	imports = [
		./user/dev/dev.nix
		./user/zsh/zsh.nix
		./user/nvim/nvim.nix
	];

	home.username = "pinto";
	home.homeDirectory = "/home/pinto";

	home.stateVersion = "23.11"; # Please read the comment before changing.

	home.packages = with pkgs; [
		pkgs.hello
	];

	home.file = {
		#"test.conf".source = ./test.conf;
		#"test.conf".text = "My file will contain this text";
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
