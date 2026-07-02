local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

autocmd("BufReadPost", {
    group = augroup("ReturnToLastCursorPosition", { clear = true }),
    desc = "Return to last cursor position",
    callback = function ()
        if vim.bo.buftype ~= "" then
            return
        end

        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)

        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
            vim.cmd("normal! zv")
        end
    end
})
