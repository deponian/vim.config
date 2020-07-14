" fzf configuration
"

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--color=always --pretty=format:"%C(#5398dd)%h %C(#00d7af)%cd%C(reset) %C(#969696)::%C(reset)%C(#f2684b)%d %C(#d9d9d9)%s" --date=format:"%F %R"'

" ctrl-m is 'Enter' key
let g:fzf_action = {
	\ 'ctrl-m': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit' }

if has('nvim') && !exists('g:fzf_layout')
	autocmd! FileType fzf
	autocmd FileType fzf set laststatus=0 noruler
		\| autocmd BufLeave <buffer> set laststatus=2 ruler
endif

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
	\ { 'fg':    ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }

function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case -- %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'right:70%'), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
