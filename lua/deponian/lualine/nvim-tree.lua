local M = {}

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

M.sections = {
  lualine_a = { get_short_cwd },
  lualine_b = { { 'branch', icon = '' } },
}

M.filetypes = { 'NvimTree' }

return M
