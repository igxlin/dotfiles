augroup filetypedetect
    autocm BufRead,BufNewFile *.org setfiletype org
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup end
