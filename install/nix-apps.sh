# base-devel
nix-env -iA nixos.autoconf
nix-env -iA nixos.automake
# nix-env -iA nixos.binutils #conflict with gcc
nix-env -iA nixos.bison
nix-env -iA nixos.fakeroot
nix-env -iA nixos.file
nix-env -iA nixos.findutils
nix-env -iA nixos.flex
nix-env -iA nixos.gawk
nix-env -iA nixos.gcc
nix-env -iA nixos.gettext
nix-env -iA nixos.gnugrep
nix-env -iA nixos.groff
nix-env -iA nixos.gzip
nix-env -iA nixos.libtool
nix-env -iA nixos.gnum4
nix-env -iA nixos.gnumake
nix-env -iA nixos.pacman
nix-env -iA nixos.gnupatch
nix-env -iA nixos.pkgconf
nix-env -iA nixos.gnused
nix-env -iA nixos.sudo
nix-env -iA nixos.texinfo
nix-env -iA nixos.which

# gnome
nix-env -iA nixos.chrome-gnome-shell
nix-env -iA nixos.gnome.gnome-tweaks
nix-env -iA nixos.gnomeExtensions.gsconnect
nix-env -iA nixos.gnomeExtensions.tray-icons-reloaded

# tools
nix-env -iA nixos.cmake
nix-env -iA nixos.wget
nix-env -iA nixos.gh
nix-env -iA nixos.python3Full
nix-env -iA nixos.python310Packages.pip
nix-env -iA nixos.jdk
nix-env -iA nixos.go
nix-env -iA nixos.ruby
nix-env -iA nixos.perl
nix-env -iA nixos.nodejs
nix-env -iA nixos.nodePackages.npm
nix-env -iA nixos.yarn
nix-env -iA nixos.texlive.combined.scheme-full
nix-env -iA nixos.ripgrep
nix-env -iA nixos.fd
nix-env -iA nixos.xsel
nix-env -iA nixos.bat
nix-env -iA nixos.zip
nix-env -iA nixos.unzip

# terminal tools
nix-env -iA nixos.alacritty
nix-env -iA nixos.stow
nix-env -iA nixos.vim
nix-env -iA nixos.tmux
nix-env -iA nixos.zsh
nix-env -iA nixos.zsh-completions
nix-env -iA nixos.neofetch

# neovim
nix-env -iA nixos.nerdfonts
nix-env -iA nixos.neovim

# apps
nix-env -iA nixos.firefox-devedition-bin-unwrapped
nix-env -iA nixos.megasync
nix-env -iA nixos.tdesktop
nix-env -iA nixos.ferdi
nix-env -iA nixos.discord
nix-env -iA nixos.vscode
nix-env -iA nixos.mpv
nix-env -iA nixos.mplayer
nix-env -iA nixos.anki-bin
nix-env -iA nixos.openboard
nix-env -iA nixos.gpick
