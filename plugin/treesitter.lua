-- general nvim-treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all', -- A list of parser names, or "all"
  ignore_install = {'norg'}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, buf)
        local max_filesize = 25 * 1024 -- 25 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = {},
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
}

-- custom highlighting for yaml filetype
vim.api.nvim_set_hl(0, "@field.yaml", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@number.yaml", { link = "Function" })
vim.api.nvim_set_hl(0, "@boolean.yaml", { link = "Conditional" })

-- custom highlighting for gitcommit filetype
vim.api.nvim_set_hl(0, "@text.uri.gitcommit", { link = "Constant" })
