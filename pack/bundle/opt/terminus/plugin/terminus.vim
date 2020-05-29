" Copyright 2015-present Greg Hurrell. All rights reserved.
" Licensed under the terms of the BSD 2-clause license.
" Modified By: Rufus Deponian <deponian@pm.me>

" Provide users with means to prevent loading, as recommended in `:h
" write-plugin`.
if exists('g:TerminusLoaded') || &compatible || v:version < 700
  finish
endif
let g:TerminusLoaded=1

" Temporarily set 'cpoptions' to Vim default as per `:h use-cpo-save`.
let s:cpoptions=&cpoptions
set cpoptions&vim

let s:konsole=
      \ exists('$KONSOLE_DBUS_SESSION') ||
      \ exists('$KONSOLE_PROFILE_NAME')
let s:iterm=
      \ exists('$ITERM_PROFILE') ||
      \ exists('$ITERM_SESSION_ID') ||
      \ exists('g:TerminusAssumeITerm') ||
      \ filereadable(expand('~/.vim/.assume-iterm'))
let s:iterm2=
      \ s:iterm &&
      \ exists('$TERM_PROGRAM_VERSION') &&
      \ match($TERM_PROGRAM_VERSION, '\v^[2-9]\.') == 0
let s:screenish=&term =~# 'screen\|tmux'
let s:tmux=exists('$TMUX')
let s:xterm=&term =~# "xterm.*"

" Change shape of cursor in insert and replace mode
let s:shape=get(g:, 'TerminusCursorShape', 1)
if s:shape
  if has('nvim')
    set guicursor=n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20
    " Restore your cursor shape after exiting neovim
    " if you don't use standard block shape cursor
    augroup cursorshape
      autocmd!
      autocmd VimLeave * set guicursor=a:ver25-blinkon1000-blinkoff1000
    augroup END
  else
    if s:iterm2 || s:iterm || s:konsole
      let s:insert_shape=1
      let s:replace_shape=2
      let s:normal_shape=0
      let s:leave_shape=1
    else " i.e. VTE-based terminals
      let s:insert_shape=6
      let s:replace_shape=4
      let s:normal_shape=2
      let s:leave_shape=5
    endif
    if s:iterm2
      let s:start_insert="\<Esc>]1337;CursorShape=" . s:insert_shape . "\x7"
      let s:start_replace="\<Esc>]1337;CursorShape=" . s:replace_shape . "\x7"
      let s:end_insert="\<Esc>]1337;CursorShape=" . s:normal_shape . "\x7"
      let s:leave="\<Esc>]1337;CursorShape=" . s:leave_shape . "\x7"
    elseif s:iterm || s:konsole
      let s:start_insert="\<Esc>]50;CursorShape=" . s:insert_shape . "\x7"
      let s:start_replace="\<Esc>]50;CursorShape=" . s:replace_shape . "\x7"
      let s:end_insert="\<Esc>]50;CursorShape=" . s:normal_shape . "\x7"
      let s:leave="\<Esc>]50;CursorShape=" . s:leave_shape . "\x7"
    else
      let s:start_insert="\<Esc>[" . s:insert_shape . ' q'
      let s:start_replace="\<Esc>[" . s:replace_shape . ' q'
      let s:end_insert="\<Esc>[" . s:normal_shape . ' q'
      let s:leave="\<Esc>[" . s:leave_shape . ' q'
    endif

    if s:tmux
      let s:start_insert=terminus#private#wrap(s:start_insert)
      let s:start_replace=terminus#private#wrap(s:start_replace)
      let s:end_insert=terminus#private#wrap(s:end_insert)
      let s:leave=terminus#private#wrap(s:leave)
    endif

    let &t_SI=s:start_insert
    if v:version > 704 || v:version == 704 && has('patch687')
      let &t_SR=s:start_replace
    end
    let &t_EI=s:end_insert

    " Restore your cursor shape after exiting neovim
    " if you don't use standard block shape cursor
    augroup cursorshape
      autocmd!
      autocmd VimLeave * let &t_me=s:leave
    augroup END

  endif
endif

let s:mouse=get(g:, 'TerminusMouse', 1)
if s:mouse
  if has('mouse')
    set mouse=a
    if s:screenish || s:xterm
      if !has('nvim')
        if has('mouse_sgr')
          set ttymouse=sgr
        else
          set ttymouse=xterm2
        endif
      endif
    endif
  endif
endif

" old way to paste without indentation
" new way in terminus plugin now
" function! XTermPasteBegin()
"     set pastetoggle=<Esc>[201~
"     set paste
"     return ""
" endfunction
" let &t_SI .= "\<Esc>[?2004h"
" let &t_EI .= "\<Esc>[?2004l"
" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" function! Paste(ret) abort
"   set paste
"   return a:ret
" endfunction

" let s:paste=get(g:, 'TerminusBracketedPaste', 1)
" if s:paste
"   " Make use of Xterm "bracketed paste mode". See:
"   "  - http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
"   "  - http://stackoverflow.com/questions/5585129
"   if s:screenish || s:xterm
"     " Enable bracketed paste mode on entering Vim.
"     let &t_ti.="\e[?2004h"

"     " Disable bracketed paste mode on leaving Vim.
"     let &t_te="\e[?2004l" . &t_te

"     set pastetoggle=<f23>
"     execute "set <f22>=\<Esc>[200~"
"     execute "set <f23>=\<Esc>[201~"
"     inoremap <expr> <f22> Paste('')
"     nnoremap <expr> <f22> Paste('i')
"     vnoremap <expr> <f22> Paste('c')
"     cnoremap <f22> <nop>
"     cnoremap <f23> <nop>
"   endif
" endif

" Restore 'cpoptions' to its former value.
let &cpoptions=s:cpoptions
unlet s:cpoptions
