" Get a list with executable and args for a buffer.
" a:0: bufnr, defaults to current.
" Returns an empty list if not shebang was found.
function! s:get_exe_args_from_shebang(...) abort
	let bufnr = a:0 ? +a:1 : bufnr('%')
	let line1 = get(getbufline(bufnr, 1), 0)
	if line1[0:1] ==# '#!'
		let shebang = substitute(line1[2:], '\v^\s+|\s+$', '', '')
		return split(shebang)
	endif
	return []
endfunction

" Helper (dict) function to set exe/args for a maker, based on the job
" buffer's shebang.
" Can be uses as a setting, e.g.:
" call neomake#config#set('b:python.InitForJob', function('neomake#utils#set_argv_from_shebang'))
function! settings#neomake#set_argv_from_shebang(jobinfo) dict abort
	let bufnr = get(a:jobinfo, 'bufnr', '')
	if bufnr isnot# ''
		let exe_args = s:get_exe_args_from_shebang(bufnr)
		if !empty(exe_args)
			let self.exe = exe_args[0]
			let self.args = exe_args[1:] + self.args
		endif
	endif
endfunction
