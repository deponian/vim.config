local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    }
}

local signs = {
  ERROR = " ",
  WARN = " ",
  INFO = " ",
  HINT = " ",
}

local on_attach = function (_, bufnr)
  vim.keymap.set('n', '<Leader>ld', "<cmd>lua vim.diagnostic.open_float()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = true, silent = true})
  vim.keymap.set('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {buffer = true, silent = true})
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = true, silent = true})
  vim.wo.signcolumn = 'yes'

  -- disable diagnostics for .env files
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if string.match(bufname, '%.env') then
    vim.diagnostic.enable(false, { bufnr = bufnr })
  end

  -- disable diagnostics in diff mode
  if vim.o.diff then
    vim.diagnostic.enable(false, { bufnr = bufnr })
  end
end

M.config = function ()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities()
  end

  vim.diagnostic.config({
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    virtual_lines = { current_line = true },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.ERROR,
        [vim.diagnostic.severity.HINT] = signs.HINT,
        [vim.diagnostic.severity.INFO] = signs.INFO,
        [vim.diagnostic.severity.WARN] = signs.WARN,
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
  require("lspconfig").ansiblels.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ansible = {
        python = {
          interpreterPath = 'python',
        },
        ansible = {
          path = 'ansible',
        },
        executionEnvironment = {
          enabled = false,
        },
        validation = {
          enabled = true,
          lint = {
            enabled = true,
            path = "ansible-lint"
          }
        },
      },
    },
  })

  require("lspconfig").bashls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require("lspconfig").gopls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  })

  require("lspconfig").jsonls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    cmd = { "vscode-json-language-server", "--stdio"},
    on_attach = on_attach,
  })

  require("lspconfig").pyright.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require("lspconfig").lua_ls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          }
        },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
          ignoreDir = {".plugins"}
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  require("lspconfig").terraformls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require("lspconfig").ts_ls.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require("lspconfig").typos_lsp.setup({
    enabled = not vim.g.server_mode,
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return M
