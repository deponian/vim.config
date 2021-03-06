if v:progname == 'vi'
	set noloadplugins
endif

let mapleader="\<Space>"
let maplocalleader="\\"

" Return to last edit position when opening files
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\ exe "normal! g`\"" |
			\ endif

let s:vimrc_local=$HOME . '/.vim/vimrc.local'
if filereadable(s:vimrc_local)
	execute 'source ' . s:vimrc_local
endif

if &loadplugins
	if has('packages')
		" General plugins
		packadd! base64					" https://github.com/christianrondeau/vim-base64
		packadd! commentary				" https://github.com/tpope/vim-commentary
		packadd! fzf					" https://github.com/junegunn/fzf
		packadd! fzf-vim				" https://github.com/junegunn/fzf.vim
		packadd! gitgutter				" https://github.com/airblade/vim-gitgutter
		packadd! indentline				" https://github.com/Yggdroot/indentLine
		packadd! lightline				" https://github.com/itchyny/lightline.vim [c172131]
		packadd! lightline-neomake		" https://github.com/sinetoami/lightline-neomake
		packadd! lightline-whitespace	" https://github.com/deponian/vim-lightline-whitespace
		packadd! loupe					" https://github.com/deponian/vim-loupe
		packadd! manpager				" https://github.com/lambdalisue/vim-manpager
		packadd! neomake				" https://github.com/neomake/neomake [d10e5395]
		packadd! nerdtree				" https://github.com/preservim/nerdtree
		packadd! onedark				" https://github.com/deponian/vim-onedark
		packadd! repeat					" https://github.com/tpope/vim-repeat
		packadd! replay					" https://github.com/wincent/replay
		packadd! scalpel				" https://github.com/deponian/vim-scalpel
		packadd! speeddating			" https://github.com/tpope/vim-speeddating
		packadd! suda					" https://github.com/lambdalisue/suda.vim
		packadd! supertab				" https://github.com/ervandew/supertab
		packadd! surround				" https://github.com/tpope/vim-surround
		packadd! terminus				" https://github.com/deponian/vim-terminus

		" language/syntax/filetype plugins
		packadd! ansible				" https://github.com/pearofducks/ansible-vim
		packadd! cmake					" https://github.com/pboettch/vim-cmake-syntax
		packadd! dockerfile				" https://github.com/ekalinin/Dockerfile.vim
		packadd! git					" https://github.com/tpope/vim-git
		packadd! go						" https://github.com/fatih/vim-go
		packadd! haproxy				" https://github.com/CH-DanReif/haproxy.vim
		packadd! helm					" https://github.com/towolf/vim-helm.git
		packadd! log					" https://github.com/MTDL9/vim-log-highlighting
		packadd! mustache				" https://github.com/mustache/vim-mustache-handlebars
		packadd! nftables				" https://github.com/nfnty/vim-nftables
		packadd! nginx					" https://github.com/chr4/nginx.vim
		packadd! systemd				" https://github.com/Matt-Deacalion/vim-systemd-syntax
		packadd! terraform				" https://github.com/hashivim/vim-terraform
		packadd! tmux					" https://github.com/ericpruitt/tmux.vim
		packadd! toml					" https://github.com/cespare/vim-toml
		packadd! yaml					" https://github.com/stephpy/vim-yaml
		packadd! zsh					" https://github.com/chrisbra/vim-zsh

		" Vim/Neovim specific plugins
		if has('nvim')
			" packadd! semshi				" https://github.com/numirias/semshi
			packadd! treesitter			" https://github.com/nvim-treesitter/nvim-treesitter
			lua require('treesitter')
		else
			packadd! python				" https://github.com/vim-python/python-syntax
			packadd! matchit			" ships with vim and built-in into neovim
		endif
	else
		source $HOME/.vim/pack/bundle/opt/pathogen/autoload/pathogen.vim
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
