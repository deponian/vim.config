" Zap trailing whitespace.
function! mappings#leader#zap() abort
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

" Set indentation settings
function! mappings#leader#setindent() abort
	let mode = input("Set mode [t|s][2-8]: ")
	if mode == ''
		redraw
		echom((&expandtab == 1 ? 'expandtab' : 'noexpandtab' ) .
			\ ' ts=' . &ts . ' sts=' . &sts . ' sw=' . &sw)
		return
	endif
	let whitespace = strpart(mode, 0, 1)
	let width = strpart(mode, 1, 1)

	if whitespace == 't'
		setlocal noexpandtab
	elseif whitespace == 's'
		setlocal expandtab
	else
		redraw
		echom('First character has to be "t" or "s"')
		return
	endif

	if width =~ '[2-8]'
		execute 'setlocal tabstop=' . width
		execute 'setlocal softtabstop=' . width
		execute 'setlocal shiftwidth=' . width
	else
		redraw
		echom('Width has to be between 2 and 8')
		return
	endif

	redraw
	if whitespace == 't'
		echom('noexpandtab ts=' . width . ' sts=' . width . ' sw=' . width)
	else
		echom('expandtab ts=' . width . ' sts=' . width . ' sw=' . width)
	endif
endfunction

" Retab spaced file, but only indentation
" thanks to DrAI: https://stackoverflow.com/questions/5144284/force-vi-vim-to-use-leading-tabs-only-on-retab/5144480#5144480
function! mappings#leader#retab()
	let saved_view = winsaveview()
	let l:spaces = repeat(' ', &tabstop)
	if &expandtab
		silent! execute '%substitute#^\%(\t\)\+#\=repeat("' . l:spaces . '", len(submatch(0)))#'
	else
		silent! execute '%substitute#^\%(' . l:spaces . '\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#'
	endif
	call winrestview(saved_view)
endfunction
