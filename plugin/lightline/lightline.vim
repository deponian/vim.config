let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.active = {
	\ 'left': [ [ 'mode', 'paste' ],
	\           [ 'gitbranch' ],
	\           [ 'filename' ] ],
	\ 'right': [ [ 'whitespace' ],
	\            [ 'percent_and_lineinfo' ],
	\            [ 'file_enc_and_format' ],
	\            [ 'filetype' ],
	\            [ 'readonly' ],
	\            [ 'modified' ] ] }

let g:lightline.inactive = {
	\ 'left': [ [ 'gitbranch' ],
	\           [ 'filename' ] ],
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
	\ 'whitespace': 'lightline#whitespace#check' }

let g:lightline.component_type = {
	\ 'whitespace': 'warning' }

let g:lightline.component_function = {
	\ 'mode': 'LightlineMode',
	\ 'filename': 'LightlineFilename',
	\ 'filetype': 'LightlineFiletype',
	\ 'file_enc_and_format': 'LightlineFileEncAndFormat',
	\ 'gitbranch': 'LightlineGitBranch' }

function! LightlineMode()
	let ftype = &filetype
	return ftype ==# 'NvimTree' ? 'nvimtree':
		\ winwidth(0) > 70 ? lightline#mode() : ''
endfunction

function! LightlineFilename()
	let ftype = &filetype
	let fugitive_name = ''

	if bufname('%') =~? '^fugitive:' && exists('*FugitiveReal')
		let fugitive_name = FugitiveReal(bufname('%'))
	endif

	if ftype ==# 'NvimTree'
		return ''
	elseif ftype ==# 'qf'
		return ''
	elseif fugitive_name !=# ''
		return fnamemodify(fugitive_name, ':.') . " [git]"
	elseif expand('%:F') !=# ''
		return expand('%:F')
	else
		return '[No Name]'
	endif
endfunction

function! LightlineFiletype()
	let ftype = &filetype
	return ftype ==# 'NvimTree' ? '' : ftype
endfunction

function! LightlineFileEncAndFormat()
	let enc = &fenc !=# "" ? &fenc : &enc
	return winwidth(0) > 70 ? enc . '[' . &ff . ']' : ''
endfunction

function! LightlineTabname(n) abort
	let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let fname = expand('#' . bufnr . ':t')
	return fname =~ 'NvimTree' ? 'nvimtree' : lightline#tab#filename(a:n)
endfunction

function! LightlineGitBranch() abort
	let ftype = &filetype
	if ftype ==# 'NvimTree'
		return ''
	elseif bufname('%') =~? '^fugitive:' && exists('*FugitiveReal')
		return FugitiveParse(bufname('%'))[0][0:6]
	else
		return FugitiveHead()
	endif
endfunction
