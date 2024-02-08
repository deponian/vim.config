local M = {}

M.rg_toggle_flag = function(flag)
  return function(_, opts)
    local o = { resume = true, cwd = opts.cwd }
    if not flag:match("^%s") then
      -- flag must be preceded by whitespace
      flag = " " .. flag
    end
    -- grep|live_grep sets `opts._cmd` to the original
    -- command without the search argument
    local cmd = opts._cmd or opts.cmd
    if cmd:match(require("fzf-lua.utils").lua_regex_escape(flag)) then
      o.cmd = cmd:gsub(require("fzf-lua.utils").lua_regex_escape(flag), "")
    else
      local bin, args = cmd:match("([^%s]+)(.*)$")
      o.cmd = string.format("%s%s%s", bin, flag, args)
    end
    opts.__call_fn(o)
  end
end

return M
