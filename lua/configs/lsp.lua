local M = {
  "neovim/nvim-lspconfig",
  enabled = not vim.g.bigfile_mode,
}

M.config = function ()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('OnAttach', {}),
    callback = function(args)
      vim.keymap.set('n', '<Leader>ld', "<cmd>lua vim.diagnostic.open_float()<CR>", {buffer = args.buf, silent = true})
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = args.buf, silent = true})
      vim.keymap.set('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>", {buffer = args.buf, silent = true})
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {buffer = args.buf, silent = true})
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = args.buf, silent = true})

      -- disable diagnostics for .env files
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if string.match(bufname, '%.env') then
        vim.diagnostic.enable(false, { bufnr = args.buf })
      end

      -- disable diagnostics in diff mode
      if vim.o.diff then
        vim.diagnostic.enable(false, { bufnr = args.buf })
      end
    end,
  })

  vim.diagnostic.config({
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    virtual_lines = { current_line = true },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.WARN] = " ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      },
    },
  })

  -- servers
  vim.lsp.enable('bashls')
  vim.lsp.enable('gopls')
  vim.lsp.enable('jsonls')
  vim.lsp.enable('pyright')
  vim.lsp.enable('terraformls')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('typos_lsp')

  vim.lsp.config('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }
        }
      })
    end,
    settings = {
      Lua = {
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          }
        },
        telemetry = {
          enable = false,
        },
      }
    }
  })
  vim.lsp.enable('lua_ls')
end

return M
