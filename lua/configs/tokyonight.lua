local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

M.opts = {
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "normal", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  on_colors = function(colors)
    colors.fg_sidebar = "#b2bcde"

    colors.border_highlight = "#394b70"

    colors.git.change = colors.orange
    colors.git.add = colors.green
    colors.git.delete = colors.red

    colors.gitSigns.change = colors.orange
    colors.gitSigns.add = colors.green
    colors.gitSigns.delete = colors.red

    colors.bg_visual = "#553a19"
  end,

  on_highlights = function(hl, c)
    hl.DiffAdd = { bg = "#1d3c41" }
    hl.DiffChange = { bg = "#252a3f" }
    hl.DiffDelete = { bg = "#40252e" }
    hl.DiffText = { bg = "#026faf" }

    hl.NvimTreeWinSeparator = { bg = "#222436", fg = "#222436" }
  end,
}

M.config = function(_, opts)
  require("tokyonight").setup(opts)
  vim.cmd[[colorscheme tokyonight]]
  -- https://github.com/neovim/neovim/issues/9800
  vim.cmd('highlight CursorLine ctermfg=white')
end

return M
