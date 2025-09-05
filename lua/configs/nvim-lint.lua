local M = { "mfussenegger/nvim-lint" }

M.config = function ()
  require("lint").linters_by_ft = {
    go = {"golangcilint"},
    yaml = {"yamllint"},
    ["yaml.gha"] = {"actionlint", "yamllint"},
    dockerfile = {"hadolint"},
    terraform = {"tflint"},
  }

  -- change config for different filetypes
  local function get_config()
    if vim.bo.filetype == "yaml.gha" then
      return os.getenv("HOME") .. "/.config/yamllint/config.gha"
    else
      return os.getenv("HOME") .. "/.config/yamllint/config"
    end
  end

  -- reconfigure yamllint
  local yamllint = require("lint").linters.yamllint
  yamllint.args = {
    "--format",
    "parsable",
    "-c",
    get_config,
    "-"
  }

  vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufEnter", "CursorHold", "CursorHoldI" }, {
    callback = function()
      require("lint").try_lint()
      -- do not run codespell in server mode
      if not vim.g.server_mode then
        require("lint").try_lint("codespell")
      end
    end,
  })
end

return M
