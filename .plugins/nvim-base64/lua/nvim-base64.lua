local M = {}

local base64 = require("base64")

local function get_oneline_selection()
  local start = vim.fn.getpos("v")
  local finish = vim.fn.getcurpos()
  local n_lines = math.abs(finish[2] - start[2]) + 1
  if n_lines == 1 then
    local line = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)[1]
    return string.sub(line, start[3], finish[3])
  else
    local lines = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)
    lines[1] = string.sub(lines[1], start[3], -1)
    lines[n_lines] = string.sub(lines[n_lines], 1, finish[3])
    return table.concat(lines, '\n')
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
    vim.cmd("normal! gvc")
    -- replace text with encoded
    vim.api.nvim_put(vim.split(data, "\n"), "c", true, true)
  end
end

function M.setup()
  vim.keymap.set('x', '<Plug>(ToBase64)', wrapper(base64.encode))
  vim.keymap.set('x', '<Plug>(FromBase64)', wrapper(base64.decode))
end

return M
