local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

-- TODO: refactor into util file with buffers.lua
local function is_normal_file_buffer(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr)
        and vim.bo[bufnr].buftype == ""
        and vim.api.nvim_buf_get_name(bufnr) ~= ""
end

local function window_has_codediff(winid)
    return vim.w[winid].codediff_restore ~= nil
end

local function should_persist_file_view(bufnr, winid)
    return is_normal_file_buffer(bufnr) and not window_has_codediff(winid)
end

local function open_window_folds(winid)
    vim.api.nvim_win_call(winid, function() vim.wo.foldlevel = 99 end)
end

local function open_codediff_file_folds(bufnr, winid)
    if not is_normal_file_buffer(bufnr) then
        return
    end

    vim.defer_fn(function()
        if window_has_codediff(winid) then
            open_window_folds(winid)
        end
    end, 50)
end
local file_view_group = augroup("PersistFileView", { clear = true })

autocmd("BufWinLeave", {
    group = file_view_group,
    desc = "Save file view state",
    callback = function(args)
        if should_persist_file_view(args.buf, vim.api.nvim_get_current_win()) then
            pcall(vim.cmd, "silent! mkview!")
        end
    end,
})

autocmd("BufWinEnter", {
    group = file_view_group,
    desc = "Restore file view state",
    callback = function(args)
        local winid = vim.api.nvim_get_current_win()

        if should_persist_file_view(args.buf, winid) then
            pcall(vim.cmd, "silent! loadview")
        else
            open_codediff_file_folds(args.buf, winid)
        end
    end,
})
