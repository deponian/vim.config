local M = {
  "deponian/mini.map",
  lazy = false,
}

M.opts = function ()
  local map = require('mini.map')
  return {
    -- Highlight integrations (none by default)
    integrations = {
      map.gen_integration.builtin_search({search = 'Operator'}),
      map.gen_integration.gitsigns(),
      map.gen_integration.diagnostic(),
    },

    -- Symbols used to display data
    symbols = {
      encode = map.gen_encode_symbols.dot('4x2'),
      scroll_line = '┃',
      scroll_view = '┃',
    },

    -- Window options
    window = {
      focusable = false,
      side = 'right',
      show_integration_count = false,
      width = 12,
      winblend = 0,
    },
  }
end

M.config = function(_, opts)
  require("mini.map").setup(opts)

  vim.api.nvim_set_hl(0, "MiniMapNormal", { link = "LineNr" })
  vim.api.nvim_set_hl(0, "MiniMapSymbolLine", { link = "Normal" })
  vim.api.nvim_set_hl(0, "MiniMapSymbolView", { link = "LineNr" })
end

M.keys = {
  -- <Leader>m -- Toggle minimap
  -- (mnemonic: mini[m]ap)
  { "<Leader>m", function()
    MiniMap.toggle()
  end }
}

return M
