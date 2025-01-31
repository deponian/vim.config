local M = { "ibhagwan/fzf-lua" }

M.opts = {
  winopts = {
    fullscreen = true,
    hls = {
      normal = 'Normal',
      border = 'FloatBorder',
      preview_border = 'FloatBorder',
      help_normal = 'Normal',
      help_border = 'FloatBorder',
      -- Only used with the builtin previewer:
      cursor = 'Cursor',
      cursorline = 'CursorLine',
      cursorlinenr = 'CursorLineNr',
      search = 'IncSearch',
      title = 'SignColumn',
      -- Only used with 'winopts.preview.scrollbar = 'border'
      scrollborder_e = 'FloatBorder',
      scrollborder_f = 'Delimiter',
    },
    preview = {
      title_pos = "center",
      scrollchars = {'┃', '' },
    },
  },
  previewers = {
    builtin = {
      treesitter = { enabled = true, disabled = {"yaml"} },
      extensions = {
        ["bmp"] = { "chafa" },
        ["jpg"] = { "chafa" },
        ["jpeg"] = { "chafa" },
        ["png"] = { "chafa" },
      },
    },
  },
  files = {
    prompt = 'Files: ',
    fzf_opts = { ["--info"] = "inline", },
    fd_opts = "--color=never --type f --no-ignore --hidden --follow --exclude .git",
    cwd_prompt_shorten_val = 3,
  },
  git = {
    files = {
      prompt = 'GitFiles: ',
    },
    status = {
      prompt = 'GitStatus: ',
    },
    commits = {
      prompt = 'Commits: ',
      cmd = "git log --color --pretty=format:'%C(#5398dd)%h %C(#00d7af)%cd%C(reset)%C(#f2684b)%d %C(#d9d9d9)%s' --date=format:'%F'",
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    bcommits = {
      prompt = 'File History: ',
      cmd = "git log --color --pretty=format:'%C(#5398dd)%h %C(#00d7af)%cd%C(reset)%C(#f2684b)%d %C(#d9d9d9)%s' --date=format:'%F' <file>",
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    branches = {
      prompt = 'Branches: ',
    },
    stash = {
      prompt = 'Stash: ',
    },
  },
  grep = {
    prompt = ' ',
    rg_opts = "--column --line-number --glob='!.git/' --no-heading --color=always --no-ignore --hidden --fixed-strings --smart-case --max-columns=4096 -e",
    no_header_i = true,
    rg_glob = true,
    exec_empty_query = true,
    actions = {
      ["ctrl-i"] = { require("deponian.fzf-lua").rg_toggle_flag("--hidden") },
      ["ctrl-r"] = { require("deponian.fzf-lua").rg_toggle_flag("--fixed-strings") },
    },
  },
  args = {
    prompt = 'Args: ',
  },
  oldfiles = {
    prompt = 'History: ',
  },
  buffers = {
    prompt = 'Buffers: ',
  },
  tabs = {
    prompt = 'Tabs: ',
  },
  lines = {
    prompt = 'Lines: ',
  },
  blines = {
    prompt = 'BLines: ',
  },
  tags = {
    prompt = 'Tags: ',
  },
  btags = {
    prompt = 'BTags: ',
  },
  colorschemes = {
    prompt = 'Colorschemes: ',
  },
  quickfix = {
    prompt = "Quickfix: ",
  },
  quickfix_stack = {
    prompt = "Quickfix Stack: ",
  },
  lsp = {
    prompt_postfix = ': ',
    code_actions = {
        prompt = 'Code Actions: ',
    },
    finder = {
        prompt = "LSP Finder: ",
    }
  },
  diagnostics ={
    prompt = 'Diagnostics: ',
    signs = {
      ["Error"] = { text = "", texthl = "DiagnosticError" },
      ["Warn"]  = { text = "", texthl = "DiagnosticWarn" },
      ["Info"]  = { text = "", texthl = "DiagnosticInfo" },
      ["Hint"]  = { text = "", texthl = "DiagnosticHint" },
    },
  },
}

M.config = function(_, opts)
  -- setup plugin settings
  require("fzf-lua").setup(opts)
end

M.keys = {
  -- Find and open file
  { "<Leader>t",
    function()
      require("fzf-lua").files()
    end,
    silent = true },
  { "<Leader>T", ":lua require('fzf-lua').files({cwd = '~/projects'})<Left><Left><Left>" },

  -- <Leader>f -- Recursively find some string or selected sequence in all files in the project
  -- (mnemonic: find)
  { "<Leader>f",
    function()
      require("fzf-lua").live_grep({})
    end },
  { "<Leader>f",
    function()
      require("fzf-lua").live_grep({
        search = require("deponian.general").get_oneline_selection(),
        no_esc = true
      })
    end,
    mode = "x",
    silent = true },

  -- <Leader>g -- git commands
  -- mnemonic: [g]it [l]s-files
  { "<Leader>gl", "<cmd>lua require('fzf-lua').git_files()<CR>" },
  -- mnemonic: [g]it [s]tatus
  { "<Leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>" },
  -- mnemonic: [g]it [c]ommits
  { "<Leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>" },
  -- mnemonic: [g]it [h]istory
  { "<Leader>gh", "<cmd>lua require('fzf-lua').git_bcommits()<CR>" },
  -- mnemonic: [g]it [b]ranches
  { "<Leader>gb", "<cmd>lua require('fzf-lua').git_branches()<CR>" },
}

return M
