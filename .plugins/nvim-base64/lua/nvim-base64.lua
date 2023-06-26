local M = {}

local base64 = require("base64")

local function get_oneline_selection()
  local start = vim.fn.getpos("v")
  local finish = vim.fn.getcurpos()
  local lines = math.abs(finish[2] - start[2]) + 1
  if lines == 1 then
    local line = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)[1]
    return string.sub(line, start[3], finish[3])
  else
    error("multiline is not supported")
  end
end

-- run base64.decode/base64.encode with selected string
local function wrapper(action)
  return function()
    local ok, selection = pcall(get_oneline_selection)
    if not ok then
      print("[nvim-base64] Multiline selection is not supported")
      return
    end
    local ok, data = pcall(action, selection)
    if not ok then
      print("[nvim-base64] Selected string is invalid")
      return
    end
    -- leave visual mode
    vim.cmd([[execute "normal! \<esc>"]])
    -- reselect the area
    vim.cmd("normal! gv")
    -- replace text with encoded
    vim.cmd([[execute "normal! c]] .. data .. [[\<esc>"]])
  end
end

function M.setup()
  vim.keymap.set('x', '<Plug>(ToBase64)', wrapper(base64.encode))
  vim.keymap.set('x', '<Plug>(FromBase64)', wrapper(base64.decode))
end

return M
