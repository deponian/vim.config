" Yaifa: Yet another indent finder, almost...
" Version: 2.1
" Author: Israel Chauca F. <israelchauca@gmail.com>

if exists('g:loaded_yaifa_auto') && !get(g:, 'yaifa_debug', 0)
  finish
endif
let g:loaded_yaifa_auto = 1

let s:script_dir = expand('<sfile>:p:h:h')

function! s:is_continued_line(previous, current, filetype) "{{{
  if a:filetype ==? 'vim'
    return a:current =~# '\m^\s*\\'
  "elseif ...
  " TODO: Consider other syntaxes for line continuation
  " https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(syntax)
  else
    return a:previous =~# '\m\\$'
  endif
endfunction "}}}

function! s:is_comment(line, filetype) "{{{
  if a:filetype ==# 'vim'
    return a:line =~# '\m^\s*"'
  "elseif ...
  " TODO: Consider other syntaxes for comments
  " https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(syntax)
  else
    return a:line =~# '\m^\s*\%(/\*\|\*\|#\|//\)'
  endif
endfunction "}}}

function! s:l2str(line) "{{{
  if a:line.tab
    let type = 'tab'
  elseif a:line.space && a:line.mixed
    let type = 'either'
  elseif a:line.space
    let type = 'space'
  elseif a:line.mixed
    let type = 'mixed'
  elseif a:line.crazy
    let type = 'crazy'
  else
    let type = 'empty'
  endif
  let line = substitute(a:line.line, '\m\t', '|-------', 'g')
  let line = substitute(line, '\m ', nr2char(183), 'g')
  return printf('[%s:%2s]%-5s:%s',
        \ a:line.linenr, a:line.length, type, line)
endfunction "}}}

function! yaifa#analyze_lines(lines, filetype, defaults) "{{{
  let times = []
  call add(times, reltime())
  let defaults = {'type': 'space', 'indent': 4, 'tabstop': 4,
        \ 'max_lines': 0}
  call extend(defaults, a:defaults, 'force')
  let previous = {'line': '', 'linenr': 0, 'indent': 'X', 'delta': '',
          \ 'tab': 0, 'space': 0, 'mixed': 0, 'crazy': 0,
          \ 'tabs': 0, 'spaces': 0, 'length': 0, 'skipped': 0}
  let lines = map(copy(a:lines), 'extend(deepcopy(previous), '
        \ . '{''line'': v:val, ''linenr'': v:key + 1, '
        \ . '''indent'': matchstr(v:val, ''\m^\s*'')}, ''force'')')
  let mixed = {}
  let space = {}
  let tab = 0
  let processed_count = 0
  let ignored_count = 0
  let hint_count = 0
  let max_lines = defaults.max_lines
  call add(times, reltime())
  while !empty(lines) && (max_lines == 0
        \ || (processed_count -ignored_count) < max_lines)
    let processed_count += 1
    let current = remove(lines, 0)
    let skip_msg = ''
    if s:is_continued_line(previous.line, current.line, a:filetype)
      let skip_msg = 'line continuation'
      " Use the properties of the "main" line since that's the one with the
      " correct indentation.
      let current_line = current.line
      let current = copy(previous)
      let current.line = current_line
      let previous = current
    elseif s:is_comment(current.line, a:filetype)
      let skip_msg = 'comment'
    endif
    if !empty(skip_msg)
      let ignored_count += 1
      continue
    endif
    let current.length =
          \ len(substitute(current.indent, '\t', repeat(' ', 4), 'g'))
    " Determine indentation type.
    if current.indent =~# '\m^ \+$'
      let current.space = 1
      let current.spaces = len(matchstr(current.indent, '\m^\zs *'))
      if current.spaces < 4
        " This line could also use mixed indentation.
        let current.mixed = 1
      endif
    elseif current.indent =~# '\m^\t\+ \+$'
      let current.mixed = 1
      let current.spaces = len(matchstr(current.indent, '\m^\t*\zs *'))
      let current.tabs = len(matchstr(current.indent, '\m^\t*'))
    elseif current.indent =~# '\m^\t\+$'
      let current.tab = 1
      let current.tabs = len(matchstr(current.indent, '\m^\t*'))
    elseif current.indent =~# '\m \t'
      let current.crazy = 1
    endif
    let current.delta = current.length - previous.length
    if empty(current.line) || current.line =~# '\m^\s*$'
      " Skip empty or blank lines
      let current.skipped = 1
    elseif previous.indent ==# current.indent
      " Skip lines without indentation change
    elseif current.crazy
      " Skip lines with crazy indentation
      let current.skipped = 1
    elseif (current.mixed && current.spaces >= 4)
      " Skip mixed lines with too many spaces, looks like crazy indentation
      let current.skipped = 1
            \ current.delta)
    elseif previous.skipped
      " Not enough context to analyze this line, just skip it.
    elseif (current.delta <= 1) || (current.delta > 4)
      " Ignore indent change too small or too big
    elseif (previous.length == 0 || previous.tab) && current.tab
      " Indent change hints at tabs
      " Increment tab count
      let tab += 1
      let hint_count += 1
    elseif (previous.length == 0 || previous.space) && current.space
          \ && !current.mixed
      " Indent change hints at spaces
      " Increment space count
      let space[current.delta] = get(space, current.delta, 0) + 1
      let hint_count += 1
    elseif (previous.mixed && previous.space || previous.length == 0)
          \ && current.space && current.mixed
      " Indent change hints at spaces or mixed
      " Increment space and mixed count
      let space[current.delta] = get(space, current.delta, 0) + 1
      let mixed[current.delta] = get(mixed, current.delta, 0) + 1
      let hint_count += 1
    elseif previous.tab && current.mixed && (previous.tabs == current.tabs)
      " Indent change hints at mixed
      " Increment mixed count
      let mixed[current.delta] = get(mixed, current.delta, 0) + 1
      let hint_count += 1
    elseif previous.mixed && current.tab
          \ && (previous.tabs == current.tabs - 1)
      " Indent change hints at mixed
      " Increment mixed count
      let mixed[current.delta] = get(mixed, current.delta, 0) + 1
      let hint_count += 1
    elseif previous.mixed && current.mixed && (previous.tabs == current.tabs)
      " Indent change hints at mixed
      " Increment mixed count
      let mixed[current.delta] = get(mixed, current.delta, 0) + 1
      let hint_count += 1
    else
      " Nothing to do here
    endif
    let previous = current
  endwhile
  let time = reltimestr(reltime(remove(times, -1)))
  let max_space = max(space)
  let max_mixed = max(mixed)
  let max_tab   = tab
  let result = {'type': '', 'indent': 0}
  if max_space * 1.1 >= max_mixed && max_space >= max_tab
    " Go with spaces
    let line_count = 0
    let indent = 0
    for i in range(4, 1, -1)
      if get(space, i, 0) > floor(line_count * 1.1)
        " Give preference to higher indentation
        let indent = i
        let line_count = space[i]
      endif
    endfor
    if indent == 0
      " No guess on size, return defaults
      let result.type = defaults.type
      let result.indent = defaults.indent
    else
      let result.type = 'space'
      let result.indent = indent
    endif
  elseif max_mixed > max_tab
    " Go with mixed
    let line_count = 0
    let indent = 0
    for i in range(4, 1, -1)
      if get(mixed, i, 0) > floor(line_count * 1.1)
        " Give preference to higher indentation
        let indent = i
        let line_count = mixed[i]
      endif
    endfor
    if indent == 0
      " No guess on size, return defaults
      let result.type = defaults.type
      let result.indent = defaults.indent
    else
      let result.type = 'mixed'
      let result.indent = indent
    endif
  else
    " Go with tabs
    let result.type = 'tab'
    let result.indent = defaults.tabstop
  endif
  let time = reltimestr(reltime(remove(times, -1)))
  return result
endfunction "}}}

function! yaifa#magic(bufnr) "{{{
  let lines = getline(1, 256)
  let default_shiftwidth =
        \ get(b:, 'yaifa_shiftwidth', get(g:, 'yaifa_shiftwidth', 4))
  let default_tabstop = get(b:, 'yaifa_tabstop', get(g:, 'yaifa_tabstop', 4))
  let default_expandtab =
        \ get(b:, 'yaifa_expandtab', get(g:, 'yaifa_expandtab', 1))
  if default_expandtab
    let default_type = 'space'
  elseif !default_shiftwidth || default_shiftwidth == default_tabstop
    let default_type = 'tab'
  else
    let default_type = 'mixed'
  endif
  let defaults = {}
  let defaults.max_lines = 256
  let defaults.type = default_type
  let defaults.indent = default_shiftwidth
  let defaults.tabstop = default_tabstop
  " Do the guess work
  let result = yaifa#analyze_lines(lines, &filetype, defaults)
  if result.type ==# 'tab'
    " Use tabs
    let expandtab = 0
    let shiftwidth = 0
    let softtabstop = 0
    let tabstop = default_tabstop
  elseif result.type ==# 'mixed'
    " Use tabs and spaces
    let expandtab = 0
    let shiftwidth = result.indent
    let softtabstop = result.indent
    let tabstop = 4
  else
    " Use spaces only
    let expandtab = 1
    let shiftwidth = result.indent
    let softtabstop = result.indent
    let tabstop = 4
  endif
  let template = 'setlocal %s tabstop=%s shiftwidth=%s softtabstop=%s'
  let set_cmd = printf(template, expandtab, tabstop, shiftwidth, softtabstop)
  if !exists('b:indent_options_set')
    for option in ['expandtab', 'shiftwidth', 'softtabstop', 'tabstop']
      call setbufvar(a:bufnr, printf('&%s', option), get(l:, option))
    endfor
    let b:indent_options_set = 1
    let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
          \ . ' | unlet! b:indent_options_set'
  endif
  return set_cmd
endfunction "}}}

