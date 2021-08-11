" Ansible
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'a'
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1

" Python
let g:python_recommended_style = 0

" NERDTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize = 48
let g:NERDTreeStatusline = -1
let g:NERDTreeCustomOpenArgs = {
			\ 'file': { 'reuse': 'all',
					\   'where': 'p',
					\   'keepopen': 1,
					\   'stay': 1 },
			\ 'dir': {} }

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" IndentLine
" Disabled by default. Enabled only for some filetypes
let g:indentLine_char = '¦'
let g:indentLine_color_term = 237
let g:indentLine_color_gui = '#2c3036'

let g:indentLine_enabled = 0
augroup IndenLineFiletypes
	autocmd!
	autocmd BufReadPre *.yml,*.yaml let b:indentLine_enabled = 1
augroup END

" GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_diff_base = '@'
