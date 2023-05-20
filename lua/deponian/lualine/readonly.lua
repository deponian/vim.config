local function readonly()
  if vim.bo.modifiable == false or vim.bo.readonly == true then
    return "⊝ "
  else
    return ""
  end
end

return readonly
