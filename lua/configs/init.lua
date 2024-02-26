return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function ()
      require("nvim-web-devicons").set_icon {
        log = {
          icon = "󰮗",
          color = "#ffffff",
          cterm_color = "231",
          name = "Log"
        }
      }
    end
  },

  -- save files as root
  {
    "lambdalisue/suda.vim",
    keys = {
      -- <Leader>W -- save buffer with sudo
      -- (mnemonic: [w]rite)
      { "<Leader>W", "<cmd>write suda://%<CR>" }

    },
  },

  {
    "deponian/nvim-base64",
    keys = {
      -- Decode/encode selected sequence from/to base64
      -- (mnemonic: [b]ase64)
      { "<Leader>b", "<Plug>(FromBase64)", mode = "x" },
      { "<Leader>B", "<Plug>(ToBase64)", mode = "x" },
    },
    config = function()
      require("nvim-base64").setup()
    end
  },

  {
    "echasnovski/mini.splitjoin",
    lazy = false,
    config = function()
      require("mini.splitjoin").setup()
    end
  },

  {
    "echasnovski/mini.jump",
    lazy = false,
    opts = {
      mappings = {
        repeat_jump = "",
      },
    },
    config = function(_, opts)
      require("mini.jump").setup(opts)
      vim.cmd [[highlight MiniJump guifg=#FFDD87 guibg=#123E60 gui=bold]]
    end
  },

  {
    "echasnovski/mini.surround",
    lazy = false,
    config = function()
      vim.keymap.set("n", "s", "<Nop>")
      require("mini.surround").setup()
    end
  },

  {
    "fatih/vim-go",
    lazy = false,
    init = function()
      vim.g.go_fmt_fail_silently = 1
    end
  },

  {
    "pearofducks/ansible-vim",
    init = function()
      vim.g.ansible_ftdetect_filename_regex = [[\v(playbook|site|local|requirements)\.ya?ml$]]
    end
  },

  {
    "sindrets/diffview.nvim",
    opts = {
      keymaps = {
        view = {
          { "n", "<tab>", false },
          { "n", "<s-tab>", false },
        },
        file_panel = {
          { "n", "<tab>", false },
          { "n", "<s-tab>", false },
        },
        file_history_panel = {
          { "n", "<tab>", false },
          { "n", "<s-tab>", false },
        }
      }
    },
    -- config = function(_, opts)
    --   require("diffview").setup(opts)
    -- end
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 900,
    opts = {
      max_concurrent_installers = 8,
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 800,
    opts = {},
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end
  },

  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "godlygeek/tabular" },
  { "HiPhish/rainbow-delimiters.nvim" },

  -- language/syntax/filetype plugins
  { "ch-danreif/haproxy.vim" },
  { "mtdl9/vim-log-highlighting" },
  { "mustache/vim-mustache-handlebars" },
  { "nfnty/vim-nftables" },
  { "towolf/vim-helm" },
  { "tpope/vim-git" },
  { "yasuhiroki/github-actions-yaml.vim" },
}

