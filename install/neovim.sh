yay -S neovim-git nerd-fonts-complete codelldb-bin

pip install pynvim
sudo npm i -g neovim
gem install neovim

cd $HOME/dotfiles/
stow nvim

# installing plugins without open neovim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# python debug
cd $HOME
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
