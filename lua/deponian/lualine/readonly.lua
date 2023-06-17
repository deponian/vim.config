local function readonly()
  -- specific filetypes
  if vim.bo.filetype == "help" then
    return ""
  end

  -- general file
  if vim.bo.modifiable == false or vim.bo.readonly == true then
    return "⊝ "
  else
    return ""
  end
end

return readonly
