local M = {
  'saghen/blink.cmp',
  version = '1.*',

  dependencies = {
    'rafamadriz/friendly-snippets',
    'mikavilpas/blink-ripgrep.nvim',
    'Kaiser-Yang/blink-cmp-dictionary'
  },
}

M.opts = {
  keymap = {
    preset = 'none',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },

    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return
        else
          return cmp.select_next()
        end
      end,
      'snippet_forward',
      'fallback'
    },
    ['<S-Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return
        else
          return cmp.select_prev()
        end
      end,
      'snippet_backward',
      'fallback'
    },

    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
  },

  completion = {
    menu = {
      min_width = 25,
      max_height = 25,
      border = "single",
      winblend = 3,
      draw = {
        treesitter = { 'lsp' },
        columns = { { 'kind_icon' }, { 'label', 'label_description', 'source_id', gap = 1 } },
      }
    },
    documentation = {
      auto_show = true,
      window = {
        min_width = 10,
        max_width = 100,
        max_height = 30,
        border = "single",
        winblend = 3,
      },
    },
    ghost_text = {
      enabled = true,
    },
  },

  sources = {
    default = { 'path', 'lsp', 'snippets', 'buffer', 'dictionary', 'ripgrep' },
    providers = {
      path = {
        score_offset = 3,
        opts = {
          show_hidden_files_by_default = true,
        }
      },
      lsp = {
        fallbacks = { 'buffer', 'dictionary', 'ripgrep' },
        score_offset = 0,
      },
      snippets = {
        score_offset = -1,
      },
      buffer = {
        score_offset = -2,
      },
      dictionary = {
        module = 'blink-cmp-dictionary',
        score_offset = -4,
        min_keyword_length = 3,
        opts = {
          dictionary_files = { vim.fn.stdpath("config") .. '/dictionaries/en.utf-8.dict' },
        }
      },
      ripgrep = {
        module = 'blink-ripgrep',
        score_offset = -5,
      },
    }
  },
}

return M
