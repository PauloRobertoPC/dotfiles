{ config, lib, pkgs, pkgs-unstable,...}:
let
home = builtins.getEnv "HOME";
in
{
    home.packages = with pkgs; [
        nerdfonts
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
        quarto
        python3Packages.jupytext
    ];

    programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim-unwrapped;
        withRuby = true;
        withNodeJs = true;
        extraLuaPackages = ps : [ ps.magick ];
        extraPackages = [ pkgs.imagemagick ];
        extraPython3Packages = ps : [ 
            ps.pip 
            ps.pynvim 
            ps.jupyter-client
            ps.cairosvg
            ps.pnglatex
            ps.plotly
            ps.pyperclip
            ps.nbformat
            ps.pillow
        ];
    };

    home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/user/nvim/config";
}
