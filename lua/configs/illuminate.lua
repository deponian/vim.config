local M = {
  "rrethy/vim-illuminate",
  lazy = false,
}

M.opts = {
  filetypes_denylist = {
    "fugitive",
    "NvimTree",
  },
}

M.config = function(_, opts)
  require("illuminate").configure(opts)
  vim.cmd [[highlight IlluminatedWordText guibg=#283347 gui=bold]]
  vim.cmd [[highlight IlluminatedWordRead guibg=#283347 gui=bold]]
  vim.cmd [[highlight IlluminatedWordWrite guibg=#283347 gui=bold]]
end

M.keys = {
  {
    "<Leader>.",
    function()
      require("illuminate").goto_next_reference()
    end
  },
  {
    "<Leader>,",
    function()
      require("illuminate").goto_prev_reference()
    end
  },
}

return M
