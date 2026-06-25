-- === OPTIONS === --
local o = vim.opt

-- LINES --
o.number = true         -- line numbers
o.relativenumber = true -- relative line numbers
o.cursorline = true     -- highlight current line
o.wrap = false          -- disable word wrap
o.scrolloff = 10        -- keep 10 lines above/below cursor
o.sidescrolloff = 10    -- keep 10 lines to left/right of cursor

-- TABS & INDENTATION --
o.tabstop = 4        -- tab width
o.shiftwidth = 4     -- indent width
o.softtabstop = 4    -- soft tab stop not tabs on tab/backspace
o.expandtab = true   -- uses spaces instead of tabs
o.smartindent = true -- smart auto-indent
o.autoindent = true  -- copy indent form current line

-- SEARCH --
o.ignorecase = true -- case insensitive search
o.smartcase = true  -- case sensitive if uppercase in string
o.hlsearch = true   -- highlight search terms
o.incsearch = true  -- show matches as you type

-- EDITOR --
o.signcolumn = "yes"                        -- always show a sign column
o.colorcolumn = "100"                       -- show a column at position in chars
o.showmatch = true                          -- highlights matching brackets
o.cmdheight = 1                             -- single line command line
o.completeopt = "menuone,noinsert,noselect" -- completion options
o.showmode = false                          -- do not show to mode, instead have it in statusline
o.fillchars = { eob = " " }                 -- hide "~" on empty lines

-- HISTORY --
o.backup = false      -- do not crate a backup file
o.writebackup = false -- do not write to a backup file
o.swapfile = false    -- do not create a swapfile
o.undofile = true     -- do create an undo file
o.autowrite = false   -- do not auto-save

-- OTHER --
o.updatetime = 50           -- faster completion
o.mouse = "a"               -- enable mouse support
o.clipboard = "unnamedplus" -- use system clipboard
o.termguicolors = true      -- enable 24-bit RGB colors
o.splitright = true         -- vertical splits go right
o.splitbelow = true         -- horizontal splits go below

-- === KEYMAPS === --
local set = vim.keymap.set

-- LEADER KEY --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- KEEP CURSOR CENTERED --
set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor position)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- COPY & PASTE --
set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- MOVE LINES --
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
set("x", "<Tab>", ">gv", { desc = "Indent selected lines" })
set("x", "<S-Tab>", "<gv", { desc = "Outdent selected lines" })

-- OTHER --
set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- === AUTO COMMANDS === --
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
    group = yank_group,
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})
