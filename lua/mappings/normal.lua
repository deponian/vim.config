local M = {}

local nvimtree_api = require("nvim-tree.api")

function M.cycle_through_windows()
  vim.cmd([[execute "normal! \<C-w>w"]])
  if nvimtree_api.tree.is_tree_buf() and #vim.api.nvim_list_wins() > 2 then
    vim.cmd([[execute "normal! \<C-w>w"]])
  end
end

return M
