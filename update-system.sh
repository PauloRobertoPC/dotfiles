pushd ~/dotfiles

sudo nixos-rebuild switch --flake .#nixos

popd
