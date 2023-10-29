-- Visual mode mappings

-- Apply sane pattern syntax by default
vim.keymap.set("x", "/", [[/\v]])
vim.keymap.set("x", "?", [[?\v]])

-- Move between splits
vim.keymap.set("x", "<C-h>", "<C-w>h")
vim.keymap.set("x", "<C-j>", "<C-w>j")
vim.keymap.set("x", "<C-k>", "<C-w>k")
vim.keymap.set("x", "<C-l>", "<C-w>l")

-- Disable Shift + Right Mouse search
vim.keymap.set("x", "<S-RightMouse>", "<Nop>")

-- Disable Shift + Up and Shift + Down
vim.keymap.set("x", "<S-Up>", "<Nop>")
vim.keymap.set("x", "<S-Down>", "<Nop>")

-- Move J command away
vim.keymap.set("x", "J", "<Nop>")
vim.keymap.set("x", "<Leader>j", "J")
