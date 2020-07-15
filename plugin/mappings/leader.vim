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
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" <Leader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
" nnoremap <silent> <Leader>c :syntax sync fromstart<CR>

" <Leader>z -- Zap trailing whitespace in the current buffer
" (mnemonic: zap)
nnoremap <Leader>z :call mappings#leader#zap()<CR>:echo "All trailing whitespaces were zapped"<CR>

" <Leader>x -- Replace tabs with spaces or vice versa according to current
" tabstop, expandtab/noexpandtab and etc.
" (mnemonic: it is close to 'z' where zap mapping lives :D)
nnoremap <Leader>x :call mappings#leader#retab()<CR>:echo "Retabed successfully"<CR>

" <Leader>t -- Find and open file
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <Leader>T :Files 

" <Leader>d -- delete buffer
" (mnemonic: delete)
nnoremap <silent> <Leader>d :bdelete<CR>

" <Leader>D -- Set indentation in buffer (change expandtab/noexpandtab, tabstop and etc)
" (mnemonic: in[d]ent)
nnoremap <Leader>D :call mappings#leader#setindent()<CR>

" <Leader>s -- Search WORD under cursor or selected sequence within page
" (mnemonic: search)
nmap <Leader>s g*
vmap <Leader>s y/<BS><BS>\V<C-R>=escape(@",'\/')<CR><CR>

" <Leader>f -- Recursively find WORD under cursor or selected sequence in all files in a directory tree
" (mnemonic: find)
nmap <Leader>f :RG! <C-R>=expand('<cWORD>')<CR><CR>
vmap <Leader>f y:RG! <C-R>"<CR>

" <Leader>r -- Replace WORD or selected sequence within page
" (mnemonic: replace)
nmap <Leader>r <Plug>(Scalpel)
vmap <Leader>r <Plug>(ScalpelVisual)

" <Leader>F -- Open file under cursor in new tab
" (mnemonic: file)
nmap <Leader>F <C-W>gf

" <Leader>h -- Disable highlighting of search results
" (mnemonic: no [h]ighlighting)
nmap <Leader>h <Plug>(LoupeClearHighlight)

" <Leader>` -- Open Nerdtree file explorer
" (mnemonic: Win-` is hot key for Double Commander)
nnoremap <silent> <Leader>` :NERDTreeToggle %:p:h<CR>:silent NERDTreeMirror<CR>

" <Leader>c -- Fold all #-comments in buffer
" (mnemonic: comment)
nnoremap <Leader>c :setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*#'\\|\\|getline(v:lnum)=~'^\\s*$'<CR>zM
