local function modified()
  return vim.bo.modified and "+" or ""
end

return modified
