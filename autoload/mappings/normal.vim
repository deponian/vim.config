" Show different version of current file
function! mappings#normal#git_show_file_versions() abort
	let ftype = &filetype
	if ftype ==# 'nerdtree'
		echom('Choose not nerdtree window')
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
	execute 'NERDTreeClose'
	cclose
	if &diff
		windo diffoff
	else
		windo diffthis
	endif
endfunction

" Toggle diff mode for all windows
function! mappings#normal#nerdtree_open_or_focus() abort
	if g:NERDTree.IsOpen()
		let ftype = &filetype
		if ftype ==# 'nerdtree'
			execute 'NERDTreeToggle'
		else
			execute 'NERDTreeFocus'
		endif
	else
		execute 'NERDTreeToggle'
		execute 'silent NERDTreeMirror'
	endif
endfunction
