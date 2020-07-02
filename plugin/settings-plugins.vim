" Ansible
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'a'
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1

" Python
let g:python_recommended_style = 0

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 32
let NERDTreeStatusline = -1
let NERDTreeCustomOpenArgs = {
			\ 'file': { 'reuse': 'all',
					\   'where': 'p',
					\   'keepopen': 1,
					\   'stay': 1 },
			\ 'dir': {} }

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Semshi
let g:semshi#error_sign = v:false
