-- default
vim.cmd [[highlight IndentBlanklineChar guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineSpaceCharBlankline guifg=#2f3a52]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#c75ae8]]
vim.cmd [[highlight IndentBlanklineContextStart gui=underline]]

-- rainbow
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#803d43 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#b39660 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#7b9e62 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#387780 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#3f7099 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#7d4c8c gui=nocombine]]

require("indent_blankline").setup {
  char = "¦",
  space_char_blankline = " ",
  show_current_context = true,
  filetype = {"yaml", "yaml.helm"},
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
