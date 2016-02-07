" VIM Configuration - Rémi Saurel

set nocompatible

" Automatic vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-sensible' " Defaults everyone can agree on
Plug 'tpope/vim-sleuth' " Heuristically set buffer options
Plug 'tpope/vim-fugitive' " :Gblame is awesome <3
Plug 'flazz/vim-colorschemes' " Lots of colorschemes
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Command-line fuzzy finder
Plug 'junegunn/fzf.vim' " Vim bindings for fzf (:Files somehow replaces Ctrl-P)
Plug 'vim-scripts/dbext.vim' " Database access to many DBMS (especially Oracle, if sqlplus is installed)

call plug#end()

" Get correct colors under tmux
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

" Natural vertical movements
map  <up> gk
map  <down> gj
map j gj
map k gk

" Ctrl-P binding for fzf.vim
map <C-p> :Files<CR>

" Plugins leader key
let mapleader=","

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

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
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <F2> :call TrimWhiteSpace()<CR>

" Configuration dbext pour TPs de SGBD
let g:dbext_default_type = 'ORA'         "Les TP se font sur Oracle
let dbext_default_user = 'saurelre'   "Login
let dbext_default_passwd = 'saurelre'   "Mot de passe (SQL != mdp ensibm à priori)
let dbext_default_host = 'ensioracle1'   "À changer selon le serveur à utiliser
let dbext_default_srvname = 'ensioracle1'  "idem

