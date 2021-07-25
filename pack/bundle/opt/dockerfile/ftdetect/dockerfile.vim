" vint: -ProhibitAutocmdWithNoGroup

" Dockerfile
autocmd BufRead,BufNewFile [Dd]ockerfile set ft=dockerfile
autocmd BufRead,BufNewFile [Dd]ockerfile* set ft=dockerfile
autocmd BufRead,BufNewFile *.[Dd]ockerfile set ft=dockerfile
autocmd BufRead,BufNewFile *.dock set ft=dockerfile
autocmd BufRead,BufNewFile [Dd]ockerfile.vim set ft=vim

" Containerfile
autocmd BufRead,BufNewFile [Cc]ontainerfile set ft=dockerfile
autocmd BufRead,BufNewFile [Cc]ontainerfile* set ft=dockerfile
autocmd BufRead,BufNewFile *.[Cc]ontainerfile set ft=dockerfile
