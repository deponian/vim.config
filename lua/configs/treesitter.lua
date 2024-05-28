local M = {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.bigfile_mode,
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    sync_install = true,
    -- A list of parser names, or "all"
    ensure_installed = not vim.g.server_mode and "all" or {},
    -- List of parsers to ignore installing
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 25 * 1024 -- 25 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
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
