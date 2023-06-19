-- Normal mode mappings

-- Disable Shift + Right Mouse search
vim.keymap.set("n", "<S-RightMouse>", "<Nop>")

-- Disable Shift + Up and Shift + Down
vim.keymap.set("n", "<S-Up>", "<Nop>")
vim.keymap.set("n", "<S-Down>", "<Nop>")

-- Move between windows (splits)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Cycle through windows (splits)
vim.keymap.set("n", "<Tab>", require("deponian.mappings.normal").cycle_through_windows)
vim.keymap.set("n", ";", function()
  require("nvim-tree.api").tree.focus()
end)

-- Disable vim command line window
vim.keymap.set("n", "q:", "<Nop>")
vim.keymap.set("n", "q/", "<Nop>")
vim.keymap.set("n", "q?", "<Nop>")

-- Delete without changing any registers
vim.keymap.set("n", "D", '"_D')

-- Toggle list (display unprintable characters)
vim.keymap.set("n", "<F2>", "<cmd>set list!<CR>")

-- Toggle between number and nonumber
vim.keymap.set("n", "<F3>", "<cmd>set invnumber<CR>")

-- Toggle between spell and nospell
vim.keymap.set("n", "<F4>", "<cmd>setlocal spell! spelllang=en<CR>")

-- Reload file from disk
vim.keymap.set("n", "<F5>", "<cmd>edit!<CR>", {silent = true})

-- Show different version of current file
vim.keymap.set("n", "<F6>", require("deponian.mappings.normal").git_show_file_versions, {silent = true})

-- Toggle diff mode for all windows
vim.keymap.set("n", "<F7>", require("deponian.mappings.normal").toggle_diff, {silent = true})

-- Hide all diagnostic messages
vim.keymap.set("n", "<F8>", vim.diagnostic.hide, {silent = true})

-- Now Ctrl-C is not useless
vim.keymap.set("n", "<C-c>", "<Esc>")

-- Move J command away
vim.keymap.set("n", "J", "<Nop>")
vim.keymap.set("n", "<Leader>j", "J")

-- Open NvimTree file explorer
vim.keymap.set("n", "`", function()
  require("nvim-tree.api").tree.toggle()
end, {silent = true})
vim.keymap.set("n", "~", function()
  require("nvim-tree.api").tree.toggle({path = vim.fn.expand("%:p:h")})
end, {silent = true})

-- Next item in quickfix list
vim.keymap.set("n", "<M-.>", ":cnext<CR>")

-- Previous item in quickfix list
vim.keymap.set("n", "<M-,>", ":cprevious<CR>")

