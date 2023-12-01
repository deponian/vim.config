-- if .../lazy doesn't exist we activate so called "server mode"
-- in this mode we use .plugins as the source of plugins
-- also tree-sitter and LSP configuration are disabled
local plugins_path = vim.fn.stdpath("data") .. "/lazy"
vim.g.server_mode = false
if vim.fn.isdirectory(plugins_path) == 0 then
  plugins_path = vim.fn.stdpath("config") .. "/.plugins"
  vim.g.server_mode = true
end
local lazypath = plugins_path .. "/lazy.nvim"

-- install lazy.nvim if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- place where plugin manager lives
vim.opt.rtp:prepend(plugins_path .. "/lazy.nvim")

-- evertything we need before initialization of plugins
require("options")
require("settings")
require("autocmd")
require("keymaps")

-- initialization of plugins
require("lazy").setup("configs", {
  root = plugins_path,
  lockfile = vim.fn.stdpath("config") .. "/.lazy-lock.json",
  install = {
    missing = false,
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
})
