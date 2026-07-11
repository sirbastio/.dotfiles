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

function M.is_codediff_window(winid)
    return vim.w[winid].codediff_restore ~= nil
end

return M
