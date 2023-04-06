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

" <Leader>D -- delete buffer
" (mnemonic: delete)
nnoremap <silent> <Leader>D :bdelete<CR>

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

" <Leader>d -- Set indentation in buffer (change expandtab/noexpandtab, tabstop and etc)
" (mnemonic: in[d]ent)
nnoremap <Leader>d :call mappings#leader#setindent()<CR>

" <Leader>s -- Search WORD under cursor or selected sequence within page
" (mnemonic: search)
nmap <Leader>s g*
vmap <Leader>s y/<BS><BS>\V<C-R>=escape(@",'\/')<CR><CR>

" <Leader>S -- Substitution alias
" (mnemonic: substitute)
nmap <Leader>S :%s/

" <Leader>f -- Recursively find WORD under cursor or selected sequence in all files in a directory tree
" (mnemonic: find)
nnoremap <Leader>f :RG<CR>
vnoremap <Leader>f y:RG . <C-R>"<CR>

" <Leader>r -- Replace WORD or selected sequence within page
" (mnemonic: replace)
nmap <Leader>r <Plug>(Scalpel)
vmap <Leader>r <Plug>(ScalpelVisual)

" <Leader>F -- Open file under cursor in new tab
" (mnemonic: file)
nnoremap <Leader>F <C-W>gf

" <Leader>n -- Disable highlighting of search results
" (mnemonic: [n]o highlighting)
nmap <Leader>n <Plug>(LoupeClearHighlight)

" <Leader>c -- Fold all #-comments in buffer
" (mnemonic: comment)
nnoremap <Leader>c :setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*#'\\|\\|getline(v:lnum)=~'^\\s*$'<CR>zM

" <Leader>hP -- Preview the hunk in the floating window
" (mnemonic: hunk preview)
nmap <silent> <Leader>hp :Gitsigns preview_hunk<CR>

" <Leader>hp -- Preview the hunk inline
" (mnemonic: hunk preview)
nmap <silent> <Leader>hP :Gitsigns preview_hunk_inline<CR>

" <Leader>hw -- Toggle word diff for hunks
" (mnemonic: hunk word diff)
nmap <silent> <Leader>hw :Gitsigns toggle_word_diff<CR>

" <Leader>hd -- Toggle deleted hunks
" (mnemonic: hunk deleted)
nmap <silent> <Leader>hd :Gitsigns toggle_deleted<CR>

" <Leader>hu -- Undo the hunk
" (mnemonic: hunk undo)
nmap <silent> <Leader>hu :Gitsigns reset_hunk<CR>

" <Leader>B -- Decode selected sequence from base64
" (mnemonic: base64)
vnoremap <Leader>b :FromBase64<CR>

" <Leader>b -- Encode selected sequence to base64
" (mnemonic: base64)
vnoremap <Leader>B :ToBase64<CR>
