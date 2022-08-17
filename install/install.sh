sudo pacman -Syyu
sudo pacman -S wget github-cli base-devel python-pip jdk-openjdk go ruby perl npm yarn ripgrep fd xsel bat zip unzip cmake stow gvim kitty tmux rofi firefox-developer-edition telegram-desktop discord mpd mplayer qtile nitrogen

cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd $HOME
cd dotfiles

rm -r ~/.config/qtile/
stow qtile
stow rofi
stow tmux
stow kitty

yay -S megasync ferdi-bin visual-studio-code-bin anki-git neovim-git nerd-fonts-complete texlive-full

pip install pynvim
sudo npm i -g neovim
gem install neovim
stow nvim

