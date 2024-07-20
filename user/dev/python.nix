{ config, lib, pkgs, ...}:
{
	home.packages = with pkgs; [
        conda
		python3
		python3Packages.pip
	];
}
