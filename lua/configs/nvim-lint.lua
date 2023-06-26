local M = { "mfussenegger/nvim-lint" }

M.config = function ()
  require('lint').linters_by_ft = {
    yaml = {'yamllint'},
    ["yaml.gha"] = {'yamllint'},
    dockerfile = {'hadolint'}
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
  local yamllint = require('lint').linters.yamllint
  yamllint.args = {
    "--format",
    "parsable",
    "-c",
    get_config,
    "-"
  }

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave", "BufEnter" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return M
