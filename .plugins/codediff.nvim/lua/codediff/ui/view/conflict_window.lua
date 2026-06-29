-- Conflict result window setup for merge tool
local M = {}

local lifecycle = require("codediff.ui.lifecycle")
local auto_refresh = require("codediff.ui.auto_refresh")
local config = require("codediff.config")
local layout = require("codediff.ui.layout")

--- Create result window at the bottom (default layout)
--- Layout: [incoming | current] on top, [result] at bottom
--- @param modified_win number
--- @param original_win number
--- @return number result_win
local function create_bottom_layout(modified_win, original_win)
  local scratch = vim.api.nvim_create_buf(false, true)
  local result_win = vim.api.nvim_open_win(scratch, true, { split = "below", win = modified_win })

  vim.fn.win_splitmove(original_win, modified_win, { vertical = true, rightbelow = false })

  return result_win
end

--- Create result window in the center (three vertical panes side-by-side)
--- Layout: [incoming | result | current] all side-by-side
--- @param modified_win number
--- @param original_win number
--- @return number result_win
local function create_center_layout(modified_win, original_win)
  local orig_col = vim.api.nvim_win_get_position(original_win)[2]
  local mod_col = vim.api.nvim_win_get_position(modified_win)[2]
  local left_win = orig_col <= mod_col and original_win or modified_win

  local scratch = vim.api.nvim_create_buf(false, true)
  local result_win = vim.api.nvim_open_win(scratch, true, { split = "right", win = left_win })

  return result_win
end

-- Common logic: Setup conflict result window
-- Creates the result window layout and loads the real file with BASE content
-- @param tabpage number: Current tabpage
-- @param session_config SessionConfig: Session configuration
-- @param original_win number: Original (left) window
-- @param modified_win number: Modified (right) window
-- @param base_lines table: BASE content lines
-- @param conflict_diffs table: Conflict diff results
-- @param is_update boolean: true if updating existing view (may reuse result window)
-- @return boolean: success
function M.setup_conflict_result_window(tabpage, session_config, original_win, modified_win, base_lines, conflict_diffs, is_update)
  local abs_path = session_config.git_root .. "/" .. session_config.original_path
  local result_win, result_bufnr

  -- Check if result window already exists (only in update mode)
  if is_update then
    local existing_result_bufnr, existing_result_win = lifecycle.get_result(tabpage)
    if existing_result_win and vim.api.nvim_win_is_valid(existing_result_win) then
      result_win = existing_result_win
      vim.api.nvim_set_current_win(result_win)
    end
  end

  -- Create result window if it doesn't exist
  if not result_win then
    local position = config.options.diff.conflict_result_position
    if position == "center" then
      result_win = create_center_layout(modified_win, original_win)
    else
      result_win = create_bottom_layout(modified_win, original_win)
    end
  end

  -- Load real file buffer in result window
  -- Use silent and swapfile handling to avoid prompts
  local old_shortmess = vim.o.shortmess
  vim.o.shortmess = old_shortmess .. "A"
  local ok, err = pcall(vim.cmd, "silent edit " .. vim.fn.fnameescape(abs_path))
  vim.o.shortmess = old_shortmess

  if not ok then
    vim.notify("Failed to open result file: " .. tostring(err), vim.log.levels.ERROR)
    return false
  end

  result_bufnr = vim.api.nvim_get_current_buf()

  -- Reset buffer content to BASE (only if buffer has conflict markers)
  local current_content = vim.api.nvim_buf_get_lines(result_bufnr, 0, -1, false)
  local has_conflict_markers = false
  for _, line in ipairs(current_content) do
    if line:match("^<<<<<<<") or line:match("^=======") or line:match("^>>>>>>>") then
      has_conflict_markers = true
      break
    end
  end

  if has_conflict_markers then
    vim.api.nvim_buf_set_lines(result_bufnr, 0, -1, false, base_lines)
    vim.bo[result_bufnr].modified = true
  end

  -- Set window options for result
  vim.wo[result_win].wrap = false
  vim.wo[result_win].cursorline = true

  -- Enable scrollbind for result window
  vim.api.nvim_win_set_cursor(result_win, { 1, 0 })
  vim.wo[result_win].scrollbind = true

  -- Update lifecycle with result buffer/window FIRST
  -- (This must happen before setting winbar so ensure_no_winbar knows we're in conflict mode)
  lifecycle.set_result(tabpage, result_bufnr, result_win)
  lifecycle.set_result_base_lines(tabpage, base_lines)
  lifecycle.set_conflict_blocks(tabpage, conflict_diffs.conflict_blocks)
  lifecycle.track_conflict_file(tabpage, abs_path)

  -- Arrange all windows now that lifecycle knows about result_win
  layout.arrange(tabpage)

  -- Now set winbar titles for conflict windows based on conflict_ours_position
  -- (After set_result so ensure_no_winbar can detect conflict mode)
  vim.wo[result_win].winbar = " Result"
  local ours_position = config.options.diff.conflict_ours_position
  if vim.api.nvim_win_is_valid(original_win) then
    if ours_position == "left" then
      vim.wo[original_win].winbar = " Ours (Current)"
    else
      vim.wo[original_win].winbar = " Theirs (Incoming)"
    end
  end
  if vim.api.nvim_win_is_valid(modified_win) then
    if ours_position == "left" then
      vim.wo[modified_win].winbar = " Theirs (Incoming)"
    else
      vim.wo[modified_win].winbar = " Ours (Current)"
    end
  end

  -- Enable auto-refresh for result buffer
  auto_refresh.enable_for_result(result_bufnr)

  -- Initialize conflict tracking (keymaps setup separately after setup_all_keymaps)
  local conflict = require("codediff.ui.conflict")
  conflict.initialize_tracking(result_bufnr, conflict_diffs.conflict_blocks)

  -- Setup autocmd to refresh signs when result buffer changes (event-driven approach)
  conflict.setup_sign_refresh_autocmd(tabpage, result_bufnr)

  -- Initialize all conflict signs (uses refresh_all_conflict_signs for centralized logic)
  local session = lifecycle.get_session(tabpage)
  if session then
    conflict.refresh_all_conflict_signs(session)
  end

  -- Return focus to modified window
  if vim.api.nvim_win_is_valid(modified_win) then
    vim.api.nvim_set_current_win(modified_win)
  end

  return true
end

return M
