sudo pacman -Syyu
sudo pacman -S wget github-cli base-devel python-pip jdk-openjdk go ruby perl npm yarn ripgrep fd xsel bat zip unzip
sudo pacman -S stow gvim kitty tmux zsh zsh-completions
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
~/.fzf/install
source ~/.zshrc
chsh -s $(which zsh)
cd $HOME
cd dotfiles
stow tmux
stow kitty
stow zsh
yay -S pamac-all
