-- general nvim-treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all', -- A list of parser names, or "all"
  ignore_install = {'norg', 'phpdoc'}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {'yaml'}, -- list of language that will be disabled
  },
}
