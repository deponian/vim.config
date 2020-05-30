function! lightline#neomake#error() abort
  if !exists(":Neomake")
    return ''
  endif
  let num = neomake#statusline#LoclistCounts()['E']
  return num == 0 ? '' : printf('E:%d', num)
endfunction

function! lightline#neomake#warning() abort
  if !exists(":Neomake")
    return ''
  endif
  let num = neomake#statusline#LoclistCounts()['W']
  return num == 0 ? '' : printf('W:%d', num)
endfunction

function! lightline#neomake#info() abort
  if !exists(":Neomake")
    return ''
  endif
  let num = neomake#statusline#LoclistCounts()['I']
  return num == 0 ? '' : printf('I:%d', num)
endfunction
