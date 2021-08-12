" fzf configuration

" Default fzf layout
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.9 } }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--color=always --pretty=format:"%C(#5398dd)%h %C(#00d7af)%cd%C(reset) %C(#969696)::%C(reset)%C(#f2684b)%d %C(#d9d9d9)%s" --date=format:"%F %R"'

" ctrl-m is 'Enter' key
let g:fzf_action = {
	\ 'ctrl-m': 'vsplit',
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

function! RipgrepFzf(fullscreen, fixed, path = ".", query = "")
	if a:fixed
		let command_fmt = 'rg --glob "!.git/" --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --fixed-strings -- %s %s || true'
	else
		let command_fmt = 'rg --glob "!.git/" --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case -- %s %s || true'
	endif
	let initial_command = printf(command_fmt, shellescape(a:query), shellescape(a:path))
	let reload_command = printf(command_fmt, '{q}', shellescape(a:path))
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'right:70%'), a:fullscreen)
endfunction

" [R]ip[G]rep
command! -nargs=* -bang RG call RipgrepFzf(<bang>0, v:true, <f-args>)
" [R]ip[G]rep[R]egex
command! -nargs=* -bang RGR call RipgrepFzf(<bang>0, v:false, <f-args>)
