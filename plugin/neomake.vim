" neomake configuration
"
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrw', 1000)
let g:neomake_virtualtext_prefix = '<<< '

let g:neomake_yaml_ansible_enabled_makers = ['ansiblelint', 'yamllint']

function! Selectpython()
	let l:exename = "python"
	if !empty(matchstr(getline(1), "^#!"))
		let l:exename = matchstr(getline(1), "python[23]*")
	endif
	let g:neomake_python_python_maker = neomake#makers#ft#python#python()
	let g:neomake_python_python_maker.exe = l:exename . " -m py_compile"

	let g:neomake_python_pylint_maker = neomake#makers#ft#python#pylint()
	let g:neomake_python_pylint_maker.exe = l:exename . " -m pylint"

	let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
	let g:neomake_python_flake8_maker.exe = l:exename . " -m flake8"
endfunction

augroup CustomizePythonMaker
au!
au BufReadPost *.py call Selectpython()
augroup END
