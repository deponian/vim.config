local function get_yaml_key()
  if vim.bo.filetype ~= "yaml" then
    return ""
  end

  local yaml_key = require("yaml_nvim").get_yaml_key()
  if yaml_key ~= nil then
    return yaml_key
  else
    return ""
  end
end

return get_yaml_key
