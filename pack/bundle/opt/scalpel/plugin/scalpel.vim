" Licensed under the terms of the MIT license.
" Copyright (c) 2016-present Greg Hurrell
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.
"
" Modified By: Rufus Deponian <deponian@pm.me>

" Provide users with means to prevent loading, as recommended in `:h
" write-plugin`.
if exists('g:ScalpelLoaded') || &compatible || v:version < 700
  finish
endif
let g:ScalpelLoaded = 1

" Temporarily set 'cpoptions' to Vim default as per `:h use-cpo-save`.
let s:cpoptions = &cpoptions
set cpoptions&vim

let s:command='Scalpel'

execute 'command! -nargs=1 -range '
      \ . s:command
      \ . ' call scalpel#substitute(<q-args>, <line1>, <line2>)'

" normal mode: change all instances of current word.
" visual mode: change all instances of selected sequence
execute 'nnoremap <Plug>(Scalpel) :' .
      \ s:command .
      \ "/\\v<<C-R>=expand('<cword>')<CR>>//<Left>"
execute 'vnoremap <Plug>(ScalpelVisual) :' .
      \ s:command .
      \ "/\\V<C-R>=scalpel#get_oneline_selection()<CR>//<Left>"

" Restore 'cpoptions' to its former value.
let &cpoptions = s:cpoptions
unlet s:cpoptions
