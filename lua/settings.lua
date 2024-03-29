-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "spellfile_plugin",
  "tar",
  "tarPlugin",
  "tutor_mode_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Ansible
vim.g.ansible_unindent_after_newline = 1
vim.g.ansible_attribute_highlight = 'a'
vim.g.ansible_name_highlight = 'b'
vim.g.ansible_extra_keywords_highlight = 1

-- Python
vim.g.python_recommended_style = 0

-- Set mapleader and maplocalleader
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
