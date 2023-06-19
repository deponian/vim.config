-- Leader mappings

-- <Leader>q -- exit
vim.keymap.set({"n", "v"}, "<Leader>q", "<cmd>quit<CR>")

-- <Leader>Q -- exit without saving
vim.keymap.set({"n", "v"}, "<Leader>Q", "<cmd>quitall!<CR>")

-- <Leader>w -- save buffer
vim.keymap.set("n", "<Leader>w", "<cmd>write<CR>")

-- <Leader>W -- save buffer with sudo
vim.keymap.set("n", "<Leader>W", "<cmd>write suda://%<CR>")

-- <Leader>b/<Leader>B -- cycle through buffers
vim.keymap.set("n", "<Leader>b", "<cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>B", "<cmd>bprevious<CR>")

-- <Leader>D -- delete buffer
-- (mnemonic: [d]elete)
vim.keymap.set("n", "<Leader>D", "<cmd>bdelete<CR>")

-- <Leader><Tab>/<Leader><S-Tab> -- cycle through tabs
vim.keymap.set("n", "<Leader><Tab>", "gt", {silent = true})
vim.keymap.set("n", "<Leader><S-Tab>", "gT", {silent = true})

-- <Leader>y/<Leader>p -- copy to and paste from clipboard
vim.keymap.set("n", "<Leader>y", '"+y')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("v", "<Leader>y", '"+y')
vim.keymap.set("v", "<Leader>p", '"+p')

-- <Leader>z -- Zap trailing whitespace in the current buffer
-- (mnemonic: zap)
vim.keymap.set("n", "<Leader>z", require("deponian.mappings.leader").zap)

-- <Leader>x -- Replace tabs with spaces or vice versa according to current tabstop, expandtab/noexpandtab and etc.
-- (mnemonic: it is close to "z" where zap mapping lives :D)
vim.keymap.set("n", "<Leader>x", require("deponian.mappings.leader").retab)

-- <Leader>t -- Find and open file
vim.keymap.set("n", "<Leader>t", function()
  require("fzf-lua").files()
end, {silent = true})
vim.keymap.set("n", "<Leader>T", ":lua require('fzf-lua').files({cwd = ''})<Left><Left><Left>")

-- <Leader>d -- Set indentation in buffer (change expandtab/noexpandtab, tabstop and etc)
-- (mnemonic: in[d]ent)
vim.keymap.set("n", "<Leader>d", require("deponian.mappings.leader").set_indent)

-- <Leader>s -- Search WORD under cursor or selected sequence within page
-- (mnemonic: search)
vim.keymap.set("n", "<Leader>s", "g*")
vim.keymap.set("v", "<Leader>s", [[y/\V<C-R>=escape(@",'\/')<CR><CR>]])

-- <Leader>S -- Substitution alias
-- (mnemonic: substitute)
vim.keymap.set("n", "<Leader>S", ":%s/")

-- <Leader>f -- Recursively find WORD under cursor or selected sequence in all files in a directory tree
-- (mnemonic: find)
vim.keymap.set("n", "<Leader>f", function()
  require("deponian.fzf-lua").live_grep()
end)
vim.keymap.set("v", "<Leader>f", function()
  require('deponian.fzf-lua').live_grep({ search = require('deponian.general').get_oneline_selection() })
end, {silent = true})

-- <Leader>r -- Replace WORD or selected sequence within page
-- (mnemonic: replace)
vim.keymap.set("v", "<Leader>r", "<Plug>(Scalpelua)")
vim.keymap.set("v", "<Leader>R", "<Plug>(ScalpeluaMultiline)")

-- <Leader>F -- Open file under cursor in new tab
-- (mnemonic: file)
vim.keymap.set("n", "<Leader>F", "<C-W>gf")

-- <Leader>n -- Disable highlighting of search results
-- (mnemonic: [n]o highlighting)
vim.keymap.set("n", "<Leader>n", "<Plug>(LoupeClearHighlight)")

-- <Leader>c -- Fold all #-comments in buffer
-- (mnemonic: comment)
vim.keymap.set("n", "<Leader>c", [[:setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*#'\\|\\|getline(v:lnum)=~'^\\s*$'<CR>zM]])

-- <Leader>hP -- Preview the hunk in the floating window
-- (mnemonic: hunk preview)
vim.keymap.set("n", "<Leader>hp", "<cmd>Gitsigns preview_hunk<CR>", {silent = true})

-- <Leader>hp -- Preview the hunk inline
-- (mnemonic: hunk preview)
vim.keymap.set("n", "<Leader>hP", "<cmd>Gitsigns preview_hunk_inline<CR>", {silent = true})

-- <Leader>hw -- Toggle word diff for hunks
-- (mnemonic: hunk word diff)
vim.keymap.set("n", "<Leader>hw", "<cmd>Gitsigns toggle_word_diff<CR>", {silent = true})

-- <Leader>hd -- Toggle deleted hunks
-- (mnemonic: hunk deleted)
vim.keymap.set("n", "<Leader>hd", "<cmd>Gitsigns toggle_deleted<CR>", {silent = true})

-- <Leader>hu -- Undo the hunk
-- (mnemonic: hunk undo)
vim.keymap.set("n", "<Leader>hu", "<cmd>Gitsigns reset_hunk<CR>", {silent = true})

-- <Leader>b -- Decode selected sequence from base64
-- (mnemonic: [b]ase64)
vim.keymap.set("v", "<Leader>b", "<cmd>FromBase64<CR>")

-- <Leader>B -- Encode selected sequence to base64
-- (mnemonic: [b]ase64)
vim.keymap.set("v", "<Leader>B", "<cmd>ToBase64<CR>")

-- <Leader>m -- Toggle minimap
-- (mnemonic: mini[m]ap)
vim.keymap.set("n", "<Leader>m", function()
  MiniMap.toggle()
end)

-- <Leader>u -- Toggle Trouble plugin
-- (mnemonic: tro[u]ble)
vim.keymap.set("n", "<Leader>u", "<cmd>TroubleToggle<CR>")

-- <Leader>a -- ChatGPT integration
-- (mnemonic: [a]rtificial intelligence)
vim.keymap.set("n", "<Leader>a", ":AI<Space>")
vim.keymap.set("v", "<Leader>a", ":AIEdit<Space>")

-- <Leader>g -- git commands
-- mnemonic: [g]it [l]s-files
vim.keymap.set("n", "<Leader>gl", "<cmd>lua require('fzf-lua').git_files()<CR>")
-- mnemonic: [g]it [s]tatus
vim.keymap.set("n", "<Leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>")
-- mnemonic: [g]it [c]ommits
vim.keymap.set("n", "<Leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>")
-- mnemonic: [g]it [h]istory
vim.keymap.set("n", "<Leader>gh", "<cmd>lua require('fzf-lua').git_bcommits()<CR>")
-- mnemonic: [g]it [b]ranches
vim.keymap.set("n", "<Leader>gb", "<cmd>lua require('fzf-lua').git_branches()<CR>")

