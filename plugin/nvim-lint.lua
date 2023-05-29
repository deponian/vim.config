require('lint').linters_by_ft = {
  yaml = {'yamllint'},
  ["yaml.gha"] = {'yamllint'},
  dockerfile = {'hadolint'}
}

-- reconfigure yamllint
local function get_config()
  if vim.bo.filetype == "yaml.gha" then
    return os.getenv("HOME") .. "/.config/yamllint/config.gha"
  else
    return os.getenv("HOME") .. "/.config/yamllint/config"
  end
end
local yamllint = require('lint').linters.yamllint
yamllint.stdin = true
yamllint.stream = 'stdout'
yamllint.args = {
  "--format",
  "parsable",
  "-c",
  get_config,
  "-"
}
-- stdin:line:col: [severity] message (code)
local pattern = 'stdin:(%d+):(%d+): %[(.+)%] (.+) %((.+)%)'
local groups = { 'lnum', 'col', 'severity', 'message', 'code' }
local severities = {
  ['error'] = vim.diagnostic.severity.ERROR,
  ['warning'] = vim.diagnostic.severity.WARN,
}
yamllint.parser =  require('lint.parser').from_pattern(pattern, groups, severities, {
  ['source'] = 'yamllint'
})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave", "BufEnter" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
