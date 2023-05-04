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
nnoremap <Tab> <C-w>w
nnoremap ; <C-w>w

" Disable vim command line window
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" Just like D
noremap Y y$

" Delete without changing any registers
nnoremap D "_D

" Toggle list (display unprintable characters)
noremap <F2> :set list!<CR>

" Toggle between number and nonumber
noremap <F3> :set invnumber<CR>

" Toggle between spell and nospell
noremap <F4> :setlocal spell! spelllang=ru,en<CR>

" Reload file from disk
noremap <silent> <F5> :edit!<CR>

" Show different version of current file
noremap <silent> <F6> :call mappings#normal#git_show_file_versions()<CR>

" Toggle diff mode for all windows
noremap <silent> <F7> :call mappings#normal#toggle_diff()<CR>

" Hide all diagnostic messages
noremap <silent> <F8> <CMD>lua vim.diagnostic.hide()<CR>

" Now Ctrl-C is not useless
noremap <C-c> <Esc>

" Replay plugin
nmap <unique> <F12> <Plug>(Replay)

" Open NvimTree file explorer
" (mnemonic: Win-` is hot key for Double Commander)
nnoremap <silent> ` :NvimTreeToggle<CR>

" Next item in quickfix list
noremap <M-.> :cnext<CR>

" Previous item in quickfix list
noremap <M-,> :cprevious<CR>
