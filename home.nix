{ config, pkgs, inputs, pkgs-unstable, userSettings, ... }:
{
    nixpkgs = {
        config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
        };
    };

	imports = [
        inputs.ags.homeManagerModules.default
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

	home.stateVersion = "24.05"; # Please read the comment before changing.

	home.packages = (
        with pkgs; [
            appimage-run
            cachix
            devenv
            localsend
            rnote
            texliveFull
            ticktick
            zathura
            zotero
        ]
    )
    ++
    (
        with pkgs-unstable; [
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

    programs.ags = {
        enable = true;
        # null or path, leave as null if you don't want hm to manage the config
        configDir = null;
        # additional packages to add to gjs's runtime
        extraPackages = with pkgs; [
            gtksourceview
            webkitgtk
            accountsservice
        ];
    };

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
