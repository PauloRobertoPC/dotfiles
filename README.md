# Installing in NixOS

1. Update hardware configuration to match with your machine
```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
2. Build sytem packages
```bash
./update-system.sh
```
if something goes wrong in this step see "/etc/nixos/configuration.nix"
    
3. Downloading home-manager
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
```
See [home manager manual](https://nix-community.github.io/home-manager/) to download new versions

4. Restart your computer

5. Install home-manager
```bash
nix-shell '<home-manager>' -A install
```

