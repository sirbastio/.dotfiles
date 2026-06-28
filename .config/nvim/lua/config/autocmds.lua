local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

local file_change_group = augroup("CloseUnchangedFileOnLeave", { clear = true })

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
end

-- Store the current file changed state (tick) as a local variable in a buffer
local function remember_changedtick(buf)
    local entered_changedtick = vim.b[buf].entered_changedtick
    local changedtick = vim.b[buf].changedtick

    if entered_changedtick ~= nil and entered_changedtick < changedtick then
        return
    end

    vim.b[buf].entered_changedtick = changedtick
end

-- When the window for a file is entered, store the changed state
local function remember_changedtick_when_file_displayed(buf)
    if not is_normal_file_buffer(buf) then
        return
    end

    autocmd("BufWinEnter", {
        group = file_change_group,
        buffer = buf,
        once = true,
        desc = "Remember file state after the file is displayed",
        callback = function(event)
            remember_changedtick(event.buf)
        end,
    })
end

autocmd({ "BufReadPost", "BufNewFile" }, {
    group = file_change_group,
    desc = "Remember file state when opening a file",
    callback = function(event)
        remember_changedtick_when_file_displayed(event.buf)
    end,
})

autocmd("BufWritePost", {
    group = file_change_group,
    desc = "Reset file change state on save",
    callback = function(event)
        vim.b[event.buf].entered_changedtick = nil
    end,
})

autocmd("BufHidden", {
    group = file_change_group,
    desc = "Close when leaving an unchanged file that is not open in any windows",
    callback = function(event)
        local buf = event.buf

        if not is_normal_file_buffer(buf) then
            return
        end

        -- file was changed
        if vim.b[buf].entered_changedtick ~= vim.b[buf].changedtick then
            return
        end

        vim.schedule(function()
            -- Stop if the buffer is no longer valid or if it reappeared.
            if not is_normal_file_buffer(buf) or vim.fn.bufwinid(buf) ~= -1 then
                return
            end

            -- file remains unchanged
            if vim.b[buf].entered_changedtick == vim.b[buf].changedtick then
                pcall(vim.api.nvim_buf_delete, buf, {})
            end
        end)
    end,
})
