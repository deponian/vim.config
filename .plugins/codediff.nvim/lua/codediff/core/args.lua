--- Flag and argument parser for CodeDiff commands
--- Separates positional arguments from flags, supporting both long (--flag) and short (-f) forms
local M = {}

--- Parse command arguments separating positional args from flags
--- @param args table Raw args array (excluding subcommand)
--- @param flag_spec table Flag specifications
---   Example: { ["--reverse"] = { short = "-r", type = "boolean" } }
--- @return table|nil positional Positional arguments array
--- @return table|nil flags Parsed flags table (flag_name = value)
--- @return string|nil error Error message if parsing failed
function M.parse_args(args, flag_spec)
  local positional = {}
  local flags = {}
  local i = 1

  while i <= #args do
    local arg = args[i]
    local is_flag = false

    -- Check if arg is a flag (starts with - or --)
    if arg:match("^%-") then
      for long_name, spec in pairs(flag_spec) do
        if arg == long_name or (spec.short and arg == spec.short) then
          is_flag = true
          local flag_key = long_name:gsub("^%-%-", ""):gsub("%-", "_")

          if spec.type == "boolean" then
            flags[flag_key] = true
          elseif spec.type == "string" then
            i = i + 1
            if i > #args then
              return nil, nil, "Flag " .. arg .. " requires a value"
            end
            flags[flag_key] = args[i]
          end
          break
        end
      end

      if not is_flag then
        return nil, nil, "Unknown flag: " .. arg
      end
    else
      table.insert(positional, arg)
    end

    i = i + 1
  end

  return positional, flags, nil
end

return M
