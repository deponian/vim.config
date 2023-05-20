local function fmt_and_enc()
  local enc = vim.opt.fileencoding:get()
  local format = vim.bo.fileformat
  if enc ~= 'utf-8' or format ~= 'unix' then
    return string.format('%s[%s]', enc, format)
  else
    return ""
  end
end

return fmt_and_enc
