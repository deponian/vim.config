" Normal mode mappings.

" Disable Shift + Right Mouse search
nnoremap <S-RightMouse> <Nop>

" Disable Shift + Up and Shift + Down
nnoremap <S-Up> <Nop>
nnoremap <S-Down> <Nop>

" Move between windows (splits)
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

" Cycle through windows (splits)
nnoremap <S-Tab> <C-w>w

" Disable vim command line window
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$

" Toggle list (display unprintable characters)
noremap <F2> :set list!<CR>

" Toggle between number and nonumber
noremap <F3> :set invnumber<CR>

" Toggle between spell and nospell
noremap <F4> :set spell!<CR>

" Avoid unintentional switches to Ex mode.
noremap Q <Nop>

" Now Ctrl-C is not useless
noremap <C-c> <Esc>

" Replay plugin
nmap <unique> <F12> <Plug>(Replay)

