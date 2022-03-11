" VIM Configuration - Rémi Saurel

" {{{ Settings
set nowrap " Don't wrap long lines
set ignorecase " Ignore case on search patterns by default
set smartcase " Become case-sensitive on search patterns if a capital letter is entered
set hlsearch " Highlight search matches
set belloff=all " No bells ffs
set confirm " Enable dialog for unsaved buffers on exit
set hidden " Hide buffer when unloaded
set spelllang=en " English spellcheck
set clipboard=unnamed " Use system clipboard instead of internal register
set foldmethod=syntax
set wildmode=longest,list " mimic bash completion behaviour

set colorcolumn=130
set updatetime=200

" Display non printable characters/trailing spaces
set list
set listchars=tab:>·,trail:·,extends:>,precedes:<,nbsp:×

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc

" True-color support
if !has("nvim")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
" }}}

" {{{ Mappings
" Y behave like D or C
nnoremap Y y$

" Quicker way to apply macros
nnoremap Q @q

" Natural vertical movements on wrapped lines
nnoremap <up> gk
nnoremap <down> gj
nnoremap j gj
nnoremap k gk

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Quicker way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Disable command I never intend to type
nnoremap q: <nop>

"* but don't move to next occurence
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" make ; always "find" forward and , backward
nnoremap <expr> ; getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'

nnoremap <F9> :edit $MYVIMRC<CR>
nnoremap <F10> :source $MYVIMRC<CR>
" }}}

function! Osc52Yank()
    let buffer=system('base64 -w0', @0)
    let buffer=substitute(buffer, "\n$", "", "")
    let buffer='\e]52;c;'.buffer.'\x07'
    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape("/dev/tty")
endfunction

" {{{ Auto-commands
augroup Commands
  autocmd!

  " Highlight current word
  autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

  " Quickfix defaults to full-width
  autocmd FileType qf wincmd J

  autocmd FileType gitcommit setlocal colorcolumn=72

  " Only print cursor line on active window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  autocmd VimResized * wincmd =

  autocmd BufNewFile,BufRead *.sv set filetype=verilog

  " Emit OSC 52 escape code to set system clipboard on yank
  autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
augroup END
" }}}

" {{{ Persistent undo history
if has('nvim')
  set undofile
endif
" }}}

" {{{ Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}

" {{{ Plugins
call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --xdg' }
Plug 'junegunn/fzf.vim'
" {{{
" Use rg to respect .ignore files
nnoremap <C-p> :Files<CR>
" }}}
Plug 'jesseleite/vim-agriculture' " ripgrep wrapper with support for options (e.g. word boundaries)
" {{{
let g:agriculture#rg_options = '--word-regexp'

nmap K <Plug>RgRawWordUnderCursor<CR>
vmap K <Plug>RgRawVisualSelection<CR>
" }}}
Plug 'airblade/vim-gitgutter' " Git status, in the gutter.
Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3

Plug 'tpope/vim-sleuth' " Heuristically set indent type and size
Plug 'tpope/vim-eunuch' " :SudoWrite et al.
Plug 'morhetz/gruvbox' " One colorscheme to rule them all
Plug 'wincent/terminus' " Better integration with terminal emulators and multiplexers
Plug 'mhinz/vim-startify' " Nice start page (with deep quotes regarding life and stuff)
Plug 'sheerun/vim-polyglot'

call plug#end()

" Plugins variables
let mapleader=","

set background=dark

silent! colorscheme gruvbox
" }}}

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
