local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function ()
  vim.keymap.set('n', '<Leader>ld', "<cmd>lua vim.diagnostic.open_float()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = true, silent = true})
  vim.keymap.set('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {buffer = true, silent = true})
end

-- UI tweaks from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
local border = {
  {"╭", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╮", "FloatBorder"},
  {"│", "FloatBorder"},
  {"╯", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╰", "FloatBorder"},
  {"│", "FloatBorder"}
}
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- servers
require'lspconfig'.ansiblels.setup{
  capabilities = capabilities,
  handlers = handlers,
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
}

require('lspconfig').bashls.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}

require('lspconfig').gopls.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}

require('lspconfig').jsonls.setup{
  capabilities = capabilities,
  cmd = { "vscode-json-languageserver", "--stdio"},
  handlers = handlers,
  on_attach = on_attach,
}

require('lspconfig').pyright.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}

require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = {
    Lua = {
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
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig').terraformls.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}
