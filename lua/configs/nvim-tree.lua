local M = {
  "nvim-tree/nvim-tree.lua",
}

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local utils = require('nvim-tree.utils')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Apply default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Custrom mappings
  vim.keymap.del('n', '<Tab>', { buffer = bufnr })
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'I', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'H', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'gs', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'S', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'U', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', ';', function()
    local node = api.tree.get_node_under_cursor()
    local found_win = utils.get_win_buf_from_path(node.absolute_path)
    if found_win then
      api.node.open.edit()
    else
      api.node.open.preview()
    end
  end, opts('preview_and_open'))

  vim.keymap.set('n', 'f', function()
    local node = api.tree.get_node_under_cursor()
    local dir = ""
    if node.fs_stat.type == "directory" then
      dir = vim.fn.fnamemodify(node.absolute_path, ":.")
    else
      dir = vim.fn.fnamemodify(node.absolute_path, ":.:h")
    end
    require("deponian.fzf-lua").live_grep({cwd = dir})
  end, opts('ripgrep'))

  vim.keymap.set('n', 'F', function()
    require('fzf-lua').files({cwd = "~/projects/"})
  end, opts('ripgrep'))
end

M.config = function()
  require("nvim-tree").setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = false,
    hijack_unnamed_buffer_when_opening = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    on_attach = on_attach,
    remove_keymaps = false,
    select_prompts = false,
    view = {
      centralize_selection = false,
      cursorline = true,
      debounce_delay = 15,
      width = {
        max = 42,
      },
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      full_name = true,
      highlight_opened_files = "none",
      highlight_modified = "none",
      root_folder_label = ":~:s?$?/..?",
      indent_width = 2,
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "¦",
          item = "¦",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        modified_placement = "after",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
        },
        glyphs = {
          default = "󰧮",
          symlink = "󱀮",
          bookmark = "󰃀",
          modified = "●",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "󰉋",
            open = "󰝰",
            empty = "󰉖",
            empty_open = "󰷏",
            symlink = "󰉒",
            symlink_open = "󰉒",
          },
          git = {
            unstaged = "~",
            staged = "+",
            unmerged = "",
            renamed = "➜",
            untracked = "*",
            deleted = "-",
            ignored = "◌",
          },
        },
      },
      special_files = {},
      symlink_destination = true,
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = false,
      update_root = false,
      ignore_list = {},
    },
    system_open = {
      cmd = "",
      args = {},
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = true,
      git_clean = false,
      no_buffer = false,
      custom = {},
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 400,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = true,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "gio trash",
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
      },
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  })

  vim.cmd [[highlight NvimTreeSpecialFile guifg=#efbd5d gui=none]]
  vim.cmd [[highlight NvimTreeIndentMarker guifg=#696969 gui=none]]
end

M.keys = {
  -- Cycle through windows (splits)
  { ";",
    function()
      require("nvim-tree.api").tree.focus()
    end },

  -- Open NvimTree file explorer
  { "`",
    function()
      require("nvim-tree.api").tree.toggle()
    end,
    silent = true },
  { "~",
    function()
      require("nvim-tree.api").tree.toggle({path = vim.fn.expand("%:p:h")})
    end,
    silent = true },
}

return M
