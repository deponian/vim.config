" general
set autoread						" set to auto read when a file is changed from the outside
set backspace=indent,start,eol		" allow unrestricted backspacing in insert mode
set backupskip+=*.re,*.rei			" prevent bsb's watch mode from getting confused
set belloff=all						" never ring the bell for any reason
set completeopt=menu				" show completion menu (for nvim-cmp)
set completeopt+=menuone			" show menu even if there is only one candidate (for nvim-cmp)
set completeopt+=noselect			" don't automatically select canditate (for nvim-cmp)
set cursorline						" highlight current line
set encoding=utf-8					" set default encoding
set fillchars=diff:⁚				" TWO DOT PUNCTUATION (U+205A)
set fillchars+=eob:\ 				" suppress ~ at EndOfBuffer
set fillchars+=fold:·				" MIDDLE DOT (U+00B7)
set fillchars+=vert:│				" BOX DRAWINGS LIGHT VERTICAL (U+2502)
set foldlevelstart=99				" start unfolded
set foldmethod=indent				" use 'indent' method if you need faster folding
set formatoptions+=cro				" smart auto-commenting
set formatoptions+=j				" remove comment leader when joining comment lines
set formatoptions+=n				" smart auto-indenting inside numbered lists
set hidden							" allows you to hide buffers with unsaved changes without being prompted
set history=1000					" longer search and command history (default is 50).
set hlsearch						" Highlight search strings.
set ignorecase						" ignore case when search
set inccommand=nosplit				" live highlighting of :s results
set incsearch						" Incremental search ("find as you type").
set laststatus=2					" always show status line
set lazyredraw						" don't bother updating screen during macro playback
set linebreak						" wrap long lines at characters in 'breakat'
set modelines=5						" scan this many lines looking for modeline
set noemoji                         " don't assume all emoji are double width
set nojoinspaces					" don't autoinsert two spaces after '.', '?', '!' for join command
set noshowcmd						" don't show extra info at end of command line
set noshowmode						" don't show in statusline -- INSERT --, -- VISUAL -- ans etc.
set number							" show line numbers in gutter
set pumblend=0                     " pseudo-transparency for popup-menu
set scrolloff=5						" start scrolling 5 lines before edge of viewport
set shell=sh						" shell to use for `!`, `:!`, `system()` etc.
set shortmess+=c					" completion messages
set shortmess+=s					" Don't echo search wrap messages.
set shortmess+=I					" Don't neovim start screen
set sidescroll=0					" sidescroll in jumps because terminals are slow
set sidescrolloff=3					" same as scrolloff, but for columns
set smartcase						" enable case sensitive search only if there is uppercase letter in search pattern
set smarttab						" <tab>/<BS> indent/dedent in leading whitespace
set spellcapcheck=					" don't check for capital letters at start of sentence
set splitbelow						" open horizontal splits below current window
set splitright						" open vertical splits to the right of the current window
set switchbuf=usetab				" try to reuse windows/tabs when switching buffers
set synmaxcol=500					" don't bother syntax highlighting long lines
set termguicolors					" use guifg/guibg instead of ctermfg/ctermbg in terminal
set updatecount=80					" update swapfiles every 80 typed chars
set updatetime=250					" CursorHold interval
set viewdir=~/.vim/tmp/view			" override ~/.vim/view default
set viewoptions=cursor,folds		" save/restore just these (with `:{mk,load}view`)
set virtualedit=block				" allow cursor to move where there is no text in visual block mode
set visualbell t_vb=				" stop annoying beeping for non-error errors
set whichwrap=b,s					" allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line	   boundaries
set wildcharm=<C-z>					" substitute for 'wildchar' (<Tab>) in macros
set wildignore+=*.o,*.rej			" patterns to ignore during file-navigation
set wildmenu						" show options as list when switching buffers etc
set wildmode=longest:full,full		" shell-like autocomplete to unambiguous portion
set listchars=eol:$,space:.,tab:>-,trail:~,extends:>,precedes:<
set spellfile=~/.vim/spell/en.utf-8.add

" indentetion parametrs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smartindent
set autoindent
set shiftround

if exists('$SUDO_USER')
	" don't create root-owned files
	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
else
	" keep swap files out of the way
	set directory=~/.vim/tmp/swap//
	set directory+=.
	" keep backup files out of the way
	set backupdir=~/.vim/tmp/backup
	set backupdir+=.
	" keep undo files out of the way
	set undodir=~/.vim/tmp/undo
	set undodir+=.
	set undofile
endif

if exists('$SUDO_USER')
	" Don't create root-owned files.
	execute 'set shada='
else
	" Defaults:
	"	Neovim: !,'100,<50,s10,h
	"	Vim:	'100,<50,s10,h
	"
	" - ! save/restore global variables (only all-uppercase variables)
	" - '100 save/restore marks from last 100 files
	" - <50 save/restore 50 lines from each register
	" - s10 max item size 10KB
	" - h do not save/restore 'hlsearch' setting
	"
	" Our overrides:
	" - n: store in ~/.vim/tmp
	"
	execute "set shada=!,'100,<50,s10,h,n~/.vim/tmp/shada"

	if !empty(glob('~/.vim/tmp/shada'))
		if !filereadable(expand('~/.vim/tmp/shada'))
		echoerr 'warning: ~/.vim/tmp/shada exists but is not readable'
		endif
	endif
endif

" colorscheme
" these settings has to be placed AFTER set termguicolors 
lua << EOF
require('onedark').setup  {
  -- Main options --
  style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = true,  -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
  -- toggle theme style ---
  toggle_style_key = '<leader>ts', -- Default keybinding to toggle
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
    VertSplit = {fg = '$bg1'},

    FloatBorder = {fg = '$bg1', bg = 'none'},
    NormalFloat = {fg = '$fg', bg = 'none'},

    DiffText = {fg = 'none', bg = '#1d5c8c'},
    DiffAdd = {fg = 'none', bg = '#013325'},
    DiffDelete = {fg = '#8f8f8f', bg = '#331c1e'},
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true,   -- use undercurl instead of underline for diagnostics
    background = true,    -- use background color for virtual text
  },
}
EOF

colorscheme onedark
