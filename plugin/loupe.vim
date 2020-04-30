" Loupe configuration

" Stark highlighting is enough to see the current match; don't need the
" centering, which can be annoying.
let g:LoupeCenterResults=0

" And it turns out that if we're going to turn off the centering, we don't even
" need the mappings; see: https://github.com/wincent/loupe/pull/15
map <Nop><F1> <Plug>(LoupeN)
nmap <Nop><F2> <Plug>(Loupen)
