-- add signs in diff mode
if not vim.g.diff_mode then return end

vim.fn.sign_define("DiffChange", { text = "~", texthl = "WarningMsg" })

local function place_diff_signs()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_is_valid(win) and vim.wo[win].diff then
      local buf = vim.api.nvim_win_get_buf(win)
      vim.fn.sign_unplace("diff_signs", { buffer = buf })

      vim.api.nvim_win_call(win, function()
        for lnum = 1, vim.api.nvim_buf_line_count(buf) do
          if vim.fn.foldclosed(lnum) == -1 then
            local synID = vim.fn.diff_hlID(lnum, 1)
            local hlname = vim.fn.synIDattr(synID, "name")
            if hlname == "DiffChange" or hlname == "DiffText" then
              vim.fn.sign_place(0, "diff_signs", "DiffChange", buf, { lnum = lnum })
            end
          end
        end
      end)
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "DiffUpdated", "WinEnter", "InsertLeave", "CursorHold" }, {
  callback = function()
    vim.defer_fn(place_diff_signs, 50)
  end,
})
