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
