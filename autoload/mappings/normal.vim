" Show different version of current file
function! mappings#normal#git_show_file_versions() abort
	let ftype = &filetype
	if ftype ==# 'NvimTree'
		echom('Choose not nvimtree window')
	else
		augroup filetype_qf
			autocmd!
			autocmd Filetype qf nnoremap <silent> <buffer> <CR> <CR>:copen<CR>
		augroup END
		vsplit
		execute '0Gclog'
		copen 7
	endif
endfunction

" Toggle diff mode for all windows
function! mappings#normal#toggle_diff() abort
	execute 'NvimTreeClose'
	cclose
	if &diff
		windo diffoff
	else
		windo diffthis
	endif
endfunction
