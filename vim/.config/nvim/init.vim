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
nnoremap  <up> gk
nnoremap  <down> gj
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

"Same as */# but don't move to next/previous occurence
nnoremap <F5> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

nnoremap <F9> :edit $MYVIMRC<CR>
nnoremap <F10> :source $MYVIMRC<CR>
" }}}

" {{{ Auto-commands
augroup Commands
  autocmd!

  " Highlight current word
  autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

  " Quick defaults to full-width
  autocmd FileType qf wincmd J

  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  autocmd BufNewFile,BufRead *.sv set filetype=verilog
augroup END
" }}}

" {{{ Persistent undo history
if has('persistent_undo')
  let myUndoDir = $HOME.'/.cache/vim/undodir'

  if !isdirectory(myUndoDir)
    call system('mkdir -p ' . myUndoDir)
  endif
  let &undodir = myUndoDir
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
Plug 'airblade/vim-rooter' " Stay on project root
Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3

Plug 'tpope/vim-sleuth' " Heuristically set indent type and size
Plug 'tpope/vim-eunuch' " :SudoWrite et al.
Plug 'morhetz/gruvbox' " One colorscheme to rule them all
Plug 'itchyny/lightline.vim' " Nicer status bar, so light you won't notice it's here
Plug 'shinchu/lightline-gruvbox.vim' " Seems self-explanatory...
Plug 'wincent/terminus' " Better integration with terminal emulators and multiplexers
Plug 'mhinz/vim-startify' " Nice start page (with deep quotes regarding life and stuff)
Plug 'vim-python/python-syntax'
" {{{
let g:python_highlight_all = 1
" }}}

call plug#end()

" Plugins variables
let mapleader=","

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

set background=dark

silent! colorscheme gruvbox
" }}}

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
