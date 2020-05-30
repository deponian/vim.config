let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.active = {
	\ 'left': [ [ 'mode', 'paste' ],
	\           [ 'readonly' ],
	\           [ 'modified' ],
	\           [ 'filename' ] ],
	\ 'right': [ [ 'whitespace', 'neomake_info', 'neomake_warning', 'neomake_error' ],
	\            [ 'percent_and_lineinfo' ],
	\            [ 'file_encoding_and_format' ],
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

let g:lightline.component = {
	\ 'filename': '%F',
	\ 'file_encoding_and_format': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
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
