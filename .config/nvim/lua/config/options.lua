local o = vim.opt

-- LINES --
o.number = true -- line numbers
o.relativenumber = true -- relative line numbers
o.cursorline = true -- highlight current line
o.guicursor =
    "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-blinkwait700-blinkoff400-blinkon250"
o.wrap = false -- disable word wrap
o.scrolloff = 10 -- keep 10 lines above/below cursor
o.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

-- TABS & INDENTATION --
o.tabstop = 4 -- tab width
o.shiftwidth = 4 -- indent width
o.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
o.expandtab = true -- uses spaces instead of tabs
o.smartindent = true -- smart auto-indent
o.autoindent = true -- copy indent form current line

-- SEARCH --
o.ignorecase = true -- case insensitive search
o.smartcase = true -- case sensitive if uppercase in string
o.hlsearch = true -- highlight search terms
o.incsearch = true -- show matches as you type

-- EDITOR --
o.signcolumn = "yes" -- always show a sign column
-- o.colorcolumn = "100"                       -- show a column at position in chars
o.showmatch = true -- highlights matching brackets
o.showmode = false -- do not show to mode, instead have it in statusline
o.fillchars = { eob = " " } -- hide "~" on empty lines

-- HISTORY --
o.backup = false -- do not crate a backup file
o.writebackup = false -- do not write to a backup file
o.swapfile = false -- do not create a swapfile
o.undofile = true -- do create an undo file
o.autowrite = false -- do not auto-save

-- OTHER --
o.updatetime = 200 -- faster completion
o.mouse = "a" -- enable mouse support
o.mousescroll = "ver:1,hor:6" -- smoother mouse wheel scrolling
o.clipboard = "unnamedplus" -- use system clipboard
o.termguicolors = true -- enable 24-bit RGB colors
o.splitright = true -- vertical splits go right
o.splitbelow = true -- horizontal splits go below
vim.opt.iskeyword:append("-") -- include - in words
