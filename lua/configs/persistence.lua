local M = {
  "folke/persistence.nvim",
  enabled = not (next(vim.fn.argv()) ~= nil)
}

M.opts = {
  options = { "blank", "buffers", "curdir", "folds", "tabpages", "winsize", "winpos" },
  pre_save = function ()
    require("nvim-tree.api").tree.close()
  end,
  pre_load = function ()
    require("nvim-tree.api").tree.close()
  end,
  post_load = function ()
    require("nvim-tree.api").tree.open()
  end,
}

M.config = function(_, opts)
  require("persistence").setup(opts)
  require("persistence").load()
end

return M
