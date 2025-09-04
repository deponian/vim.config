local M = {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
}

M.opts = {
  filetypes = { "*" },
  user_commands = false,
  user_default_options = {
    names = false,
    RGB = false,
    RGBA = false,
    RRGGBB = true,
  },
}
return M
