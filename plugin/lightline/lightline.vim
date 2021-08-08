let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.active = {
	\ 'left': [ [ 'mode', 'paste' ],
	\           [ 'readonly' ],
	\           [ 'modified' ],
	\           [ 'gitbranch' ],
	\           [ 'filename' ] ],
	\ 'right': [ [ 'whitespace', 'neomake_info', 'neomake_warning', 'neomake_error' ],
	\            [ 'percent_and_lineinfo' ],
	\            [ 'file_enc_and_format' ],
	\            [ 'filetype' ] ] }

let g:lightline.inactive = {
	\ 'left': [ [ 'filename' ] ],
	\ 'right': [ [ 'lineinfo' ],
	\            [ 'percent' ] ] }

let g:lightline.tabline = {
	\ 'left': [ [ 'tabs' ] ],
	\ 'right': [] }

let g:lightline.tab = {
	\ 'active': [ 'filename' ],
	\ 'inactive': [ 'filename' ] }

let g:lightline.tab_component_function = {
	\ 'filename': 'LightlineTabname' }

let g:lightline.component = {
	\ 'percent_and_lineinfo': '%p%% %l/%L %-2v',
	\ 'modified': '%{&modified?"+":""}',
	\ 'readonly': '%{&readonly?"⊝":""}' }

let g:lightline.component_expand = {
	\ 'whitespace': 'lightline#whitespace#check',
	\ 'neomake_error': 'lightline#neomake#error',
	\ 'neomake_warning': 'lightline#neomake#warning',
	\ 'neomake_info': 'lightline#neomake#info' }

let g:lightline.component_type = {
	\ 'whitespace': 'warning',
	\ 'neomake_error': 'error',
	\ 'neomake_warning': 'warning',
	\ 'neomake_info': 'info' }

let g:lightline.component_function = {
	\ 'mode': 'LightlineMode',
	\ 'filename': 'LightlineFilename',
	\ 'filetype': 'LightlineFiletype',
	\ 'file_enc_and_format': 'LightlineFileEncAndFormat',
	\ 'gitbranch': 'gitbranch#name' }

function! LightlineMode()
	let fname = expand('%:t')
	return fname =~ 'NERD_tree' ? 'NERDTree':
		\ winwidth(0) > 70 ? lightline#mode() : ''
endfunction

function! LightlineFilename()
	let ftype = &filetype
	return ftype ==# 'nerdtree' ? '' :
		\ expand('%:F') !=# '' ? expand('%:F') : '[No Name]'
endfunction

function! LightlineFiletype()
	let ftype = &filetype
	return ftype ==# 'nerdtree' ? '' : ftype
endfunction

function! LightlineFileEncAndFormat()
	let enc = &fenc !=# "" ? &fenc : &enc
	return winwidth(0) > 70 ? enc . '[' . &ff . ']' : ''
endfunction

function! LightlineTabname(n) abort
	let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let fname = expand('#' . bufnr . ':t')
	return fname =~ 'NERD_tree' ? 'NERDTree' : lightline#tab#filename(a:n)
endfunction
