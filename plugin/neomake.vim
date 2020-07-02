" neomake configuration
"
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrw', 1000)
let g:neomake_virtualtext_prefix = '<<< '
let g:neomake_yaml_ansible_enabled_makers = ['ansiblelint', 'yamllint']

" Change python interpreter to match what is in shebang
call neomake#config#set('b:python.InitForJob', function('settings#neomake#set_argv_from_shebang'))

