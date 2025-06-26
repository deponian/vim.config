local config = vim.fn.stdpath("config")

-- general options
vim.opt.backupskip:append("*.re,*.rei")               -- prevent bsb's watch mode from getting confused
vim.opt.completeopt = "menu"                          -- show completion menu (for nvim-cmp)
vim.opt.completeopt:append("menuone")                 -- show menu even if there is only one candidate (for nvim-cmp)
vim.opt.completeopt:append("noselect")                -- don't automatically select candidate (for nvim-cmp)
vim.opt.cursorline = true                             -- highlight current line
vim.opt.diffopt:append("linematch:100")               -- enable more accurate diff
vim.opt.emoji = false                                 -- don't assume all emoji are double width
vim.opt.fillchars:append({ diff = '⁚' })              -- TWO DOT PUNCTUATION (U+205A)
vim.opt.fillchars:append({ eob = ' ' })               -- suppress ~ at EndOfBuffer
vim.opt.foldlevelstart = 99                           -- start unfolded
vim.opt.foldenable = false                            -- disable folding at startup
vim.opt.formatoptions:append('ro')                    -- smart auto-commenting
vim.opt.ignorecase = true                             -- ignore case when searching
vim.opt.inccommand = 'nosplit'                        -- live highlighting of :s results
vim.opt.lazyredraw = true                             -- don't bother updating screen during macro playback
vim.opt.linebreak = true                              -- wrap long lines at characters in 'breakat'
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }   -- for % command jump
vim.opt.modelines = 5                                 -- scan this many lines looking for modeline
vim.opt.mouse = 'a'                                   -- enable mouse support in all modes
vim.opt.mousemodel = 'extend'                         -- disable right-click popup-menu
vim.opt.mousescroll = 'ver:1,hor:1'                   -- smoother scrolling
vim.opt.number = true                                 -- show line numbers in gutter
vim.opt.pumblend = 0                                  -- pseudo-transparency for popup-menu
vim.opt.scrolloff = 5                                 -- start scrolling 5 lines before edge of viewport
vim.opt.shell = 'bash'                                -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shortmess:append({I = true})                  -- Don't neovim start screen
vim.opt.shortmess:append({S = true})                  -- do not show search count message when searching, e.g. "[1/5]"
vim.opt.shortmess:append({c = true})                  -- completion messages
vim.opt.shortmess:append({s = true})                  -- Don't echo search wrap messages.
vim.opt.showcmd = false                               -- don't show extra info at end of command line
vim.opt.showmode = false                              -- don't show in statusline -- INSERT --, -- VISUAL -- and etc.
vim.opt.sidescrolloff = 3                             -- same as scrolloff, but for columns
vim.opt.smartcase = true                              -- enable case-sensitive search only if there is an uppercase letter in the search pattern
vim.opt.spellcapcheck = ''                            -- don't check for capital letters at the start of a sentence
vim.opt.spellfile = config .. '/spell/en.utf-8.add'   -- word list file where words are added for the zg and zw commands
vim.opt.splitbelow = true                             -- open horizontal splits below the current window
vim.opt.splitright = true                             -- open vertical splits to the right of the current window
vim.opt.switchbuf = 'usetab'                          -- try to reuse windows/tabs when switching buffers
vim.opt.synmaxcol = 1000                              -- don't bother syntax highlighting long lines
vim.opt.termguicolors = true                          -- enable 24 bit colors
vim.opt.undofile = true                               -- save undo history to an undo file
vim.opt.updatecount = 80                              -- update swapfiles every 80 typed chars
vim.opt.updatetime = 250                              -- CursorHold interval
vim.opt.virtualedit = 'block'                         -- allow the cursor to move where there is no text in visual block mode
vim.opt.visualbell = true                             -- stop annoying beeping for non-error errors
vim.opt.whichwrap = 'b,s'                             -- allow <BS>/h/l/<Left>/<Right>/<Space> and ~ to cross line boundaries
vim.opt.wildcharm = 26                                -- ('<C-z>') substitute for 'wildchar' (<Tab>) in macros
vim.opt.wildignore:append('*.o,*.rej')                -- patterns to ignore during file-navigation
vim.opt.wildmode = 'longest:full,full'                -- shell-like autocomplete to unambiguous portion
vim.opt.winborder = 'bold'

-- use these only for small files
if not vim.g.bigfile_mode then
  vim.wo.foldmethod = 'expr'                          -- use special fold expression
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use tree-sitter as the source for folding
else
  vim.opt.foldmethod = "indent"                       -- use indent folding method for big files
end

-- invisible chars
vim.opt.listchars = {
  eol = '$',
  space = '.',
  nbsp = '⦸',
  tab = '>-',
  trail = '~',
  extends = '»',
  precedes = '«',
}

-- indentation options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftround = true

-- Change shape of cursor in insert and replace mode
vim.opt.guicursor = 'n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20'
