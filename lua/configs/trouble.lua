local M = {
  "folke/trouble.nvim",
  enabled = not vim.g.diff_mode,
}

M.opts = {}

M.cmd = "Trouble"

M.keys = {
  -- <Leader>U -- Toggle Trouble panel
  -- (mnemonic: tro[u]ble)
  { "<Leader>U", "<cmd>Trouble diagnostics toggle<CR>" }
}

return M
