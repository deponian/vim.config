local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function ()
  vim.keymap.set('n', '<Leader>ld', "<cmd>lua vim.diagnostic.open_float()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = true, silent = true})
  vim.keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", {buffer = true, silent = true})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {buffer = true, silent = true})

  vim.wo.signcolumn = 'yes'
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
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

require('lspconfig').bashls.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}

require('lspconfig').dockerls.setup{
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

require('lspconfig').yamlls.setup{
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}
