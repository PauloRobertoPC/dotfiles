yay -S neovim-git nerd-fonts-complete

pip install pynvim
sudo npm i -g neovim
gem install neovim
stow nvim

# installing plugins without open neovim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# hexcolor plugin
cd ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase && make hexokinase

# python debug
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
