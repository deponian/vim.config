require'nvim-treesitter.configs'.setup {
  -- ensure_installed = {'c', 'cpp', 'css', 'go', 'html', 'javascript', 'json', 'lua', 'python', 'ruby', 'toml', 'yaml'} , -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {'jsonc'}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
