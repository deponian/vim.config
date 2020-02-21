if v:progname == 'vi'
	set noloadplugins
endif

let mapleader="\<Space>"
let maplocalleader="\\"

" Stark highlighting is enough to see the current match; don't need the
" centering, which can be annoying.
let g:LoupeCenterResults=0

" And it turns out that if we're going to turn off the centering, we don't even
" need the mappings; see: https://github.com/wincent/loupe/pull/15
map <Nop><F1> <Plug>(LoupeN)
nmap <Nop><F2> <Plug>(Loupen)

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

let s:vimrc_local=$HOME . '/.vim/vimrc.local'
if filereadable(s:vimrc_local)
	execute 'source ' . s:vimrc_local
endif

if &loadplugins
	if has('packages')
		packadd! fzf				" https://github.com/junegunn/fzf
		packadd! neomake			" https://github.com/neomake/neomake
		packadd! onedark			" https://github.com/joshdick/onedark.vim
		packadd! terminus			" https://github.com/wincent/terminus
		packadd! loupe				" https://github.com/wincent/loupe
		packadd! replay				" https://github.com/wincent/replay
		packadd! scalpel			" https://github.com/wincent/scalpel
		packadd! suda.vim			" https://github.com/lambdalisue/suda.vim
		packadd! supertab			" https://github.com/ervandew/supertab
		packadd! vim-airline		" https://github.com/vim-airline/vim-airline
		packadd! vim-bufferline		" https://github.com/bling/vim-bufferline
		packadd! vim-commentary		" https://github.com/tpope/vim-commentary
		packadd! vim-easydir		" https://github.com/duggiefresh/vim-easydir
		packadd! vim-manpager		" https://github.com/lambdalisue/vim-manpager
		packadd! vim-polyglot		" https://github.com/sheerun/vim-polyglot
		packadd! vim-repeat			" https://github.com/tpope/vim-repeat
		packadd! vim-speeddating	" https://github.com/tpope/vim-surround
		packadd! vim-surround		" https://github.com/tpope/vim-speeddating
		packadd! vim-windowswap		" https://github.com/wesQ3/vim-windowswap
		packadd! vim-zsh			" https://github.com/chrisbra/vim-zsh
		if has('nvim')
			packadd! semshi			" https://github.com/numirias/semshi
		else
			packadd! python-syntax	" https://github.com/vim-python/python-syntax
			packadd! matchit		" ships with vim and built-in into neovim
		endif
	else
		source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
		call pathogen#infect('pack/bundle/opt/{}')
	endif
endif

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
"
" Must come *after* the `:packadd!` calls above otherwise the contents of
" package "ftdetect" directories won't be evaluated.
filetype indent plugin on
syntax on

" After this file is sourced, plugin code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order.
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plugins:
"
"	vim -c 'set t_te=' -c 'set t_ti=' -c 'map <space>' -c q | sort

