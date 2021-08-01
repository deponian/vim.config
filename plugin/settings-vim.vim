scriptencoding utf-8

colorscheme onedark

" general
set ignorecase						" ignore case when search
set smartcase						" enable case sensitive search only if there is uppercase letter in search pattern
set hidden							" allows you to hide buffers with unsaved changes without being prompted
set backspace=indent,start,eol		" allow unrestricted backspacing in insert mode
set cursorline						" highlight current line
set laststatus=2					" always show status line
set lazyredraw						" don't bother updating screen during macro playback
set modelines=5						" scan this many lines looking for modeline
set nojoinspaces					" don't autoinsert two spaces after '.', '?', '!' for join command
set number							" show line numbers in gutter
set scrolloff=5						" start scrolling 5 lines before edge of viewport
set shell=sh						" shell to use for `!`, `:!`, `system()` etc.
set sidescroll=0					" sidescroll in jumps because terminals are slow
set sidescrolloff=3					" same as scrolloff, but for columns
set smarttab						" <tab>/<BS> indent/dedent in leading whitespace
set updatecount=80					" update swapfiles every 80 typed chars
set updatetime=250					" CursorHold interval
set visualbell t_vb=				" stop annoying beeping for non-error errors
set wildcharm=<C-z>					" substitute for 'wildchar' (<Tab>) in macros
set switchbuf=usetab				" try to reuse windows/tabs when switching buffers
set whichwrap=b,s					" allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line	   boundaries
set wildmode=longest:full,full		" shell-like autocomplete to unambiguous portion
set autoread						" set to auto read when a file is changed from the outside
set encoding=utf-8					" set default encoding
set noshowmode						" don't show in statusline -- INSERT --, -- VISUAL -- ans etc.
set history=1000					" longer search and command history (default is 50).
set hlsearch						" Highlight search strings.
set incsearch						" Incremental search ("find as you type").
set shortmess+=s					" Don't echo search wrap messages.
set listchars=eol:$,space:.,tab:>-,trail:~,extends:>,precedes:<

" indentetion parametrs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smartindent
set autoindent
set shiftround

if has('syntax')
	set spellcapcheck=	" don't check for capital letters at start of sentence
	set spellfile=~/.vim/spell/en.utf-8.add
endif

if has('windows')
	set splitbelow		" open horizontal splits below current window
endif

if has('vertsplit')
	set splitright		" open vertical splits to the right of the current window
endif

if exists('&swapsync')
	set swapsync=		" let OS sync swapfiles lazily
endif

if has('syntax')
	set synmaxcol=500	" don't bother syntax highlighting long lines
endif

if has('termguicolors')
	set termguicolors	" use guifg/guibg instead of ctermfg/ctermbg in terminal
endif

if exists('$SUDO_USER')
	set noswapfile		" don't create root-owned files
else
	set directory=~/.vim/tmp/swap//		" keep swap files out of the way
	set directory+=.
endif

if exists('$SUDO_USER')
	set nobackup		" don't create root-owned files
	set nowritebackup	" don't create root-owned files
else
	set backupdir=~/.vim/tmp/backup		" keep backup files out of the way
	set backupdir+=.
endif

if has('persistent_undo')
	if exists('$SUDO_USER')
		set noundofile						" don't create root-owned files
	else
		set undodir=~/.vim/tmp/undo			" keep undo files out of the way
		set undodir+=.
		set undofile						" actually use undo files
	endif
endif

if has('viminfo') " ie. Vim.
	let s:viminfo='viminfo'
elseif has('shada') " ie. Neovim.
	let s:viminfo='shada'
endif

if exists('s:viminfo')
	if exists('$SUDO_USER')
		" Don't create root-owned files.
		execute 'set ' . s:viminfo . '='
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
		execute 'set ' . s:viminfo . "=!,'100,<50,s10,h,n~/.vim/tmp/" . s:viminfo

		if !empty(glob('~/.vim/tmp/' . s:viminfo))
			if !filereadable(expand('~/.vim/tmp/' . s:viminfo))
			echoerr 'warning: ~/.vim/tmp/' . s:viminfo . ' exists but is not readable'
			endif
		endif
	endif
endif

if has('mksession')
	set viewdir=~/.vim/tmp/view			" override ~/.vim/view default
	set viewoptions=cursor,folds		" save/restore just these (with `:{mk,load}view`)
endif

if has('virtualedit')
	set virtualedit=block				" allow cursor to move where there is no text in visual block mode
endif

if has('wildignore')
	set wildignore+=*.o,*.rej			" patterns to ignore during file-navigation
endif

if has('wildmenu')
	set wildmenu						" show options as list when switching buffers etc
endif

if has('wildignore')
	set backupskip+=*.re,*.rei			" prevent bsb's watch mode from getting confused
endif

if exists('&belloff')
	set belloff=all						" never ring the bell for any reason
endif

if has('folding')
	if has('windows')
		set fillchars=diff:-		" BULLET OPERATOR (U+2219)
		set fillchars+=fold:·		" MIDDLE DOT (U+00B7)
		set fillchars+=vert:│		" BOX DRAWINGS LIGHT VERTICAL (U+2502)
	endif

	if has('nvim-0.3.1')
		set fillchars+=eob:\ 		" suppress ~ at EndOfBuffer
	endif

	set foldmethod=indent			" use 'indent' method if you need faster folding
	set foldlevelstart=99			" start unfolded
endif

if v:version > 703 || v:version == 703 && has('patch541')
	set formatoptions+=j			" remove comment leader when joining comment lines
endif
set formatoptions+=n				" smart auto-indenting inside numbered lists
set formatoptions+=cro				" smart auto-commenting

if has('patch-7.4.314')
	set shortmess+=c				" completion messages
endif

if exists('&inccommand')
	set inccommand=nosplit			" live highlighting of :s results
endif

if has('linebreak')
	set linebreak					" wrap long lines at characters in 'breakat'
endif

if has('showcmd')
	set noshowcmd					" don't show extra info at end of command line
endif

