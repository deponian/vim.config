function! s:whitespace_refresh()
  if get(b:, 'whitespace_changedtick', 0) == b:changedtick
    return
  endif
  unlet! b:whitespace_changedtick
  call lightline#update()
  let b:whitespace_changedtick = b:changedtick
endfunction

augroup whitespace
  autocmd!
  autocmd CursorHold,BufWritePost * call s:whitespace_refresh()
augroup END
