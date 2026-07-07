local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function is_normal_file_buffer(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)

    return vim.bo[bufnr].buftype == ""
        and name ~= ""
        and not name:match("^%w+://")
        and not name:match("^CodeDiff ")
        and not vim.bo[bufnr].filetype:match("^codediff")
        and vim.fn.getftype(name) == "file"
end

local function should_persist_file_view(bufnr)
    return is_normal_file_buffer(bufnr)
        and not vim.w.codediff_restore
        and not vim.wo.diff
end

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
    desc = "Save file view state",
    callback = function(args)
        if should_persist_file_view(args.buf) then
            pcall(vim.cmd, "silent! mkview!")
        end
    end,
})

autocmd("BufWinEnter", {
    group = file_view_group,
    desc = "Restore file view state",
    callback = function(args)
        if should_persist_file_view(args.buf) then
            pcall(vim.cmd, "silent! loadview")
        end
    end,
})
