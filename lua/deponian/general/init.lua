local M = {}

function M.get_oneline_selection()
  local start = vim.fn.getpos("v")
  local finish = vim.fn.getcurpos()
  local lines = math.abs(finish[2] - start[2]) + 1
  if lines == 1 then
    local line = vim.api.nvim_buf_get_lines(0, start[2] - 1, finish[2], false)[1]
    return string.sub(line, start[3], finish[3])
  else
    return 'multiline is not supported'
  end
end

return M
