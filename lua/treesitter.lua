-- general nvim-treesitter configuration 
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {'jsonc'}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {'yaml'},  -- list of language that will be disabled
  },
}
