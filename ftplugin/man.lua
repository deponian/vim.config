-- disable embedded neovim ftplugin for man pages
vim.b.did_ftplugin = true

vim.opt_local.expandtab = false
vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 8
vim.opt_local.shiftwidth = 8

vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true

vim.opt_local.colorcolumn = ""
vim.opt_local.list = false

vim.opt_local.iskeyword='@-@,:,a-z,A-Z,48-57,_,.,-,(,)'

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.foldcolumn = "0"
vim.opt_local.signcolumn = "no"

vim.opt_local.foldenable = false

vim.opt_local.tagfunc = "v:lua.require'man'.goto_tag"

vim.keymap.set('n', 'j', 'gj', { buffer = true })
vim.keymap.set('n', 'k', 'gk', { buffer = true })
