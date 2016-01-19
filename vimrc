" VIM Configuration - Rémi Saurel

set nocompatible

" Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'flazz/vim-colorschemes'
Plug 'kien/ctrlp.vim'

call plug#end()

if exists('$TMUX')
  set term=screen-256color
endif

colorscheme desert256

" Nvim/Vim specific configuration
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
  set t_Co=256
  if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
  endif
end

set title
set ruler
set mouse =a
set number
set wrap
set cursorline
set scrolloff=3
""set tabstop =4
""set shiftwidth =4
""set softtabstop =4
""set expandtab
set ignorecase
set smartcase
set incsearch
set hlsearch
set novisualbell
set noerrorbells
set fileformat=unix
set autoread

set backspace=indent,eol,start
set hidden

" Natural vertical movements
map  <up> gk
map  <down> gj
map j gj
map k gk

"" Supprime les espaces en fin de ligne des sources C
"autocmd BufWritePre *.c :%s/\s\+$//e

" Variables pour plugins
set runtimepath^=~/.vim/bundle/ctrlp.vim
let mapleader=","

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Set french spell language
set spelllang=fr

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let g:ctrlp_working_path_mode = 0

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" eliminate delay after pressing ESC to switch back to normal mode
set timeoutlen=1000 ttimeoutlen=0

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <F2> :call TrimWhiteSpace()<CR>
