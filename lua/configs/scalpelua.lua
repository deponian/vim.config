local M = { "deponian/nvim-scalpelua" }

M.opts = {
  minimap_enabled = not vim.g.bigfile_mode,
  highlighting = {
    regular_search_pattern = "Search",
    current_search_pattern = "CurSearch",
    minimap_integration = "Keyword",
  },
}

M.keys = {
  -- <Leader>r -- Replace string in whole buffer or inside selected lines
  -- (mnemonic: [r]eplace)
  { "<Leader>r", "<Plug>(Scalpelua)", mode = "x" },
  { "<Leader>R", "<Plug>(ScalpeluaMultiline)", mode = "x" },
  { "<Leader>r", "<Plug>(Scalpelua)", mode = "n" },
}

return M
