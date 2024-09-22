{
	description = "Flake of PauloRobertoPC";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

        ags.url = "github:Aylur/ags";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...}@inputs :
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			# pkgs = nixpkgs.legacyPackages.${system};
            pkgs = import nixpkgs {
                inherit system;
                config = { 
                    allowUnfree = true; 
                    cudaSupport = true;
                };
            };
			pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

            systemSettings = rec {
                username = "pinto";
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
                        inherit inputs;
                        inherit pkgs-unstable;
                        inherit userSettings;
                    };
				};
			};
		};
}
