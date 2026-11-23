local M = {}

local function is_normal_file_buffer(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr)
        and vim.bo[bufnr].buftype == ""
        and vim.api.nvim_buf_get_name(bufnr) ~= ""
end

function M.on_normal_file_buffer(callback)
    return function(event)
        if is_normal_file_buffer(event.buf) then
            callback(event)
        end
    end
end

function M.mason_ensure_installed(names)
    local registry = require("mason-registry")
    registry.refresh(function()
        for _, name in ipairs(names) do
            local package = registry.get_package(name)
            if not package:is_installed() then
                package:install()
            end
        end
    end)
end

-- a statuscolumn for wrapped prose: the sign column, then a blank cell so it doesn't touch the text.
-- neovim draws a sign only on the first screen row of a line, so the rows a line wraps onto repeat
-- its git sign here, keeping the bar unbroken beside a changed paragraph
function M.prose_statuscolumn()
    if vim.v.virtnum == 0 then
        return "%s "
    end
    if vim.v.virtnum > 0 then
        local row = vim.v.lnum - 1
        -- buffer 0: the window being drawn is the current one while its statuscolumn is evaluated
        local marks = vim.api.nvim_buf_get_extmarks(0, -1, { row, 0 }, { row, -1 }, { details = true, type = "sign" })
        for _, mark in ipairs(marks) do
            local sign = mark[4]
            if sign.sign_text and vim.startswith(sign.sign_hl_group or "", "GitSigns") then
                return "%#" .. sign.sign_hl_group .. "#" .. sign.sign_text:gsub("%%", "%%%%") .. "%* "
            end
        end
    end
    return "   " -- virtual lines, and wrapped rows of a line without a git sign
end

return M
