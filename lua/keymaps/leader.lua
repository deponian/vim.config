-- Leader mappings

-- <Leader>q -- exit
vim.keymap.set({"n", "v"}, "<Leader>q", "<cmd>quit<CR>")

-- <Leader>Q -- exit without saving
vim.keymap.set({"n", "v"}, "<Leader>Q", "<cmd>quitall!<CR>")

-- <Leader>w -- save buffer
vim.keymap.set("n", "<Leader>w", "<cmd>write<CR>")

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
vim.keymap.set("n", "<Leader>z", require("deponian.keymaps.leader").zap)

-- <Leader>x -- Replace tabs with spaces or vice versa according to current tabstop, expandtab/noexpandtab and etc.
-- (mnemonic: it is close to "z" where zap mapping lives :D)
vim.keymap.set("n", "<Leader>x", require("deponian.keymaps.leader").retab)

-- <Leader>d -- Set indentation in buffer (change expandtab/noexpandtab, tabstop and etc)
-- (mnemonic: in[d]ent)
vim.keymap.set("n", "<Leader>d", require("deponian.keymaps.leader").set_indent)

-- <Leader>S -- Search WORD under cursor or selected sequence within page
-- (mnemonic: search)
vim.keymap.set("n", "<Leader>S", "g*")
vim.keymap.set("v", "<Leader>S", [[y/\V<C-R>=escape(@",'\/')<CR><CR>]])

-- <Leader>s -- Substitution alias
-- (mnemonic: substitute)
vim.keymap.set("n", "<Leader>s", [[:%s/\v]])
vim.keymap.set("x", "<Leader>s", [[:s/\v]])

-- <Leader>c -- Fold all #-comments in buffer
-- (mnemonic: comment)
vim.keymap.set("n", "<Leader>c", [[:setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*#'\\|\\|getline(v:lnum)=~'^\\s*$'<CR>zM]])

-- <Leader>n -- Remove search highlighting
-- (mnemonic: nohlsearch)
vim.keymap.set("n", "<Leader>n", "<cmd>nohlsearch<CR>")
