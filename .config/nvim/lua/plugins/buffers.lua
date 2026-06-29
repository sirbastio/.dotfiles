local autocmd = vim.api.nvim_create_autocmd

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
end

local function setup_auto_close_unchanged_buffers()
    local file_change_group = vim.api.nvim_create_augroup("CloseUnchangedFileOnLeave", { clear = true })

    autocmd("BufWritePost", {
        group = file_change_group,
        desc = "Toggle to keep the file open if it is saved",
        callback = function(event)
            vim.b[event.buf].keep_open_after_save = true
        end,
    })

    autocmd("BufHidden", {
        group = file_change_group,
        desc = "Close an unchanged file after leaving it",
        callback = function(event)
            local buf = event.buf
            vim.schedule(function()
                if not is_normal_file_buffer(buf)
                    or vim.bo[buf].modified
                    or vim.b[buf].keep_open_after_save then
                    return
                end

                pcall(vim.api.nvim_buf_delete, buf, {})
            end)
        end,
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
                gitsigns = {
                    added = { enabled = true },
                    changed = { enabled = true },
                    deleted = { enabled = true },
                },
            },
        },
        init = function()
            vim.g.barbar_auto_setup = false
            setup_auto_close_unchanged_buffers()
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
