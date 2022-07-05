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

" General plugins
packadd! base64					" https://github.com/christianrondeau/vim-base64
packadd! commentary				" https://github.com/tpope/vim-commentary
packadd! fugitive				" https://github.com/tpope/vim-fugitive
packadd! fzf					" https://github.com/junegunn/fzf
packadd! fzf-vim				" https://github.com/junegunn/fzf.vim
packadd! gitgutter				" https://github.com/airblade/vim-gitgutter
packadd! indent-blankline		" https://github.com/lukas-reineke/indent-blankline.nvim
packadd! lightline				" https://github.com/itchyny/lightline.vim
packadd! lightline-neomake		" https://github.com/sinetoami/lightline-neomake
packadd! lightline-whitespace	" https://github.com/deponian/vim-lightline-whitespace
packadd! loupe					" https://github.com/deponian/vim-loupe
packadd! luasnip				" https://github.com/L3MON4D3/LuaSnip
packadd! manpager				" https://github.com/lambdalisue/vim-manpager
packadd! neomake				" https://github.com/neomake/neomake
packadd! nvim-cmp				" https://github.com/hrsh7th/nvim-cmp
packadd! nvim-cmp-buffer		" https://github.com/hrsh7th/cmp-buffer
packadd! nvim-cmp-calc			" https://github.com/hrsh7th/cmp-calc
packadd! nvim-cmp-lsp			" https://github.com/hrsh7th/cmp-nvim-lsp
packadd! nvim-cmp-luasnip		" https://github.com/saadparwaiz1/cmp_luasnip
packadd! nvim-cmp-path			" https://github.com/hrsh7th/cmp-path
packadd! nvim-cmp-rg			" https://github.com/lukas-reineke/cmp-rg
packadd! nvim-cmp-spell			" https://github.com/f3fora/cmp-spell
packadd! nvim-colorizer			" https://github.com/norcalli/nvim-colorizer.lua
packadd! nvim-lspconfig			" https://github.com/neovim/nvim-lspconfig
packadd! nvim-web-devicons		" https://github.com/kyazdani42/nvim-web-devicons
packadd! nvimtree				" https://github.com/kyazdani42/nvim-tree.lua
packadd! onedark				" https://github.com/navarasu/onedark.nvim
packadd! repeat					" https://github.com/tpope/vim-repeat
packadd! replay					" https://github.com/wincent/replay
packadd! rhubarb				" https://github.com/tpope/vim-rhubarb
packadd! scalpel				" https://github.com/deponian/vim-scalpel
packadd! speeddating			" https://github.com/tpope/vim-speeddating
packadd! suda					" https://github.com/lambdalisue/suda.vim
packadd! surround				" https://github.com/tpope/vim-surround
packadd! terminus				" https://github.com/deponian/vim-terminus
packadd! treesitter				" https://github.com/nvim-treesitter/nvim-treesitter

" language/syntax/filetype plugins
packadd! ansible				" https://github.com/pearofducks/ansible-vim
packadd! cmake					" https://github.com/pboettch/vim-cmake-syntax
packadd! dockerfile				" https://github.com/ekalinin/Dockerfile.vim
packadd! git					" https://github.com/tpope/vim-git
packadd! github-actions			" https://github.com/yasuhiroki/github-actions-yaml.vim.git
packadd! go						" https://github.com/fatih/vim-go
packadd! haproxy				" https://github.com/CH-DanReif/haproxy.vim
packadd! helm					" https://github.com/towolf/vim-helm
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

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
"
" Must come *after* the `:packadd!` calls above otherwise the contents of
" package "ftdetect" directories won't be evaluated.
filetype indent plugin on
syntax on

lua << EOF
local has_luasnip, luasnip = pcall(require, 'luasnip')
if has_luasnip then
  -- LuaSnip sets up its autocmds in "plugin/luasnip.vim", too early
  -- for us to influence them from "plugins/snippets.lua" (Lua files load
  -- last), so we have to do this even earlier, here.
  luasnip.config.set_config({
    updateevents = "TextChanged,TextChangedI", -- default is InsertLeave
  })
end
EOF

" After this file is sourced, plugin code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order.
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plugins:
"
"	vim -c 'set t_te=' -c 'set t_ti=' -c 'map <space>' -c q | sort
