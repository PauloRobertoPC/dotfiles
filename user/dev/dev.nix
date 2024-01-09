{ config, lib, pkgs, ...}:
{
	imports = [
		./cc.nix
		./python.nix
	];
    
	home.packages = with pkgs; [
        dbeaver
    ];
}
