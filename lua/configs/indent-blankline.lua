local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = vim.o.background == "dark"
}

M.opts = {
  indent = {
    char = "¦",
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
  },
  scope = {
    show_start = false,
    show_end = false,
    highlight = {
      "IndentBlanklineIndentContext1",
      "IndentBlanklineIndentContext2",
      "IndentBlanklineIndentContext3",
      "IndentBlanklineIndentContext4",
      "IndentBlanklineIndentContext5",
      "IndentBlanklineIndentContext6",
    },
    include = {
      node_type = {
        yaml = { "*" },
      },
    },
  },
}

M.config = function(_, opts)
  -- rainbow
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#56292d gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#564629 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#3d4f30 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#275259 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#26425a gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#4a2d52 gui=nocombine]]

  -- rainbow for context
  vim.cmd [[highlight IndentBlanklineIndentContext1 guifg=#ac535a gui=nocombine,bold]]
  vim.cmd [[highlight IndentBlanklineIndentContext2 guifg=#ac8d53 gui=nocombine,bold]]
  vim.cmd [[highlight IndentBlanklineIndentContext3 guifg=#7a9e61 gui=nocombine,bold]]
  vim.cmd [[highlight IndentBlanklineIndentContext4 guifg=#4ea4b1 gui=nocombine,bold]]
  vim.cmd [[highlight IndentBlanklineIndentContext5 guifg=#4b83b4 gui=nocombine,bold]]
  vim.cmd [[highlight IndentBlanklineIndentContext6 guifg=#945ba4 gui=nocombine,bold]]

  require("ibl").setup(opts)
end

return M
