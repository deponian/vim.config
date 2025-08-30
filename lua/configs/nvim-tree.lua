local M = {
  "nvim-tree/nvim-tree.lua",
}

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Apply default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings
  vim.keymap.del('n', '<Tab>', { buffer = bufnr })
  vim.keymap.set('n', ';', api.node.open.edit, opts('Open or focus'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'I', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'H', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'gs', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'U', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))

  -- find a string in a directory under the cursor
  vim.keymap.set('n', 'f', function()
    local node = api.tree.get_node_under_cursor()
    local dir = ""
    if node.fs_stat.type == "directory" then
      dir = vim.fn.fnamemodify(node.absolute_path, ":.")
    else
      dir = vim.fn.fnamemodify(node.absolute_path, ":.:h")
    end
    require("fzf-lua").live_grep({cwd = dir})
  end, opts('ripgrep'))

  -- find a file in ~/projects directory
  vim.keymap.set('n', 'F', function()
    require('fzf-lua').files({cwd = "~/projects/"})
  end, opts('ripgrep'))
end

M.config = function()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_cursor = true,
    reload_on_bufenter = true,
    on_attach = on_attach,
    view = {
      width = {
        max = 42,
      },
    },
    renderer = {
      full_name = true,
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
        git_placement = "after",
        symlink_arrow = " -> ",
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
            renamed = "",
            untracked = "*",
            deleted = "-",
            ignored = "",
          },
        },
      },
      special_files = {},
    },
    diagnostics = {
      enable = false,
    },
    filters = {
      dotfiles = true,
    },
    modified = {
      enable = true,
    },
    actions = {
      change_dir = {
        global = true,
      },
    },
  })

  vim.cmd [[highlight NvimTreeSpecialFile guifg=#efbd5d gui=none]]
  vim.cmd [[highlight NvimTreeIndentMarker guifg=#596a87 gui=none]]
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
