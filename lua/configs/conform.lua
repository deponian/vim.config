local M = { "stevearc/conform.nvim" }

M.opts = {
  formatters_by_ft = {
    terraform = { "terraform_fmt" },
    hcl = { "terragrunt_hclfmt" },
    go = { "goimports-reviser", "gofumpt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
  },
}

M.config = function(_, opts)
  require("conform").setup(opts)
  require("conform").formatters["goimports-reviser"] = {
    prepend_args = { "-rm-unused" },
  }
end

return M
