local M = {
  "lewis6991/gitsigns.nvim",
  lazy = false,
}

M.opts = {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_', show_count = true },
    topdelete    = { text = '‾', show_count = true },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  count_chars = {
    [1]   = '₁',
    [2]   = '₂',
    [3]   = '₃',
    [4]   = '₄',
    [5]   = '₅',
    [6]   = '₆',
    [7]   = '₇',
    [8]   = '₈',
    [9]   = '₉',
    ['+'] = '₊',
  },
  current_line_blame = true,
  preview_config = {
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

M.keys = {
  -- <Leader>hp -- Preview the hunk in the floating window
  -- (mnemonic: [h]unk [p]review)
  { "<Leader>hp", "<cmd>Gitsigns preview_hunk<CR>", silent = true },
  -- <Leader>hP -- Preview the hunk inline
  -- (mnemonic: [h]unk [p]review)
  { "<Leader>hP", "<cmd>Gitsigns preview_hunk_inline<CR>", silent = true },
  -- <Leader>hw -- Toggle word diff for hunks
  -- (mnemonic: [h]unk [w]ord diff)
  { "<Leader>hw", "<cmd>Gitsigns toggle_word_diff<CR>", silent = true },
  -- <Leader>hd -- Toggle deleted hunks
  -- (mnemonic: [h]unk [d]eleted)
  { "<Leader>hd", "<cmd>Gitsigns toggle_deleted<CR>", silent = true },
  -- <Leader>hu -- Undo the hunk
  -- (mnemonic: [h]unk [u]ndo)
  { "<Leader>hu", "<cmd>Gitsigns reset_hunk<CR>", silent = true },
}

return M
