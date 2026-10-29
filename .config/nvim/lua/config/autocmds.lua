local on_normal_file_buffer = require("config.utils").on_normal_file_buffer

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

local file_view_group = augroup("PersistFileView", { clear = true })

autocmd("BufWinLeave", {
    group = file_view_group,
    desc = "Save file view state (cursor position, folds, etc.)",
    callback = on_normal_file_buffer(function()
        pcall(vim.cmd, "silent! mkview!")
    end),
})

autocmd("BufWinEnter", {
    group = file_view_group,
    desc = "Restore file view state",
    callback = on_normal_file_buffer(function()
        pcall(vim.cmd, "silent! noautocmd loadview")
    end),
})
