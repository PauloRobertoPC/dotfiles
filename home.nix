{ config, pkgs, pkgs-unstable, userSettings, ... }:
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
		./user/hyprland/hyprland.nix
	];

	home.username = userSettings.username;
    home.homeDirectory = "/home/"+userSettings.username;

	home.stateVersion = "23.11"; # Please read the comment before changing.

	home.packages = (
        with pkgs; [
            cachix
            rnote
            texliveFull
            ticktick
            zathura
        ]
    )
    ++
    (
        with pkgs-unstable; [
            devenv
        ]
    );

	home.file = {
		#"test.conf".source = ./test.conf;
		#"test.conf".text = "My file will contain this text";
	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

    programs.git = {
        enable = true;
        userName = "PauloRobertoPC";
        userEmail = "prpc025pro@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
