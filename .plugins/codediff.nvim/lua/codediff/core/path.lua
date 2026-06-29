-- Path utilities for finding plugin root
-- This provides a stable way to locate the plugin root directory

local M = {}

-- Cache the plugin root once computed
local _plugin_root = nil

--- Get the plugin root directory
--- Uses multiple fallback strategies:
--- 1. Navigate up from this file's location
--- 2. Search runtimepath for the plugin
---@return string plugin_root Absolute path to plugin root
function M.get_plugin_root()
  if _plugin_root then
    return _plugin_root
  end

  -- Strategy 1: Navigate up from this file
  -- lua/codediff/core/path.lua -> 4 levels up to plugin root
  local this_file = debug.getinfo(1, "S").source:sub(2)
  local root = vim.fn.fnamemodify(this_file, ":h:h:h:h")

  -- Validate by checking for a known marker file
  if vim.fn.filereadable(root .. "/VERSION") == 1 then
    _plugin_root = root
    return _plugin_root
  end

  -- Strategy 2: Search runtimepath for our plugin
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if path:match("vscode%-diff%.nvim$") or path:match("vscode%-diff$") or path:match("codediff%.nvim$") or path:match("codediff$") then
      if vim.fn.filereadable(path .. "/VERSION") == 1 then
        _plugin_root = path
        return _plugin_root
      end
    end
  end

  -- Fallback: use the navigation result even if marker not found
  _plugin_root = root
  return _plugin_root
end

return M
