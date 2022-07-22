sudo pacman -S git stow
yay -S neovim-git nerd-fonts-complete 
cd $HOME
git clone https://github.com/PauloRobertoPC/dotfiles
cd dotfiles
stow nvim
yay -S nerd-fonts-complete
