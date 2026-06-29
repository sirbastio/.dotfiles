local autocmd = vim.api.nvim_create_autocmd
local preview_buffer_marker = " ◌"
local preview_buffer = nil
local is_barbar_preview_marker_setup = false

local function is_normal_file_buffer(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
end

local function should_auto_close_buffer(buf)
    return is_normal_file_buffer(buf)
        and not vim.bo[buf].modified
        and not vim.b[buf].keep_open_after_save
end

local function add_preview_buffer_marker()
    local has_barbar_state, barbar_state = pcall(require, "barbar.state")
    if not has_barbar_state or preview_buffer == nil or not vim.api.nvim_buf_is_valid(preview_buffer) then
        return
    end

    local buffer_data = barbar_state.get_buffer_data(preview_buffer)
    local name = buffer_data.name

    if name ~= nil and not vim.endswith(name, preview_buffer_marker) then
        buffer_data.name = name .. preview_buffer_marker
    end
end

local function setup_barbar_preview_marker()
    if is_barbar_preview_marker_setup then
        return
    end

    local has_barbar_state, barbar_state = pcall(require, "barbar.state")
    if not has_barbar_state then
        return
    end

    local update_names = barbar_state.update_names
    barbar_state.update_names = function(...)
        local result = update_names(...)
        add_preview_buffer_marker()
        return result
    end

    is_barbar_preview_marker_setup = true
end

local function update_preview_buffer_marker()
    setup_barbar_preview_marker()

    local has_barbar_render, barbar_render = pcall(require, "barbar.ui.render")
    if has_barbar_render then
        barbar_render.update(true, false)
    end
end

local function close_preview_buffer(buf)
    if not should_auto_close_buffer(buf) then
        return
    end

    pcall(vim.api.nvim_buf_delete, buf, {})
end

local function use_preview_buffer(buf)
    if not should_auto_close_buffer(buf) then
        return
    end

    local previous_preview_buffer = preview_buffer
    preview_buffer = buf
    update_preview_buffer_marker()

    if previous_preview_buffer == nil or previous_preview_buffer == buf then
        return
    end

    vim.schedule(function()
        close_preview_buffer(previous_preview_buffer)
    end)
end

local function setup_preview_buffers()
    local file_change_group = vim.api.nvim_create_augroup("PreviewFileBuffer", { clear = true })

    autocmd("BufWritePost", {
        group = file_change_group,
        desc = "Toggle to keep the file open if it is saved",
        callback = function(event)
            vim.b[event.buf].keep_open_after_save = true

            if preview_buffer == event.buf then
                preview_buffer = nil
                update_preview_buffer_marker()
            end
        end,
    })

    autocmd({ "BufReadPost", "BufNewFile" }, {
        group = file_change_group,
        desc = "Use newly opened files as the single preview buffer",
        callback = function(event)
            use_preview_buffer(event.buf)
        end,
    })

    autocmd("BufDelete", {
        group = file_change_group,
        desc = "Clear the preview buffer after deleting it",
        callback = function(event)
            if preview_buffer == event.buf then
                preview_buffer = nil
                update_preview_buffer_marker()
            end
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
