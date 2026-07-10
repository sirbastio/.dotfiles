local on_normal_file_buffer = require("config.utils").on_normal_file_buffer
local is_codediff_window = require("config.utils").is_codediff_window

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})


local file_view_group = augroup("PersistFileView", { clear = true })

autocmd("BufWinLeave", {
    group = file_view_group,
    desc = "Save file view state (cursor position, folds, etc.)",
    callback = on_normal_file_buffer(function()
        if not is_codediff_window(vim.api.nvim_get_current_win()) then
            pcall(vim.cmd, "silent! mkview!")
        end
    end),
})

autocmd("BufWinEnter", {
    group = file_view_group,
    desc = "Restore file view state outside CodeDiff",
    callback = on_normal_file_buffer(function()
        local winid = vim.api.nvim_get_current_win()

        if is_codediff_window(winid) then
            vim.wo[winid].foldlevel = 99
            print("test")
        else
            pcall(vim.cmd, "silent! loadview")
        end
    end),
})
