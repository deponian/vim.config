" Leader mappings.

" Use <Leader>r (mnemonic: replace) instead of default <Leader>e:
nmap <Leader>r <Plug>(Scalpel)

" Use <Leader>q as exit
nnoremap <Leader>q :quit<CR>

" Use <Leader>Q as exit withoout saving
nnoremap <Leader>Q :quit!<CR>

" Save buffer
nnoremap <Leader>w :write<CR>

" Save buffer with sudo
nnoremap <Leader>W :w suda://%<CR>

" Cycle through buffers
nnoremap <silent> <Leader>b :bnext<CR>
nnoremap <silent> <Leader>B :bprevious<CR>

" Cycle through tabs
nnoremap <silent> <Leader><Tab> gt
nnoremap <silent> <Leader><S-Tab> gT

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
nnoremap <silent> <Leader>n :noh<CR>

" <Leader>zz -- Zap trailing whitespace in the current buffer.
nnoremap <silent> <Leader>zz :call mappings#leader#zap()<CR>
