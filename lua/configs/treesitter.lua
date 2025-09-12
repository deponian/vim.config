local M = {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.bigfile_mode,
  branch = 'master'
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = not vim.g.server_mode and "all" or {},
    -- List of parsers to ignore installing
    ignore_install = {'ipkg'},
    highlight = {
      enable = true,
    },
  })

  -- custom highlighting for yaml filetype
  vim.api.nvim_set_hl(0, "@field.yaml", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@number.yaml", { link = "Function" })
  vim.api.nvim_set_hl(0, "@boolean.yaml", { link = "Conditional" })

  -- custom highlighting for gitcommit filetype
  vim.api.nvim_set_hl(0, "@text.uri.gitcommit", { link = "Constant" })

  -- custom highlighting for url inside text
  vim.api.nvim_set_hl(0, "@text.uri", { link = "Constant" })
end

return M
