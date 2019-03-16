" VIM Configuration - Rémi Saurel

""" Compatibility
set nocompatible

""" General settings
:autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

au BufNewFile,BufRead *.log if getline(1) =~? '^Tarmac' | set filetype=tarmac_log | endif
au BufNewFile,BufRead *.trs set filetype=dstb_trs
au BufNewFile,BufRead *.sv set filetype=verilog

set nowrap " Don't wrap long lines
set cursorline " Display underline on the current line
set ignorecase " Ignore case on search patterns by default
set smartcase " Become case-sensitive on search patterns if a capital letter is entered
set hlsearch " Highlight search matches
set incsearch
set novisualbell " Disable visual bells
set noerrorbells " Disable error bells
set confirm " Enable dialog for unsaved buffers on exit
set hidden " Hide buffer when unloaded
set spelllang=en " English spellcheck
set clipboard=unnamed " Use system clipboard instead of internal register
set foldmethod=syntax
set backspace=indent,eol,start
set wildmode=longest,list " mimic bash completion behaviour

set colorcolumn=130
set updatetime=200

set list
set listchars=tab:>·,trail:·,extends:>,precedes:<,nbsp:×

" Y behave like D or C
nnoremap Y y$

nnoremap Q @q

" Natural vertical movements on wrapped lines
map  <up> gk
map  <down> gj
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = $HOME.'/.cache/vim/undodir'

  if !isdirectory(myUndoDir)
    call system('mkdir -p ' . myUndoDir)
  endif
  let &undodir = myUndoDir
  set undofile
endif

nnoremap <F10> :so $MYVIMRC<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc

""" Plugins

" Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --xdg' }
Plug 'junegunn/fzf.vim'
" {{{
nnoremap <C-p> :Files<CR>

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

" }}}
Plug 'airblade/vim-gitgutter' " Git status, in the gutter.
Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3

Plug 'tpope/vim-sleuth' " Heuristically set indent type and size
Plug 'tpope/vim-eunuch' " :SudoWrite et al.
Plug 'morhetz/gruvbox' " One colorscheme to rule them all
Plug 'itchyny/lightline.vim' " Nicer status bar, so light you won't notice it's here
Plug 'shinchu/lightline-gruvbox.vim' " Seems self-explanatory...
Plug 'wincent/terminus' " Better integration with terminal emulators and multiplexers
Plug 'mhinz/vim-startify' " Nice start page (with deep quotes regarding life and stuff)

call plug#end()

" Plugins variables
let mapleader=","

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

set background=dark

silent! colorscheme gruvbox

"Same as */# but don't move to next/previous occurence
nmap <F5> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
