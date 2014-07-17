syn  on
set  syntax =on
filetype  indent plugin on
set  nu
set  showmatch
set  tabstop =4
set  shiftwidth =4
set  softtabstop =4
set  expandtab
set  incsearch
set  ignorecase
set  smartcase
set  wildmenu    "affiche le menu
set  wildmode =list:longest,list:full    "affiche toutes les possibilités
set  wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz    "ignorer certains types de fichiers pour la complétion des includes
set  cursorline
nmap <F5> :!gnatmake -gnato -gnatv %:p:r<Return>
nmap <F6> :!%:p:r<Return>
"imap  <C-Space> <C-X><C-O>
let g:ada_standard_types=1  " Colorie les types Ada.
let g:ada_line_errors=1  " Affiche les lignes trop longues
let g:ada_folding='g'  " Si vous voulez réire les fonctions.
"nmap <F4> :call ada#Create_Tags('dir')<CR>
