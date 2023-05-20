local M = {}

-- whitespaces in the end of line
function M.check_trailing_whitespaces()
  if vim.bo.readonly or
    not vim.bo.modifiable or
    vim.api.nvim_buf_line_count(0) > M.cfg.max_lines then
    return ''
  end

  -- do nothing if disabled for current filetype
  local skip_checks = M.cfg.skip_check_ft[vim.bo.ft]
  if skip_checks then
    if vim.tbl_contains(skip_checks, 'trailing') then
      return ''
    end
  end

  local trailing = vim.fn.search([[\s$]], 'nw')
  local result = ''

  if trailing ~= 0 then
    result = string.format(M.cfg.trailing_format, trailing)
  end

  return result
end

-- mixed indentation within a line
function M.check_mixed_indentation()
  if vim.bo.readonly or
    not vim.bo.modifiable or
    vim.api.nvim_buf_line_count(0) > M.cfg.max_lines then
    return ''
  end

  -- do nothing if disabled for current filetype
  local skip_checks = M.cfg.skip_check_ft[vim.bo.ft]
  if skip_checks then
    if vim.tbl_contains(skip_checks, 'mixed') then
      return ''
    end
  end

  local mixed = 0
  local result = ''

  if M.cfg.indentation_algorithm == 1 then
    -- [[<tab>]]<space>[[<tab>]]
    -- spaces before or between tabs are not allowed
    local t_s_t = [[(^\t* +\t%s*)]]
    -- <tab>(<space> x count)
    -- count of spaces at the end of tabs should be less than tabstop value
    local t_l_s = [[(^\t+ {]] .. vim.o.ts .. [[,}\S]]
    mixed = vim.fn.search([[\v]] .. t_s_t .. [[|]] .. t_l_s, 'nw')
  elseif M.cfg.indentation_algorithm == 2 then
    mixed = vim.fn.search([[\v(^\t* +\t\s*\S)]], 'nw')
  else
    mixed = vim.fn.search([[\v(^\t+ +)|(^ +\t+)]], 'nw')
  end
  if mixed ~= 0 then
    result = string.format(M.cfg.mixed_format, mixed)
  end

  return result
end

-- different indentation on different lines
function M.check_inconsistent_indentation()
  if vim.bo.readonly or
    not vim.bo.modifiable or
    vim.api.nvim_buf_line_count(0) > M.cfg.max_lines then
    return ''
  end

  -- do nothing if disabled for current filetype
  local skip_checks = M.cfg.skip_check_ft[vim.bo.ft]
  if skip_checks then
    if vim.tbl_contains(skip_checks, 'inconsistent') then
      return ''
    end
  end

  local inconsistent = ''
  local result = ''
  local head_spc = ''

  if vim.tbl_contains(M.cfg.c_like_langs, vim.bo.ft) then
    -- for C-like languages: allow /** */ comment style with one space before the '*'
    head_spc = [[\v(^ +\*@!)]]
  else
    head_spc = [[\v(^ +)]]
  end
  local indent_tabs = vim.fn.search([[\v(^\t+)]], 'nw')
  local indent_spc = vim.fn.search(head_spc, 'nw')
  if indent_tabs > 0 and indent_spc > 0 then
    if indent_spc < indent_tabs then
      inconsistent = string.format('%d:%d', indent_spc, indent_tabs)
    else
      inconsistent = string.format('%d:%d', indent_tabs, indent_spc)
    end
  end
  if inconsistent ~= '' then
    result = string.format(M.cfg.inconsistent_format, inconsistent)
  end

  return result
end

function M.check_all()
  local result = ''
  local first = true

  local trailing = M.check_trailing_whitespaces()
  if trailing ~= '' then
    result = trailing
    first = false
  end

  local mixed = M.check_mixed_indentation()
  if mixed ~= '' then
    if first then
      result = mixed
      first = false
    else
      result = result .. M.cfg.space .. mixed
    end
  end

  local inconsistent = M.check_inconsistent_indentation()
  if inconsistent ~= '' then
    if first then
      result = inconsistent
      first = false
    else
      result = result .. M.cfg.space .. inconsistent
    end
  end

  return result
end

local DEFAULT_OPTS = {
  max_lines = 20000,
  space = ' ',
  trailing_format = '[%s] trail',
  mixed_format = '[%s] mixed',
  inconsistent_format = '[%s] inconsistent',
  skip_check_ft = {},
  c_like_langs = {},
  indentation_algorithm = 0
}

function M.setup(config)
  M.cfg = vim.tbl_deep_extend("force", DEFAULT_OPTS, config or {})
end

return M
