{
	description = "Flake of PauloRobertoPC";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...} :
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

            systemSettings = rec {
                timezone = "America/Fortaleza";
            };

            userSettings = rec {
                username = "pinto";
                dotfilesDir = "~/dotfiles";
            };
		in{
			nixosConfigurations = {
				nixos = lib.nixosSystem {
					inherit system;
					modules = [ ./configuration.nix ];
                    specialArgs = {
                        inherit pkgs-unstable;
                        inherit systemSettings;
                    };
				};
			};
			homeConfigurations = {
				pinto = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./home.nix ];
                    extraSpecialArgs = {
                        inherit pkgs-unstable;
                        inherit userSettings;
                    };
				};
			};
		};
}
