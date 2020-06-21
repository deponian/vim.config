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

" <Leader>t -- FZF
nnoremap <silent> <Leader>t :FZF<CR>
nnoremap <Leader>T :FZF

" <Leader>d -- Set indentation in buffer (change expandtab/noexpandtab, tabstop and etc)
" (mnemonic: in[d]ent)
nnoremap <Leader>d :call mappings#leader#setindent()<CR>

" <Leader>s -- Search selected sequence
" (mnemonic: search)
vmap <Leader>s y/<BS><BS>\V<C-R>=escape(@",'\')<CR><CR>

" <Leader>h -- Disable highlighting of search results
" (mnemonic: no [h]ighlighting)
nmap <Leader>h <Plug>(LoupeClearHighlight)

" <Leader>r -- Replace word or selected sequence
" (mnemonic: replace)
nmap <Leader>r <Plug>(Scalpel)
vmap <Leader>r <Plug>(ScalpelVisual)

" <Leader>f -- Open file under cursor in new tab
" (mnemonic: file)
nmap <Leader>f <C-W>gf

" <Leader>` -- Open Nerdtree file explorer
" (mnemonic: Win-` is hot key for Double Commander)
nnoremap <silent> <Leader>` :NERDTreeToggle %:p:h<CR>:silent NERDTreeMirror<CR>

" <Leader>c -- Fold all #-comments in buffer
" (mnemonic: comment)
nnoremap <Leader>c :setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*#'\\|\\|getline(v:lnum)=~'^\\s*$'<CR>zM
