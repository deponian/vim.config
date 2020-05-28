" Licensed under the terms of the BSD 2-clause license.
" Copyright 2015-present Greg Hurrell. All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
"
" 1. Redistributions of source code must retain the above copyright notice,
"    this list of conditions and the following disclaimer.
"
" 2. Redistributions in binary form must reproduce the above copyright notice,
"    this list of conditions and the following disclaimer in the documentation
"    and/or other materials provided with the distribution.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
" IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
" ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
" LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
" CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
" SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
" INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
" CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
" ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
" POSSIBILITY OF SUCH DAMAGE.
"
" Modified By: Rufus Deponian <deponian@pm.me>
"

if exists('g:LoupeLoaded') || &compatible || v:version < 700
  finish
endif
let g:LoupeLoaded=1

" Temporarily set 'cpoptions' to Vim default as per `:h use-cpo-save`.
let s:cpoptions=&cpoptions
set cpoptions&vim

nnoremap <silent> <Plug>(LoupeClearHighlight)
      \ :nohlsearch<bar>
      \ call loupe#private#clear_highlight()<CR>

function! s:Nohlsearch(command)
  if getcmdtype() == ':' && getcmdpos() == len(a:command) + 1
    call loupe#private#clear_highlight()
    return a:command
  else
    return a:command
  endif
endfunction

" Make `:nohlsearch` behave like <Plug>(LoupeClearHighlight).
cnoreabbrev <expr> noh <SID>Nohlsearch('noh')
cnoreabbrev <expr> nohl <SID>Nohlsearch('nohl')
cnoreabbrev <expr> nohls <SID>Nohlsearch('nohls')
cnoreabbrev <expr> nohlse <SID>Nohlsearch('nohlse')
cnoreabbrev <expr> nohlsea <SID>Nohlsearch('nohlsea')
cnoreabbrev <expr> nohlsear <SID>Nohlsearch('nohlsear')
cnoreabbrev <expr> nohlsearc <SID>Nohlsearch('nohlsearc')
cnoreabbrev <expr> nohlsearch <SID>Nohlsearch('nohlsearch')

nnoremap <expr> / loupe#private#prepare_highlight('/' . '\v')
nnoremap <expr> ? loupe#private#prepare_highlight('?' . '\v')
xnoremap <expr> / loupe#private#prepare_highlight('/' . '\v')
xnoremap <expr> ? loupe#private#prepare_highlight('?' . '\v')

" Any single-byte character may be used as a delimiter except \, ", | and
" alphanumerics. See `:h E146`.
cnoremap <expr> ! loupe#private#very_magic_slash('!')
cnoremap <expr> # loupe#private#very_magic_slash('#')
cnoremap <expr> $ loupe#private#very_magic_slash('$')
cnoremap <expr> % loupe#private#very_magic_slash('%')
cnoremap <expr> & loupe#private#very_magic_slash('&')
cnoremap <expr> ' loupe#private#very_magic_slash("'")
cnoremap <expr> ( loupe#private#very_magic_slash('(')
cnoremap <expr> ) loupe#private#very_magic_slash(')')
cnoremap <expr> * loupe#private#very_magic_slash('*')
cnoremap <expr> + loupe#private#very_magic_slash('+')
cnoremap <expr> , loupe#private#very_magic_slash(',')
cnoremap <expr> - loupe#private#very_magic_slash('-')
cnoremap <expr> . loupe#private#very_magic_slash('.')
cnoremap <expr> / loupe#private#very_magic_slash('/')
cnoremap <expr> : loupe#private#very_magic_slash(':')
cnoremap <expr> ; loupe#private#very_magic_slash(';')
cnoremap <expr> < loupe#private#very_magic_slash('<')
cnoremap <expr> = loupe#private#very_magic_slash('=')
cnoremap <expr> > loupe#private#very_magic_slash('>')
cnoremap <expr> ? loupe#private#very_magic_slash('?')
cnoremap <expr> @ loupe#private#very_magic_slash('@')
cnoremap <expr> [ loupe#private#very_magic_slash('[')
cnoremap <expr> ] loupe#private#very_magic_slash(']')
cnoremap <expr> ^ loupe#private#very_magic_slash('^')
cnoremap <expr> _ loupe#private#very_magic_slash('_')
cnoremap <expr> ` loupe#private#very_magic_slash('`')
cnoremap <expr> { loupe#private#very_magic_slash('{')
cnoremap <expr> } loupe#private#very_magic_slash('}')
cnoremap <expr> ~ loupe#private#very_magic_slash('~')

function! s:map(keys, name)
  execute 'nmap <silent> ' . a:keys . ' <Plug>(Loupe' . a:name . ')'
  execute 'nnoremap <silent> <Plug>(Loupe' . a:name . ')' .
        \ ' ' .
        \ a:keys .
        \ ':call loupe#hlmatch()<CR>'
endfunction

call s:map('n', 'n')
call s:map('N', 'N')
call s:map('#', 'Octothorpe')
call s:map('*', 'Star')
call s:map('g#', 'GOctothorpe')
call s:map('g*', 'GStar')

" Clean-up stray `matchadd()` vestiges.
if has('autocmd') && has('extra_search')
  augroup LoupeCleanUp
    autocmd!
    autocmd WinEnter * :call loupe#private#cleanup()
  augroup END
endif

" Restore 'cpoptions' to its former value.
let &cpoptions=s:cpoptions
unlet s:cpoptions
