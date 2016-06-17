" VIM Configuration - Rémi Saurel

""" Compatibility

" Get correct colors under tmux
if exists('$TMUX')
  set term=screen-256color
endif

" Nvim/Vim specific configuration
if has('nvim')
  " Escape to get out of the terminal mode
  tnoremap <Esc> <C-\><C-n>
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set t_Co=256
  set nocompatible

  " Insert mode cursor under xterm
  if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
  endif
end

""" General settings

set mouse=a " Enable mouse support in terminal for every mode
set number " Display line numbers
set wrap " Wrap long lines
set cursorline " Display underline on the current line
set ignorecase " Ignore case on search patterns by default
set smartcase " Become case-sensitive on search patterns if a capital letter is entered
set hlsearch " Highlight search matches
set novisualbell " Disable visual bells
set noerrorbells " Disable error bells
set confirm " Enable dialog for unsaved buffers on exit
set hidden " Hide buffer when unloaded
set spelllang=fr " French spellcheck
set clipboard+=unnamed " Use system clipboard instead of internal register

" Natural vertical movements on wrapped lines
map  <up> gk
map  <down> gj
map j gj
map k gk

" Highlight trailing spaces/tabs
set list listchars=tab:\ \ ,trail:·

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

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

nnoremap <F2> :call TrimWhiteSpace()<CR>
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

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-sleuth' " Heuristically set buffer options
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3
Plug 'flazz/vim-colorschemes' " Lots of colorschemes
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file finder
Plug 'rking/ag.vim'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'

call plug#end()

" Plugins variables
set runtimepath^=~/.vim/bundle/ctrlp.vim
let mapleader=","

if exists('g:FakeGvim')
  let g:lightline = {
        \'colorscheme': 'gruvbox',
        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \}
endif

set background=dark

silent! colorscheme gruvbox
