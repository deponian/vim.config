local M = { "deponian/nvim-scalpelua" }

M.opts = {
  minimap_enabled = true,
  highlighting = {
    regular_search_pattern = "Search",
    current_search_pattern = "CurSearch",
    minimap_integration = "Constant",
  },
}

M.keys = {
  -- <Leader>r -- Replace string in whole buffer or inside selected lines
  -- (mnemonic: [r]eplace)
  { "<Leader>r", "<Plug>(Scalpelua)", mode = "x" },
  { "<Leader>R", "<Plug>(ScalpeluaMultiline)", mode = "x" },
}

return M
