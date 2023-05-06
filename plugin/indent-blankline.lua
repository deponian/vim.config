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

-- rainbow for context
vim.cmd [[highlight IndentBlanklineIndentContext1 guifg=#ac535a gui=nocombine,bold]]
vim.cmd [[highlight IndentBlanklineIndentContext2 guifg=#ac8d53 gui=nocombine,bold]]
vim.cmd [[highlight IndentBlanklineIndentContext3 guifg=#7a9e61 gui=nocombine,bold]]
vim.cmd [[highlight IndentBlanklineIndentContext4 guifg=#4ea4b1 gui=nocombine,bold]]
vim.cmd [[highlight IndentBlanklineIndentContext5 guifg=#4b83b4 gui=nocombine,bold]]
vim.cmd [[highlight IndentBlanklineIndentContext6 guifg=#945ba4 gui=nocombine,bold]]

require("indent_blankline").setup {
  char = "¦",
  context_char = "¦",
  space_char_blankline = " ",
  show_current_context = true,
  use_treesitter_scope = false,
  viewport_buffer = 100,
  filetype = {
    "yaml", "helm", "yaml.gha",
    "lua", "yaml.ansible", "yaml.docker-compose",
    "javascript", "json"
  },
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
  context_highlight_list = {
    "IndentBlanklineIndentContext1",
    "IndentBlanklineIndentContext2",
    "IndentBlanklineIndentContext3",
    "IndentBlanklineIndentContext4",
    "IndentBlanklineIndentContext5",
    "IndentBlanklineIndentContext6",
  },
  context_patterns = {
    "class",
    "^func",
    "method",
    "^if",
    "while",
    "for",
    "with",
    "try",
    "except",
    "arguments",
    "argument_list",
    "object",
    "dictionary",
    "element",
    "table",
    "tuple",
    "do_block",
    "block_mapping_pair",
  },
}
