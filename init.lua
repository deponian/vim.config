-- Set mapleader and maplocalleader
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Return to last edit position when opening files
vim.cmd([[
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
]])

-- Load general plugins
vim.cmd('packadd! base64')                -- https://github.com/christianrondeau/vim-base64
vim.cmd('packadd! chatgpt')               -- https://github.com/jackMort/ChatGPT.nvim
vim.cmd('packadd! commentary')            -- https://github.com/tpope/vim-commentary
vim.cmd('packadd! fugitive')              -- https://github.com/tpope/vim-fugitive
vim.cmd('packadd! fzf')                   -- https://github.com/junegunn/fzf
vim.cmd('packadd! fzf-vim')               -- https://github.com/junegunn/fzf.vim
vim.cmd('packadd! gitsigns')              -- https://github.com/lewis6991/gitsigns.nvim.git
vim.cmd('packadd! indent-blankline')      -- https://github.com/lukas-reineke/indent-blankline.nvim
vim.cmd('packadd! lightline')             -- https://github.com/itchyny/lightline.vim
vim.cmd('packadd! lightline-whitespace')  -- https://github.com/deponian/vim-lightline-whitespace
vim.cmd('packadd! loupe')                 -- https://github.com/deponian/vim-loupe
vim.cmd('packadd! luasnip')               -- https://github.com/L3MON4D3/LuaSnip
vim.cmd('packadd! minimap')               -- https://github.com/deponian/mini.map
vim.cmd('packadd! nui')                   -- https://github.com/MunifTanjim/nui.nvim.git
vim.cmd('packadd! null-ls')               -- https://github.com/jose-elias-alvarez/null-ls.nvim
vim.cmd('packadd! nvim-cmp')              -- https://github.com/hrsh7th/nvim-cmp
vim.cmd('packadd! nvim-cmp-buffer')       -- https://github.com/hrsh7th/cmp-buffer
vim.cmd('packadd! nvim-cmp-calc')         -- https://github.com/hrsh7th/cmp-calc
vim.cmd('packadd! nvim-cmp-cmdline')      -- https://github.com/hrsh7th/cmp-cmdline.git
vim.cmd('packadd! nvim-cmp-lsp')          -- https://github.com/hrsh7th/cmp-nvim-lsp
vim.cmd('packadd! nvim-cmp-luasnip')      -- https://github.com/saadparwaiz1/cmp_luasnip
vim.cmd('packadd! nvim-cmp-path')         -- https://github.com/hrsh7th/cmp-path
vim.cmd('packadd! nvim-cmp-rg')           -- https://github.com/lukas-reineke/cmp-rg
vim.cmd('packadd! nvim-cmp-spell')        -- https://github.com/f3fora/cmp-spell
vim.cmd('packadd! nvim-colorizer')        -- https://github.com/NvChad/nvim-colorizer.lua
vim.cmd('packadd! nvim-lspconfig')        -- https://github.com/neovim/nvim-lspconfig
vim.cmd('packadd! nvim-ts-rainbow')       -- https://github.com/HiPhish/nvim-ts-rainbow2.git
vim.cmd('packadd! nvim-web-devicons')     -- https://github.com/kyazdani42/nvim-web-devicons
vim.cmd('packadd! nvimtree')              -- https://github.com/kyazdani42/nvim-tree.lua
vim.cmd('packadd! onedark')               -- https://github.com/navarasu/onedark.nvim
vim.cmd('packadd! plenary')               -- https://github.com/nvim-lua/plenary.nvim
vim.cmd('packadd! repeat')                -- https://github.com/tpope/vim-repeat
vim.cmd('packadd! rhubarb')               -- https://github.com/tpope/vim-rhubarb
vim.cmd('packadd! scalpelua')             -- https://github.com/deponian/nvim-scalpelua
vim.cmd('packadd! speeddating')           -- https://github.com/tpope/vim-speeddating
vim.cmd('packadd! suda')                  -- https://github.com/lambdalisue/suda.vim
vim.cmd('packadd! surround')              -- https://github.com/tpope/vim-surround
vim.cmd('packadd! telescope')             -- https://github.com/nvim-telescope/telescope.nvim
vim.cmd('packadd! terminus')              -- https://github.com/deponian/vim-terminus
vim.cmd('packadd! treesitter')            -- https://github.com/nvim-treesitter/nvim-treesitter

-- Load language/syntax/filetype plugins
vim.cmd('packadd! ansible')               -- https://github.com/pearofducks/ansible-vim
vim.cmd('packadd! cmake')                 -- https://github.com/pboettch/vim-cmake-syntax
vim.cmd('packadd! dockerfile')            -- https://github.com/ekalinin/Dockerfile.vim
vim.cmd('packadd! git')                   -- https://github.com/tpope/vim-git
vim.cmd('packadd! github-actions')        -- https://github.com/yasuhiroki/github-actions-yaml.vim.git
vim.cmd('packadd! go')                    -- https://github.com/fatih/vim-go
vim.cmd('packadd! haproxy')               -- https://github.com/CH-DanReif/haproxy.vim
vim.cmd('packadd! helm')                  -- https://github.com/towolf/vim-helm
vim.cmd('packadd! log')                   -- https://github.com/MTDL9/vim-log-highlighting
vim.cmd('packadd! mustache')              -- https://github.com/mustache/vim-mustache-handlebars
vim.cmd('packadd! nftables')              -- https://github.com/nfnty/vim-nftables
vim.cmd('packadd! nginx')                 -- https://github.com/chr4/nginx.vim
vim.cmd('packadd! systemd')               -- https://github.com/Matt-Deacalion/vim-systemd-syntax
vim.cmd('packadd! terraform')             -- https://github.com/hashivim/vim-terraform
vim.cmd('packadd! tmux')                  -- https://github.com/ericpruitt/tmux.vim
vim.cmd('packadd! toml')                  -- https://github.com/cespare/vim-toml
vim.cmd('packadd! yaml')                  -- https://github.com/stephpy/vim-yaml
vim.cmd('packadd! zsh')                   -- https://github.com/chrisbra/vim-zsh

-- LuaSnip configuration
local has_luasnip, luasnip = pcall(require, 'luasnip')
if has_luasnip then
  -- LuaSnip sets up its autocmds in "plugin/luasnip.vim", too early
  -- for us to influence them from "plugins/snippets.lua" (Lua files load
  -- last), so we have to do this even earlier, here.
  luasnip.config.set_config({
    updateevents = "TextChanged,TextChangedI", -- default is InsertLeave
  })
end

-- After this file is sourced, plugin code will be evaluated.
-- See ~/.config/nvim/after for files evaluated after that.
-- See `:scriptnames` for a list of all scripts, in evaluation order.
-- Launch Vim with `vim --startuptime vim.log` for profiling info.
--
-- To see all leader mappings, including those from plugins:
--
--	vim -c 'set t_te=' -c 'set t_ti=' -c 'map <space>' -c q | sort
