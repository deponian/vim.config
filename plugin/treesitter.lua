-- general nvim-treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all', -- A list of parser names, or "all"
  ignore_install = {'norg'}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {''}, -- list of language that will be disabled
  },
}

-- custom highlighting for yaml filetype
vim.api.nvim_set_hl(0, "@field.yaml", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@number.yaml", { link = "Function" })
vim.api.nvim_set_hl(0, "@boolean.yaml", { link = "Conditional" })

-- custom highlighting for gitcommit filetype
vim.api.nvim_set_hl(0, "@text.uri.gitcommit", { link = "Constant" })
