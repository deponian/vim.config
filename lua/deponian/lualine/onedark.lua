local colors = {
  blue   = '#54b0fd',
  green  = '#8bcd5b',
  purple = '#c75ae8',
  cyan   = '#56d2c2',
  red1   = '#f65866',
  red2   = '#992525',
  yellow = '#efbd5d',
  fg     = '#93a4c3',
  bg     = '#1a212e',
  gray1  = '#6c7d9c',
  gray2  = '#1a212e',
  gray3  = '#283347',
}

return {
  normal = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  command = {
    a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.purple, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  terminal = {
    a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red1, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  inactive = {
    a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.gray2 },
  },
}
