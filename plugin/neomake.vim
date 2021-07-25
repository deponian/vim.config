" Neomake configuration
"
" Full config: when writing or reading a buffer, and on changes in insert and normal mode (after 1000ms; no delay when writing).
call neomake#configure#automake('nrw', 1000)
let g:neomake_virtualtext_prefix = '<<< '

" Ansible
let g:neomake_yaml_ansible_enabled_makers = ['ansiblelint', 'yamllint']
let g:neomake_ansible_ansiblelint_errorformat = '%f:%l: %m'

" Python
" Change python interpreter to match what is in shebang
call neomake#config#set('b:python.InitForJob', function('settings#neomake#set_argv_from_shebang'))

