" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Dont backup to extra files
set nobackup
set nowritebackup
set noswapfile

" Add column with line numbers
set number

" Highlight current line number
set cursorline
hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
hi CursorLineNR cterm=bold

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

else

  set autoindent		" always set autoindenting on

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
