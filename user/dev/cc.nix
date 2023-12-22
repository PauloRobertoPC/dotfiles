{ config, lib, pkgs, ...}:
{
	home.packages = with pkgs; [
		gcc
		libgcc
      	gnumake
      	cmake
      	autoconf
      	automake
      	libtool
	];
}
