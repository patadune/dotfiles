" VIM Configuration - Rémi Saurel

call pathogen#infect()

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

set background=dark
colorscheme solarized
"set guifont=DejaVu\ Sans\ Mono\ 10
set antialias

" Quand je serais grand...
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>
