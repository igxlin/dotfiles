augroup filetypedetect
    autocmd BufRead,BufNewFile *.org setfiletype org
    autocmd BufRead,BufNewFile *nginx.conf setfiletype nginx
    autocmd BufRead,BufNewFile /etc/nginx*.conf setfiletype nginx
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup end
