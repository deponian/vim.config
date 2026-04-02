-- Convenience wrapper around `:TSInstall [lang]` which installs all
-- configured parsers.
--
-- Run with: `:lua require('deponian.treesitter.install')()`
--
local function install()
  local parsers = require('deponian.treesitter.config').get().parsers
  for _, parser in ipairs(parsers) do
    require('nvim-treesitter').install(parser)
  end
end

return install
