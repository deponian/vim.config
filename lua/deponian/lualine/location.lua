local function location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')
  local total = vim.fn.line('$')
  return string.format('%d%%%% %d/%d %d', math.floor(line / total * 100), line, total, col)
end

return location
