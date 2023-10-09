local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  enabled = false
}

M.opts = {
  -- Main options --
  style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false,  -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
  -- toggle theme style ---
  toggle_style_key = nil, -- Default keybinding to toggle
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {
    Visual = {bg = '#303f5d'},
    VertSplit = {fg = '$bg1'},

    FloatBorder = {fg = '$bg1', bg = 'none'},
    NormalFloat = {fg = '$fg', bg = 'none'},

    CurSearch = {fg = '#1a212e', bg = '#54b0fd'},

    DiffText = {fg = 'none', bg = '#1d5c8c'},
    DiffAdd = {fg = 'none', bg = '#013325'},
    DiffDelete = {fg = '#8f8f8f', bg = '#331c1e'},

    DiagnosticUnderlineError = {fmt = 'none'},
    DiagnosticUnderlineHint = {fmt = 'none'},
    DiagnosticUnderlineInfo = {fmt = 'none'},
    DiagnosticUnderlineWarn = {fmt = 'none'},

    GitSignsChange = {fg = '$orange'},
    GitSignsChangeLn = {fg = '$orange'},
    GitSignsChangeNr = {fg = '$orange'},

    TroubleNormal = {bg = "none"},
    TroubleCount = {fg = '$orange'},
    TroubleFile = {fg = '$cyan'},
    TroubleFoldIcon = {fg = '$fg'},
    TroubleLocation = {fg = '$cyan'},
    TroubleTextError = {fg = '$fg'},
    TroubleTextInformation = {fg = '$fg'},
    TroubleTextHint = {fg = '$fg'},
    TroubleTextWarning = {fg = '$fg'},
    TroubleText = {fg = '$fg'},
    TroublePreview = {fg = '$purple'},
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true,   -- use undercurl instead of underline for diagnostics
    background = true,    -- use background color for virtual text
  },
}

M.config = function(_, opts)
  require('onedark').setup(opts)
  require('onedark').load()
  -- https://github.com/neovim/neovim/issues/9800
  vim.cmd('highlight CursorLine ctermfg=white guibg=#21283b')
end

return M
