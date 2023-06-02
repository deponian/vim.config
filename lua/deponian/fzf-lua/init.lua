local M = {}

local function build_rg_opts(opts)
  local rg_opts_tbl = require("fzf-lua.config").globals.grep.rg_opts_tbl
  local opts_str = ""
  for option, value in pairs(rg_opts_tbl) do
    if value == "" then
      opts_str = opts_str .. option .. " "
    else
      opts_str = opts_str .. option .. "=".. value .. " "
    end
  end
  opts_str = vim.trim(opts_str)
  -- add "-e" only for live_grep_native
  if opts.fn_reload and not opts.rg_glob then
    return opts_str .. " -e"
  else
    return opts_str
  end
end

local function build_prompt(opts)
  local rg_opts_tbl = require("fzf-lua.config").globals.grep.rg_opts_tbl
  local search_type = ""
  local glob_status = ""
  -- 'fn_reload' is set only on 'live_grep_native' calls
  if not opts.fn_reload then
    search_type = "Fuzzy search"
  else
    if rg_opts_tbl["--fixed-strings"] then
      search_type = "Literal search"
    else
      search_type = "Regex search"
    end
    if opts.rg_glob then
      glob_status = " with globs"
    end
  end
  local opts_status = ""
  if not rg_opts_tbl["--hidden"] then
    opts_status = opts_status .. "[no hidden] "
  end
  return "* " .. opts_status .. search_type .. glob_status .. ": "
end

local function rg_toggle_option(rg_option)
  return function(_, opts)
    local rg_opts_tbl = require("fzf-lua.config").globals.grep.rg_opts_tbl
    if rg_opts_tbl[rg_option] then
      rg_opts_tbl[rg_option] = nil
    else
      rg_opts_tbl[rg_option] = ""
    end

    local o = vim.tbl_extend("keep", {
      search = false,
      resume = true,
      resume_search_default = "",
      prompt = build_prompt(opts),
      rg_opts = build_rg_opts(opts),
      __prev_query = opts.__resume_data.last_query,
      query = opts.__resume_data.last_query,
    }, opts.__call_opts or {})

    -- 'fn_reload' is set only on 'live_grep_native' calls
    -- 'rg_glob' is set only on 'live_grep_glob' calls
    if not opts.fn_reload then
      print("grep")
      opts.__MODULE__.grep_project(o)
    else
      if opts.rg_glob then
        print("live_glob")
        opts.__MODULE__.live_grep_glob(o)
      else
        print("live_native")
        opts.__MODULE__.live_grep_native(o)
      end
    end
  end
end

local function switch_to_grep_project(_, opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  opts.fn_reload = false
  local o = vim.tbl_extend("keep", {
    search = false,
    prompt = build_prompt(opts),
    rg_opts = build_rg_opts(opts),
    resume = true,
    resume_search_default = "",
    __prev_query = opts.__resume_data.last_query,
    query = opts.__resume_data.last_query,
    no_esc = true,
    fn_reload = false,
    rg_glob = false,
  }, opts.__call_opts or {})
  opts.__MODULE__.grep_project(o)
end

local function switch_to_live_grep_native(_, opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  opts.fn_reload = true
  opts.rg_glob = false
  local o = vim.tbl_extend("keep", {
    search = false,
    prompt = build_prompt(opts),
    rg_opts = build_rg_opts(opts),
    resume = true,
    resume_search_default = "",
    __prev_query = opts.__resume_data.last_query,
    query = opts.__resume_data.last_query,
    fn_reload = true,
    rg_glob = false,
  }, opts.__call_opts or {})
  opts.__MODULE__.live_grep_native(o)
end

local function switch_to_live_grep_glob(_, opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  opts.fn_reload = true
  opts.rg_glob = true
  local o = vim.tbl_extend("keep", {
    search = false,
    prompt = build_prompt(opts),
    rg_opts = build_rg_opts(opts),
    resume = true,
    resume_search_default = "",
    __prev_query = opts.__resume_data.last_query,
    query = opts.__resume_data.last_query,
    fn_reload = true,
    rg_glob = true,
  }, opts.__call_opts or {})
  opts.__MODULE__.live_grep_glob(o)
end

function M.grep_project(opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  local fake_opts = vim.deepcopy(require("fzf-lua.config").globals.grep)
  fake_opts.fn_reload = nil

  opts = opts or {}
  opts.prompt = opts.prompt or build_prompt(fake_opts)
  require("fzf-lua").grep_project(opts)
end

function M.live_grep_native(opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  local fake_opts = vim.deepcopy(require("fzf-lua.config").globals.grep)
  fake_opts.fn_reload = true
  fake_opts.rg_glob = false

  opts = opts or {}
  opts.prompt = opts.prompt or build_prompt(fake_opts)
  require("fzf-lua").live_grep_native(opts)
end

function M.live_grep_glob(opts)
  -- fake some options to help
  -- build_prompt() understand the situation
  local fake_opts = vim.deepcopy(require("fzf-lua.config").globals.grep)
  fake_opts.fn_reload = true
  fake_opts.rg_glob = true

  opts = opts or {}
  opts.prompt = opts.prompt or build_prompt(fake_opts)
  require("fzf-lua").live_grep_glob(opts)
end

function M.setup_grep()
  local rg_opts_tbl = {
    ["--color"]         = "always",
    ["--max-columns"]   = "4096",
    ["--glob"]          = "'!.git/'",
    ["--column"]        = "",
    ["--line-number"]   = "",
    ["--no-heading"]    = "",
    ["--no-ignore"]     = "",
    ["--smart-case"]    = "",
    ["--hidden"]        = "",
    ["--fixed-strings"] = "",
  }

  -- merge these options without resetting to defaults
  require("fzf-lua").setup({
    grep = {
      fzf_opts = {
        ["--delimiter"] = ":",
        ["--nth"] = "4..",
      },
      -- rg_opts will be constructed from this table
      -- if you run one of the wrapper functions above
      -- (e.g. live_grep_native)
      rg_opts_tbl = rg_opts_tbl,
      -- these are defaults that will be used if you run
      -- functions like live_grep directly from require("fzf-lua")
      rg_opts = "--color=always --max-columns=4096 --glob='!.git/' " ..
                "--column --line-number --no-heading --no-ignore " ..
                "--smart-case --hidden --fixed-strings",
      actions = {
        ["ctrl-g"] = { switch_to_grep_project },
        ["ctrl-n"] = { switch_to_live_grep_native },
        ["ctrl-o"] = { switch_to_live_grep_glob },
        ["ctrl-h"] = { rg_toggle_option("--hidden") },
        ["ctrl-r"] = { rg_toggle_option("--fixed-strings") }
      },
      exec_empty_query = true,
    },
  }, true)
end

return M
