# Installing in NixOS

1. Update hardware configuration to match with your machine
```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
2. Replace the current configuration.nix for the configuration.nix in /etc/nixos/ and put the packages and other configurations that has in the current configuration.
3. Update flake.nix to get the packages for the version of NixOS you are in.
4. Build sytem packages
```bash
./update-system.sh
``` 
5. Downloading home-manager
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
```
See [home manager manual](https://nix-community.github.io/home-manager/) to download new versions

6. Restart your computer

7. Install home-manager
```bash
nix-shell '<home-manager>' -A install
```
8. Update stateVersion of home.nix if necessary.

9. Build home packages
```bash
./update-home.sh
``` 

