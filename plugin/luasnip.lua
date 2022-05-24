local has_luasnip, luasnip = pcall(require, 'luasnip')
if has_luasnip then
  local s = luasnip.snippet
  local sn = luasnip.snippet_node
  local t = luasnip.text_node
  local i = luasnip.insert_node
  local f = luasnip.function_node
  local c = luasnip.choice_node
  local d = luasnip.dynamic_node
  local r = luasnip.restore_node
  local types = require('luasnip.util.types')
  local fmt = require('luasnip.extras.fmt').fmt

  luasnip.config.setup({
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = {{"← Choice", "Todo"}},
        },
      },
      -- [types.insertNode] = {
      --   active = {
      --     virt_text = {{"← ...", "Todo"}},
      --   },
      -- },
    },
    store_selection_keys="<Tab>",
    update_events="InsertLeave,TextChangedI",
  })

  local date = function() return {os.date('%Y-%m-%d')} end

  luasnip.add_snippets(nil, {
    all = {
      s(
        {trig = 'lorem', dscr = 'Lorem ipsum'},
        t('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
      ),
    },
  })
end
