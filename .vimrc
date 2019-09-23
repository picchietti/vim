" Use Vim instead of Vi settings.
" Avoid side effects by loading first and not if already reset.
if &compatible
  set nocompatible
endif

" https://github.com/vim/vim/blob/master/runtime/defaults.vim
source ~/git/vim/defaults.vim

" Map mode
let g:modeMap={
\ 'n': 'NORMAL',
\ 'v': 'VISUAL',
\ 'i': 'INSERT',
\ 'R': 'REPLACE',
\ 's': 'SELECT',
\ 't': 'TERMINAL',
\ 'c': 'COMMAND',
\ '!': 'SHELL',
\}

let b:gitbranch=""

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \  ' [✗ %d ⚠ %d]',
  \  all_errors,
  \  all_non_errors
  \)
endfunction

function! StatuslineGitBranch()
  let b:gitbranch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  let b:gitbranch = strlen(b:gitbranch) > 0?b:gitbranch:''
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" Show status line
set laststatus=2
" Dont show mode. The status line will instead
set noshowmode
" Reset the status line
set statusline=
" Build the custom status line
set statusline+=\ %m " Add modified status
set statusline+=\ [%{g:modeMap[mode()]}] " Add mode
set statusline+=\ [%f] " Add file name
set statusline+=%{LinterStatus()} " Add linter status
set statusline+=\ %l:%c " Add line:column position
set statusline+=%= " Push content right
set statusline+=\ [%{b:gitbranch}] " Add git branch name
set statusline+=\ %y " Add file type
set statusline+=\ [%{&ff}]\ " Add file format

" Add the one dark color scheme
packadd! onedark.vim
colorscheme onedark
" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on
endif

" Ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
" Runs the fixers above when files are saved
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
highlight ALEError cterm=underline ctermbg=NONE ctermfg=9
highlight ALEErrorSign ctermbg=NONE ctermfg=9
highlight ALEWarning cterm=underline ctermbg=NONE ctermfg=227
highlight ALEWarningSign ctermbg=NONE ctermfg=227

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

" Reload file if changed externally
" Trigger autoread with ":checktime"
set autoread

" Trigger CursorHold after 200ms instead of 4s. Updates things like GitGutter at a reasonable rate.
set updatetime=200

" How many lines of command line history to keep.
set history=9999
" How many times "u" can be pressed.
set undolevels=9999

" Attempts to always keep 5 lines above and below the cursor when scrolling or mouse clicking to a new line.
set scrolloff=5

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

" Max length before syntax highlighting is turned off.
" If 500 is set, a line with 550 characters will only syntax highlight 500 characters.
" Lowering this improves performance in files with long lines.
set synmaxcol=500

" Enable the mouse to position the cursor, visually select, and scroll.
if has('mouse')
  set mouse=a
endif

" Make ,b run :ls and :b to show a list of buffers to select from with b
nnoremap ,b :ls<CR>:b!<space>

" Swap the behavior of p and P
nnoremap p P
nnoremap P p

" Escape insert mode by typing 'jk'
inoremap jk <Esc>

" Move visual block up or down and change indent.
" More handy for moving multiple lines than dd & p. Not as handy for moving a single line.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Block arrow keys in normal mode.
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Git shortcuts
nnoremap ,gu :!git fetch && git pull<CR>
nnoremap ,gb :!git switch<space>
nnoremap ,gs :!git status<CR>
nnoremap ,gc :!git commit -m ""<Left>
nnoremap ,gp :!git push<CR>

" Start searching before pressing enter.
set incsearch
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Words of affirmation
autocmd BufWritePost * echo "Awesome contribution, Jon! You're a rockstar developer!"

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

endif " has("autocmd")
