local autocmd = vim.api.nvim_create_autocmd
local preview_buf = nil
local preview_buf_marker = "◌"

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
end

local function on_normal_file_buffer(callback)
    return function(event)
        if is_normal_file_buffer(event.buf) then
            callback(event)
        end
    end
end

local function add_preview_buf_marker()
    if preview_buf ~= nil then
        local preview_buf_data = require("barbar.state").get_buffer_data(preview_buf)
        preview_buf_data.name = preview_buf_data.name .. " " .. preview_buf_marker
    end
end

-- Hook to appened the preview buffer marker to the file name after barbar updates tab names
local function setup_preview_buf_marker()
    local barbar_state = require("barbar.state")
    local update_names = barbar_state.update_names
    barbar_state.update_names = function(...)
        update_names(...)
        add_preview_buf_marker()
    end
end

local function setup_preview_buffers()
    local preview_buf_group = vim.api.nvim_create_augroup("PreviewBuffers", { clear = true })

    autocmd("BufReadPre", {
        group = preview_buf_group,
        desc = "When a new file is being opened, set it as the preview buffer, and close the old",
        callback = on_normal_file_buffer(function(event)
            vim.schedule(function()
                pcall(vim.api.nvim_buf_delete, preview_buf, {})
                preview_buf = event.buf
            end)
        end)

    })

    autocmd("BufModifiedSet", {
        group = preview_buf_group,
        desc = "When a preview buffers file is modified, remove it as a preview buffer, and rerender the tabs",
        callback = on_normal_file_buffer(function(event)
            if event.buf == preview_buf then
                preview_buf = nil
                require("barbar.ui.render").update(true, false)
            end
        end)
    })

    autocmd("BufWritePost", {
        group = preview_buf_group,
        desc = "When a file is saved remove it as a preview buffer",
        callback = on_normal_file_buffer(function(event)
            if event.buf == preview_buf then
                preview_buf = nil
            end
        end),
    })
end

return {
    {
        "romgrk/barbar.nvim",
        version = "^1.0.0",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            animation = false,
            icons = {
                button = false,
                separator_at_end = false,
                gitsigns = {
                    added = { enabled = true },
                    changed = { enabled = true },
                    deleted = { enabled = true },
                },
            },
        },
        init = function()
            vim.g.barbar_auto_setup = false
            setup_preview_buf_marker()
            setup_preview_buffers()
        end,
        keys = {
            { "<D-1>",      "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
            { "<D-2>",      "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
            { "<D-3>",      "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
            { "<D-4>",      "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
            { "<D-5>",      "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
            { "<leader>bp", "<Cmd>BufferPin<CR>",    desc = "[b]uffer [p]in" },
            { "<leader>bd", "<Cmd>BufferClose<CR>",  desc = "[b]uffer [d]elete" },
        },
    },
}
