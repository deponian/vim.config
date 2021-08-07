" Normal mode mappings.

" Disable Shift + Right Mouse search
nnoremap <S-RightMouse> <Nop>

" Disable Shift + Up and Shift + Down
nnoremap <S-Up> <Nop>
nnoremap <S-Down> <Nop>

" Move between windows (splits)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

" Reload file from disk
noremap <silent> <F5> :edit!<CR>

" Show different version of current file
noremap <silent> <F6> :call mappings#normal#git_show_file_versions()<CR>

" Toggle diff mode for all windows
noremap <silent> <F7> :call mappings#normal#toggle_diff()<CR>

" Avoid unintentional switches to Ex mode.
noremap Q <Nop>

" Now Ctrl-C is not useless
noremap <C-c> <Esc>

" Replay plugin
nmap <unique> <F12> <Plug>(Replay)

" Open Nerdtree file explorer
" (mnemonic: Win-` is hot key for Double Commander)
nnoremap <silent> ` :NERDTreeToggle %:p:h<CR>:silent NERDTreeMirror<CR>

" Next item in quickfix list
noremap <M-.> :cnext<CR>

" Previous item in quickfix list
noremap <M-,> :cprevious<CR>
