-- default
vim.cmd [[highlight IndentBlanklineChar guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineSpaceCharBlankline guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#c75ae8]]
vim.cmd [[highlight IndentBlanklineContextStart gui=underline]]

-- rainbow
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#56292d gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#564629 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#3d4f30 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#275259 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#26425a gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#4a2d52 gui=nocombine]]

require("indent_blankline").setup {
  char = "¦",
  space_char_blankline = " ",
  show_current_context = true,
  filetype = {"yaml", "helm", "yaml.gha"},
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
