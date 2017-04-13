"coloration syntaxique pour fichier du projet GL
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.deca       setfiletype java
    au! BufRead,BufNewFile *.decah      setfiletype java
    au! BufRead,BufNewFile *.ass        setfiletype asm
augroup END
