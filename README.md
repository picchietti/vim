# Vim

## Installation
### Linux
```bash
sudo apt install -y vim
```

### MacOS
```bash
brew cask install macvim
```

## Dependencies
### Linux
```bash
sudo apt-get install silversearcher-ag
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
```

### MacOS
```bash
brew install the_silver_searcher
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
```

## Setup
Create a link from ~/.vimrc to git/vim/.vimrc
```bash
ln -sT ~/.vimrc ~/git/vim/.vimrc
```
