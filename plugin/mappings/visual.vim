" Visual mode mappings.

" Move between splits
xnoremap <C-Left> <C-w>h
xnoremap <C-Down> <C-w>j
xnoremap <C-Up> <C-w>k
xnoremap <C-Right> <C-w>l

" Disable Shift + Right Mouse search
xnoremap <S-RightMouse> <Nop>

" Disable Shift + Up and Shift + Down
xnoremap <S-Up> <Nop>
xnoremap <S-Down> <Nop>

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K <Nop>
xnoremap <silent> J <Nop>

" Delete without changing any registers
xnoremap d "_d
