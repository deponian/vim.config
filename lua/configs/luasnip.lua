local M = {
  "L3MON4D3/LuaSnip",
  version = "1.*",
  build = "make install_jsregexp"
}

M.dependencies = {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

M.opts = {
  store_selection_keys="<Tab>",
  update_events = "TextChanged,TextChangedI",
}

M.config = function(_, opts)
  local luasnip = require('luasnip')
  local s = luasnip.snippet
  local t = luasnip.text_node
  local i = luasnip.insert_node

  luasnip.config.setup(opts)

  luasnip.add_snippets(nil, {
    all = {
      s(
        {trig = 'lorem', dscr = 'Lorem ipsum'},
        t('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
      ),
    },
    sh = {
      s("shebang", {
        t({"#!/usr/bin/env bash",
            "set -euo pipefail",
            "shopt -s extglob nullglob",
            "IFS=$'\\n\\t'", "", ""
          }),
        i(0),
      })
    },
  })
end

return M
