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

## Dependencies/Plugins
### Plugins
```bash
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp.vim
git clone https://github.com/mileszs/ack.vim.git ~/.vim/pack/plugins/start/ack.vim
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
