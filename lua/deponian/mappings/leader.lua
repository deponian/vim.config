-- Zap trailing whitespace.
local M = {}

function M.zap()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
  print("All trailing whitespaces were zapped")
end

function M.set_indent()
  local mode = vim.fn.input("Set mode [t|s][2-8]: ")
  if mode == "" then
    vim.cmd("redraw")
    local expandtab = vim.bo.expandtab and "expandtab" or "noexpandtab"
    print(expandtab .. " ts=" .. vim.bo.ts .. " sts=" .. vim.bo.sts .. " sw=" .. vim.bo.sw)
    return
  end
  local whitespace = mode:sub(1,1)
  local width = mode:sub(2,2)

  if whitespace == "t" then
    vim.bo.expandtab = false
  elseif whitespace == "s" then
    vim.bo.expandtab = true
  else
    vim.cmd("redraw")
    print([[First character has to be "t" or "s"]])
    return
  end

  if width:match("[2-8]") then
    vim.bo.tabstop = tonumber(width)
    vim.bo.softtabstop = tonumber(width)
    vim.bo.shiftwidth = tonumber(width)
  else
    vim.cmd("redraw")
    print("Width has to be between 2 and 8")
    return
  end

  vim.cmd("redraw")
  if whitespace == "t" then
    print("noexpandtab ts=" .. width .. " sts=" .. width .. " sw=" .. width)
  else
    print("expandtab ts=" .. width .. " sts=" .. width .. " sw=" .. width)
  end
end

-- Retab spaced file, but only indentation
-- thanks to DrAI: https://stackoverflow.com/questions/5144284/force-vi-vim-to-use-leading-tabs-only-on-retab/5144480#5144480
function M.retab()
  local saved_view = vim.fn.winsaveview()
  local spaces = string.rep(" ", vim.bo.tabstop)
  if vim.bo.expandtab then
    vim.cmd([[silent! execute '%substitute#^\%(\t\)\+#\=repeat("]] .. spaces .. [[", len(submatch(0)))#']])
  else
    vim.cmd([[silent! execute '%substitute#^\%(]] .. spaces .. [[\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#']])
  end
  vim.fn.winrestview(saved_view)
  print("Retabed successfully")
end

return M
