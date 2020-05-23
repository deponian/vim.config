" vim-airline settings

" load only necessary extensions
if has('nvim')
	let g:airline_extensions = ['neomake', 'netrw', 'whitespace', 'wordcount']
else
	let g:airline_extensions = ['netrw', 'whitespace', 'wordcount']
endif

" statusline setting
let g:airline_highlighting_cache = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.branch = ''
let g:airline_section_z = '%2p%% %#__accent_bold#%{g:airline_symbols.linenr}%2l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# %2v'
