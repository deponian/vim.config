local M = {
  "rrethy/vim-illuminate",
  lazy = false,
  enabled = not vim.g.bigfile_mode,
}

M.opts = {
  filetypes_denylist = {
    "fugitive",
    "NvimTree",
  },
}

M.config = function(_, opts)
  require("illuminate").configure(opts)
  vim.cmd [[highlight IlluminatedWordText guifg=#f2cc81 gui=bold]]
  vim.cmd [[highlight IlluminatedWordRead guifg=#f2cc81 gui=bold]]
  vim.cmd [[highlight IlluminatedWordWrite guifg=#f2cc81 gui=bold]]
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
