local M = { "ibhagwan/fzf-lua" }

M.opts = {
  winopts = {
    fullscreen = true,
  },
  previewers = {
    builtin = {
      treesitter = {
        context = {
          max_lines = 5
        }
      },
    },
  },
  defaults = {
    hidden = true,
    no_ignore = true,
    follow = true,
    toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
    toggle_hidden_flag = "--hidden",    -- flag toggled in `actions.toggle_hidden`
    -- hack: replacing "--follow" flag with "--fixed-strings"
    toggle_follow_flag = "--fixed-strings", -- flag toggled in `actions.toggle_follow`
  },
  files = {
    cwd_prompt_shorten_val = 3,
  },
  grep = {
    rg_opts = "--column --line-number --glob='!.git/' --no-heading --color=always --no-ignore --hidden --fixed-strings --smart-case --max-columns=4096 -e",
    no_header_i = true,
  }
}

M.config = function(_, opts)
  -- actions can be set only here because they need require("fzf-lua")...
  opts.actions = {
    files = {
      true,
      ["ctrl-i"] = require("fzf-lua").actions.toggle_hidden,
      ["ctrl-h"] = require("fzf-lua").actions.toggle_ignore,
      ["ctrl-r"] = require("fzf-lua").actions.toggle_follow,
    },
  }
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
      require("fzf-lua").live_grep()
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

  -- <Leader>F -- Search in current buffer
  -- (mnemonic: find)
  { "<Leader>F",
    function()
      require("fzf-lua").blines()
    end },

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
