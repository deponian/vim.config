" Copyright 2015-present Greg Hurrell. All rights reserved.
" Licensed under the terms of the BSD 2-clause license.
" Modified By: Rufus Deponian <deponian@pm.me>

let s:nomodeline=v:version > 703 || v:version == 703 && has('patch438')

function! s:escape(string) abort
  " Double each <Esc>.
  return substitute(a:string, "\<Esc>", "\<Esc>\<Esc>", 'g')
endfunction

function! terminus#private#wrap(string) abort
  if strlen(a:string) == 0
    return ''
  end

  let l:tmux_begin="\<Esc>Ptmux;"
  let l:tmux_end="\<Esc>\\"

  return l:tmux_begin . s:escape(a:string) . l:tmux_end
endfunction

