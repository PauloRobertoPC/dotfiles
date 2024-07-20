{ config, lib, pkgs, ...}:
let
home = builtins.getEnv "HOME";
in
{
    home.packages = with pkgs; [
        neovim
        nerdfonts
        python3Packages.pynvim
        ruby
        nodePackages_latest.neovim
        nodejs
        gcc
        libgcc
        gnumake
        cmake
        autoconf
        automake
        libtool
        zip
        unzip
        xsel
        ripgrep
        gnugrep
        clang-tools
        cargo
        yarn
    ];

    home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/nvim/config";
}
