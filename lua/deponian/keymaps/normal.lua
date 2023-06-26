local M = {}

function M.cycle_through_windows()
  -- jump to the next window
  vim.cmd([[execute "normal! \<C-w>w"]])

  -- count number of all non floating windows on current tab
  local non_floating_windows = 0
  for _, window in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    -- https://neovim.io/doc/user/api.html#api-floatwin
    if vim.api.nvim_win_get_config(window).relative == '' then
      non_floating_windows = non_floating_windows + 1
    end
  end

  -- don't focus on nvimtree if there is nvimtree and more then one other window
  if require("nvim-tree.api").tree.is_tree_buf() and non_floating_windows > 2 then
    vim.cmd([[execute "normal! \<C-w>w"]])
  end
end

function M.git_show_file_versions()
  if vim.bo.filetype == "NvimTree" then
    print("Choose not nvimtree window")
  else
    local mapping_qf = vim.api.nvim_create_augroup("mapping_qf", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = mapping_qf,
      pattern = "qf",
      callback = function(args)
        vim.keymap.set("n", "<CR>", "<CR>:copen<CR>", { buffer = args.buf, silent = true })
      end
    })
    vim.cmd('vsplit')
    vim.cmd('0Gclog')
    vim.cmd('copen 7')
  end
end

function M.toggle_diff()
  require('nvim-tree.api').tree.close()
  vim.cmd('cclose')
  if vim.wo.diff then
    vim.cmd('windo diffoff')
  else
    vim.cmd('windo diffthis')
  end
end

return M
