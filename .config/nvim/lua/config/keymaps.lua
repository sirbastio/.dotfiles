local set = vim.keymap.set

-- LEADER KEY --
vim.g.mapleader = " "

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

-- LSP --
local group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")

        map("K", vim.lsp.buf.hover, "Hover documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

        map("<leader>x", vim.diagnostic.open_float, "Open diagnostics float")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    end
})
