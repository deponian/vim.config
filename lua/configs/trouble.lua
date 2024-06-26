local M = { "folke/trouble.nvim" }

M.opts = {}

M.cmd = "Trouble"

M.keys = {
  -- <Leader>u -- Toggle Trouble panel
  -- (mnemonic: tro[u]ble)
  { "<Leader>u", "<cmd>Trouble diagnostics toggle<CR>" }
}

return M
