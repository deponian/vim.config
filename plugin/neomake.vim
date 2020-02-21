" neomake configuration
"
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)
let g:neomake_virtualtext_prefix = '<<< '

