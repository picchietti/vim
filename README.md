# Vim
I'm venturing into the world of vim. Until I can decide between vim and neovim, you might see support for both.

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
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp.vim
git clone https://github.com/mileszs/ack.vim.git ~/.vim/pack/plugins/start/ack.vim
git clone https://github.com/dense-analysis/ale.git ~/.vim/pack/plugins/start/ale.vim
```

### Linux
```bash
sudo apt install silversearcher-ag
```

### MacOS
```bash
brew install the_silver_searcher
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
