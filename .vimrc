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
\ 'V': 'VISUAL-LINE',
\ "\<C-V>": 'VISUAL-BLOCK',
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

" menuone: show autocomplete menu even when there is only 1 match
" noinsert: dont insert text from a match until an autocomplete option is selected
set completeopt+=menuone,noinsert
" Turn on autocomplete plugin at startup
let g:mucomplete#enable_auto_at_startup = 1

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

" vim-gitgutter
let g:gitgutter_sign_added = '▋'
let g:gitgutter_sign_modified = '▋'
let g:gitgutter_sign_removed = '▋'
let g:gitgutter_sign_removed_first_line = '▋'
let g:gitgutter_sign_modified_removed = '▋'

" A faster way to open CtrlP
nnoremap ,p :CtrlP<CR>
" Display CtrlP buffer switcher. Alternative to :ls<CR>:b!<space>
nnoremap ,b :CtrlPBuffer<CR>
let g:ctrlp_match_window = 'min:1,max:12'
" If ag is installed, use it for CtrlP
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif
" Dont use CtrlP's custom statusline
let g:ctrlp_buffer_func = {
  \ 'enter': 'RemoveCtrlPStatusLine',
  \ 'exit': 'RestoreCtrlPStatusLine'
\}
function! RemoveCtrlPStatusLine()
  set laststatus=0
endfunction
function! RestoreCtrlPStatusLine()
  set laststatus=2
endfunction
if argc() == 0
  autocmd VimEnter * CtrlP
endif

" Project-wide find via EasyGrep
nnoremap ,f :Grep<space>
" Project-wide replace via EasyGrep
nnoremap ,r :Replace<space>

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Allow unsaved buffers to be switched away from
set hidden
" Prompt to save an unsaved buffer on close
set confirm

" display completion matches in a status line
set wildmenu

" modeline is vim configuration placed in files that vim opens. Disabled for security.
set nomodeline

" Dont backup to extra files
set nobackup
set nowritebackup
" Persists unsaved changes to be recovered later if terminal or computer crashes
set swapfile
" Changes location of swap file from the current directory.
set directory=~/.vim/swap//
" Auto-recover instead of prompt
augroup AutomaticSwapRecoveryAndDelete
  autocmd!
  autocmd SwapExists * :let v:swapchoice = 'r' | let b:swapname = v:swapname
  autocmd BufWinEnter * :if exists("b:swapname") | call delete(b:swapname) | unlet b:swapname | endif
augroup end

" Turn off spell checking (default off).
set nospell
" The language used for spell checking, in this case English.
set spelllang=en

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
" Make numbers relative to the current line for easy repetition
set relativenumber
" Highlight current line
set cursorline
" Highlight current line number
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

" Show invisible characters
set list
" Set how certain invisible characters are shown
set listchars=tab:>>,trail:-

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

" Close search.
nnoremap ,xs :noh<CR>
" Clear CtrlP cache. Useful when files change outside of vim, such as with git.
nnoremap ,xp :CtrlPClearAllCaches<CR>
" Clear other buffers
nnoremap ,xb :%bd\|e#\|bd#<CR>

" Swap the behavior of p and P
nnoremap p P
nnoremap P p

" U does redo instead of restore current line
nnoremap U <C-r>

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
nnoremap ,ga :!git add .<CR>
nnoremap ,gd :!git checkout --<space>
nnoremap ,gc :!git commit -m ""<Left>
nnoremap ,gp :!git push<CR>
nnoremap ,gl :!git log --graph --oneline --decorate --all<CR>
nnoremap ,gh :echo "
\Git shortcuts: \n
\,gu - git update (fetches and pulls) \n
\,gb - git branch (switch or create branches) \n
\,gs - git status \n
\,ga - git add (add all files to index) \n
\,gd - git discard specified file \n
\,gc - git commit \n
\,gp - git push (current branch) \n
\,gl - git log
\"<CR>

" Start searching before pressing enter.
set incsearch
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
