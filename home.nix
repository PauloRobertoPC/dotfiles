{ config, pkgs, ... }:
{
    nixpkgs = {
        config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
        };
    };

	imports = [
		./user/dev/dev.nix
		./user/kitty/kitty.nix
		./user/tmux/tmux.nix
		./user/zsh/zsh.nix
		./user/nvim/nvim.nix
		./user/virtualization/virtualization.nix
		./user/dwm/dwm.nix
	];

	home.username = "pinto";
	home.homeDirectory = "/home/pinto";

	home.stateVersion = "23.11"; # Please read the comment before changing.

	home.packages = with pkgs; [
        ticktick
        zathura
        texliveFull
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
