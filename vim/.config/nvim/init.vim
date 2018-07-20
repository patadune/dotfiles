" VIM Configuration - Rémi Saurel

""" Compatibility

" Nvim/Vim specific configuration
if has('nvim')
  " Escape to get out of the terminal mode
  tnoremap <Esc> <C-\><C-n>
else
  set nocompatible
end

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

set colorcolumn=130

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

" Put plugins and dictionaries in this dir (also on Windows)
" TODO : this is not portable between vim and neovim
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

nnoremap <F10> :so $MYVIMRC<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o


""" Plugins

" Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter' " Git status, in the gutter.
Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file finder
Plug 'mileszs/ack.vim' " Wrapper for The Silver Searcher

Plug 'tpope/vim-sleuth' " Heuristically set indent type and size
Plug 'tpope/vim-eunuch' " :SudoWrite et al.
Plug 'itchyny/lightline.vim' " Nicer status bar, so light you won't notice it's here
Plug 'morhetz/gruvbox' " One colorscheme to rule them all
Plug 'wincent/terminus' " Better integration with terminal emulators and multiplexers
Plug 'mhinz/vim-startify' " Nice start page (with deep quotes regarding life and stuff)

call plug#end()

" Plugins variables
set runtimepath^=~/.vim/bundle/ctrlp.vim
let mapleader=","

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

set background=dark

silent! colorscheme gruvbox

"Same as */# but don't move to next/previous occurence
nmap <F5> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
