autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.yml,*/templates/*.tpl,*/templates/NOTES.txt,*.gotmpl,helmfile.yaml set ft=yaml.helm

" Use {{/* */}} as comments
autocmd FileType helm setlocal commentstring={{/*\ %s\ */}}
