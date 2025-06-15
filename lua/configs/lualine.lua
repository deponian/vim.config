local M = {
  "nvim-lualine/lualine.nvim",
  enabled = not vim.g.bigfile_mode,
}

M.dependencies = {
  "deponian/nvim-lualine-whitespace",
  config = function()
    require("lualine-whitespace").setup()
  end,
}

M.opts = function ()
  return {
    options = {
      icons_enabled = true,
      theme = "tokyonight-moon",
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = false,
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { {'b:gitsigns_head', icon = ''} },
      lualine_c = {
        { 'filename', file_status = false, newfile_status = true, path = 3 }
      },
      lualine_x = {
        {
          require('deponian.lualine.get_yaml_key'),
          color = { fg = '#636da6' },
        },
        {
          require('deponian.lualine.readonly'),
          color = { fg = '#f65866', gui = 'bold' },
        },
        {
          require('deponian.lualine.modified'),
          color = { fg = '#efbd5d', gui = 'bold' },
        },
        'filetype'
      },
      lualine_y = {
        require('deponian.lualine.fmt_and_enc'),
        { 'diagnostics', symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} }
      },
      lualine_z = {
        { 'searchcount', color = { fg = '#1a212e', bg = '#efbd5d' } },
        { 'selectioncount', color = { fg = '#c75ae8', bg = '#1a212e' } },
        { require('lualine-whitespace').print_all, color = { fg = '#1a212e', bg = '#efbd5d' } },
        require('deponian.lualine.location')
      }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 1,
          use_mode_colors = true,
          max_length = vim.o.columns,

          fmt = function(name, context)
            if string.match(name, 'NvimTree_') then
              return 'nvimtree'
            end

            -- Show ● if buffer is modified in tab
            local buflist = vim.fn.tabpagebuflist(context.tabnr)
            local winnr = vim.fn.tabpagewinnr(context.tabnr)
            local bufnr = buflist[winnr]
            local mod = vim.fn.getbufvar(bufnr, '&mod')

            return name .. (mod == 1 and ' ●' or '')
          end
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {
      'fugitive',
      'fzf',
      'quickfix',
      require('deponian.lualine.nvim-tree'),
      require('deponian.lualine.man')
    }
  }
end

return M
