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

  -- temporary fix (see https://github.com/stevearc/conform.nvim/pull/766)
  formatters = {
    terragrunt_hclfmt = {
      args = { "hcl", "fmt", "--file", "$FILENAME" }
    }
  }
}

return M
