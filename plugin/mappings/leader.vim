" Leader mappings.

" Use <Leader>r (mnemonic: replace) instead of default <Leader>e:
nmap <Leader>r <Plug>(Scalpel)

" Use <Leader>q as exit
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Save with sudo
nnoremap <Leader>W :w suda://%<CR>

" Cycle through buffers
nnoremap <Leader>b :bnext<CR>
nnoremap <Leader>B :bprevious<CR>

" Cycle through tabs
nnoremap <Leader><Tab> gt
nnoremap <Leader><S-Tab> gT

" FZF
nnoremap <silent> <Leader>t :FZF<CR>
nnoremap <Leader>T :FZF 

" Copy to/paste from clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" <Leader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
nnoremap <silent> <Leader>c :syntax sync fromstart<CR>

" Disable highlighting of search results
"nnoremap <Leader>n :noh<CR>
