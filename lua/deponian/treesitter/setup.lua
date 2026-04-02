-- Map from parsers to filetypes.
local filetypes = {
  bash = 'sh',
  git_config = 'gitconfig',
  markdown_inline = 'markdown',
  query = 'scheme',
  ssh_config = 'sshconfig',
  vimdoc = 'help',
}

local function setup(config)
  require('deponian.treesitter.config').set(config)

  -- Convert parser names to filetypes:
  local pattern = {}
  for _, parser in ipairs(config.parsers) do
    if filetypes[parser] then
      pattern[filetypes[parser]] = true
    else
      pattern[parser] = true
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = table.concat(vim.tbl_keys(pattern), ','),
    callback = function() vim.treesitter.start() end,
  })
end

return setup
