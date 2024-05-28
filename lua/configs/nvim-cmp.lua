local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "lukas-reineke/cmp-rg",
    "saadparwaiz1/cmp_luasnip",
    "uga-rosa/cmp-dictionary",
  },
}

M.config = function()
  local cmp = require('cmp')
  local has_luasnip, luasnip = pcall(require, 'luasnip')

  -- Converts a string representation of a mapping's RHS (eg. "<Tab>") into an
  -- internal representation (eg. "\t").
  local rhs = function(rhs_str)
    return vim.api.nvim_replace_termcodes(rhs_str, true, true, true)
  end

  -- Returns the current column number.
  local column = function()
    local _line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col
  end

  -- Based on (private) function in LuaSnip/lua/luasnip/init.lua.
  local in_snippet = function()
    local session = require('luasnip.session')
    local node = session.current_nodes[vim.api.nvim_get_current_buf()]
    if not node then
      return false
    end
    local snippet = node.parent.snippet
    local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
    local pos = vim.api.nvim_win_get_cursor(0)
    if pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1] then
      return true
    end
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
  }

  local winhighlight = {
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
  }

  cmp.setup {
    enabled = function()
      if not vim.g.bigfile_mode then
        return true
      else
        return false
      end
    end,
    preselect = cmp.PreselectMode.None,
    mapping = {
      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if cmp.get_selected_entry() then
            cmp.confirm({ select = false })
          else
            cmp.close()
            local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
            vim.api.nvim_feedkeys(enter, 'nt', false)
          end
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif has_luasnip and in_snippet() and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- If there is only one completion candidate, use it.
          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_next_item()
          end
        elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
    },

    snippet = {
      expand = function(args)
        if has_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },

    sources = cmp.config.sources({
      { name = 'buffer' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = 'calc' },
      {
        name = "dictionary",
        keyword_length = 2,
      },
      { name = 'rg',
        keyword_length = 3,
        option = {
          additional_arguments = "--one-file-system --ignore-file ~/.vim/.ignore.rg",
        },
      },
      {
        name = 'path',
        option = {
          get_cwd = function () return vim.fn.getcwd() end
        },
      },
    }),

    window = {
      documentation = cmp.config.window.bordered(winhighlight),
    },

    view = {
      entries = {name = 'custom', selection_order = 'near_cursor' }
    },

    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          rg = "[Files]",
          dictionary = "[Dictionary]",
          calc = "[Calc]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end
    },
  }

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' },
      { name = 'cmdline_history' }
    })
  })

  -- Dictionary source
  vim.opt.dictionary = vim.fn.stdpath("config") .. '/spell/en.utf-8.dict'
  local nvim_cmp_dictionary = vim.api.nvim_create_augroup('nvim_cmp_dictionary', { clear = true })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = nvim_cmp_dictionary,
    once = true,
    callback = function()
      require("cmp_dictionary").update()
    end,
  })
end

return M
