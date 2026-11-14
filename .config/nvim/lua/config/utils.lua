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

return M
