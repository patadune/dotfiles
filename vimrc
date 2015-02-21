" VIM Configuration - reminus

call pathogen#infect()

if has('gui_running')
    set background=dark
    colorscheme solarized
    set antialias
else
    set t_Co=256
    colorscheme desert256
end

set title
set ruler
set number
set wrap
set cursorline
set scrolloff=3
set tabstop =4
set shiftwidth =4
set softtabstop =4
set expandtab
set ignorecase
set smartcase
set incsearch
set hlsearch
set visualbell
set noerrorbells

set backspace=indent,eol,start
set hidden

syntax enable

filetype on
filetype plugin on
filetype indent on

map <up> gk
map <down> gj

" Supprime les espaces en fin de ligne des sources C
autocmd BufWritePre *.c :%s/\s\+$//e

set runtimepath^=~/.vim/bundle/ctrlp.vim
