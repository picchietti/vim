" Use Vim instead of Vi settings.
" Avoid side effects by loading first and not if already reset.
if &compatible
  set nocompatible
endif

" https://github.com/vim/vim/blob/master/runtime/defaults.vim
source ~/git/vim/defaults.vim

" Add the one dark color scheme
packadd! onedark.vim
colorscheme onedark

" Ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
" Runs the fixers above when files are saved
let g:ale_fix_on_save = 1

" A faster way to open CtrlP
nnoremap ,p :CtrlP<CR>
" If ag is installed, use it for CtrlP
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" A faster way to open Ack
nnoremap ,a :Ack!<space>
" If ag is installed, use it for ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" display completion matches in a status line
set wildmenu

" Dont backup to extra files
set nobackup
set nowritebackup
set noswapfile

" How many lines of command line history to keep.
set history=9999
" How many times "u" can be pressed.
set undolevels=9999

" Add column with line numbers
set number

" Highlight current line number
set cursorline
hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
hi CursorLineNR cterm=bold

" display partial commands
set showcmd
" Don't timeout for partial commands. Especially useful when you are learning commands
set notimeout
set nottimeout

" Show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" Convert tab to spaces when 'tab' is typed
set expandtab
" Group 4 spaces into a virtual tab
set smarttab
" Use indentation from current line for next line
set autoindent

" Turn on code folding
set foldenable
" Fold by indentation. Also required for code folding
set foldmethod=indent
" Toggle folds with the spacebar
nnoremap <space> za
" Limit of how many folds can be nested in other folds
set foldnestmax=6
" How many lines of indent until code is auto folded when opening buffer
set foldlevelstart=99

" Enable the mouse to position the cursor, visually select, and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Make ,b run :ls and :b to show a list of buffers to select from with b
nnoremap ,b :ls<CR>:b!<space>

" Swap the behavior of p and P
nnoremap p P
nnoremap P p

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
