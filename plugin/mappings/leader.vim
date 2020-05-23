" Leader mappings.

" <Leader>q -- exit
nnoremap <Leader>q :quit<CR>

" <Leader>Q -- exit withoout saving
nnoremap <Leader>Q :quit!<CR>

" <Leader>w -- save buffer
nnoremap <Leader>w :write<CR>

" <Leader>W -- save buffer with sudo
nnoremap <Leader>W :w suda://%<CR>

" <Leader>b/<Leader>B -- cycle through buffers
nnoremap <silent> <Leader>b :bnext<CR>
nnoremap <silent> <Leader>B :bprevious<CR>

" <Leader><Tab>/<Leader><Shift-Tab> -- cycle through tabs
nnoremap <silent> <Leader><Tab> gt
nnoremap <silent> <Leader><S-Tab> gT

" <Leader>y/<Leader>p -- copy to and paste from clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>p "+]p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+]p

" <Leader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
nnoremap <silent> <Leader>c :syntax sync fromstart<CR>

" <Leader>h -- Disable highlighting of search results
" (mnemonic: no [h]ighlighting)
nnoremap <silent> <Leader>h :noh<CR>

" <Leader>z -- Zap trailing whitespace in the current buffer
" (mnemonic: zap)
nnoremap <Leader>z :call mappings#leader#zap()<CR>:echo "All trailing whitespaces were zapped"<CR>

" <Leader>x -- Replace tabs with spaces or vice versa according to current
" tabstop, expandtab/noexpandtab and etc.
" (mnemonic: it is close to 'z' where zap mapping lives :D)
nnoremap <Leader>x :%retab!<CR>:echo "Retabed successfully"<CR>

" <Leader>r -- Replace word or selected sequence
" (mnemonic: replace)
nmap <Leader>r <Plug>(Scalpel)
vmap <Leader>r <Plug>(ScalpelVisual)

" <Leader>t -- FZF
nnoremap <silent> <Leader>t :FZF<CR>
nnoremap <Leader>T :FZF

" <Leader>d -- Detect indentation in buffer and change expandtab/noexpandtab, tabstop and etc.
" (mnemonic: detect)
nnoremap <Leader>d :call detectindent#detect()<CR>:echo "Indentation detected"<CR>
