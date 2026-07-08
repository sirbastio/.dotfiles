local set = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- === LEADER KEY ===  --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- === UTIL === --
set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
set("n", "<leader>w", "<cmd>w<CR>", { desc = "[w]rite file" })
set("n", "<leader>q", "<cmd>q<CR>", { desc = "[q]uit" })

-- === KEEP CURSOR CENTERED === --
set("n", "J", "mzJ`z", { desc = "[J]oin lines (keep cursor position)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll [d]own (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll [u]p (centered)" })
set("n", "n", "nzzzv", { desc = "[n]ext search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- === MOVE LINES === --
set("x", "J", "<Esc><cmd>silent! '<,'>m '>+1 | silent! normal! gv=gv<CR>", { desc = "Move selected lines down" })
set("x", "K", "<Esc><cmd>silent! '<,'>m '<-2 | silent! normal! gv=gv<CR>", { desc = "Move selected lines up" })
set("x", "<S-Tab>", "<gv", { desc = "Outdent selected lines" })
set("x", "<Tab>", ">gv", { desc = "Indent selected lines" })

-- === SEARCH === --
set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "[c]lear search highlights" })

-- === COPY & PASTE === --
set("x", "<leader>p", '"_dP', { desc = "[p]aste without yanking" })
set({ "n", "v" }, "<leader>d", '"_d', { desc = "[d]elete without yanking" })
set("n", "x", '"_x', { desc = "delete char without yanking"})

-- === SPLITS === --
set("n", "<leader>s", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>S", "<cmd>split<CR>", { desc = "Split window horizontally" })

set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- === LSP === --
autocmd("LspAttach", {
    group = augroup("LspKeymaps", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
        map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
        map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
        map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")

        map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")

    end
})
