local M = { "deponian/nvim-scalpelua" }

M.opts = {
  minimap_enabled = true
}

M.keys = {
  -- <Leader>r -- Replace string in whole buffer or inside selected lines
  -- (mnemonic: [r]eplace)
  { "<Leader>r", "<Plug>(Scalpelua)", mode = "x" },
  { "<Leader>R", "<Plug>(ScalpeluaMultiline)", mode = "x" },
}

return M
