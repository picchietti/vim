# Vim
I'm venturing into the world of vim. I'm currently favoring neovim, but you might see support for both.

## Installation
### Linux
```bash
sudo apt install -y vim
sudo apt install -y neovim
```

### MacOS
```bash
brew cask install macvim
brew install neovim
```

## Dependencies/Plugins
### Plugins
```bash
# fuzzy finder open files
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp.vim
# search project
git clone https://github.com/mileszs/ack.vim.git ~/.vim/pack/plugins/start/ack.vim
# linting
git clone https://github.com/dense-analysis/ale.git ~/.vim/pack/plugins/start/ale.vim
# git diff indicator next to line number
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/plugins/start/gitgutter.vim
# color theme
git clone https://github.com/joshdick/onedark.vim.git ~/.vim/pack/plugins/opt/onedark.vim
# indent detection
git clone https://github.com/Raimondi/yaifa.git ~/.vim/pack/plugins/start/yaifa
```

### Linux Dependencies
```bash
sudo apt install -y silversearcher-ag

# install latest git (>=2.23.0)
# used by ,gb for git switch
sudo apt-add-repository ppa:git-core/ppa
sudo apt update
sudo apt install -y git
```

### MacOS Dependencies
```bash
brew install the_silver_searcher
brew install git
```

## Setup
Create a link from ~/.vimrc to git/vim/.vimrc
```bash
ln -sT ~/.vimrc ~/git/vim/.vimrc
```
For neovim:
```bash
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```
