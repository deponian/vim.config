" Zap trailing whitespace.
function! mappings#leader#zap() abort
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
