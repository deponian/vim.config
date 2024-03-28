local M = { "stevearc/conform.nvim" }

M.opts = {
  formatters_by_ft = {
    terraform = { "terraform_fmt" },
    hcl = { "terragrunt_hclfmt" },
    go = { "goimports", "gofumpt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
  },
}

return M
