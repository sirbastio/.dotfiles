return {
    -- git signs in the gutter
    -- TODO: setup hunk actions preview, reset
    { "lewis6991/gitsigns.nvim",   event = { "BufReadPre", "BufNewFile" }, opts = {} },
    { "nvim-mini/mini.icons",      version = false,                        opts = {} },
    { "nvim-mini/mini.statusline", version = false,                        opts = {} },
    { "folke/which-key.nvim",      event = "VeryLazy",                     opts = {} },
    {
        -- floating cmdline
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            messages = { enabled = false },
            notify = { enabled = false },
            popupmenu = { enabled = false },
            lsp = {
                progress = { enabled = false },
                hover = { enabled = false },
                signature = { enabled = false },
                message = { enabled = false },
            },
        },
    },
    {
        -- smooth cursor
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            -- cursor_color = "#2f81f7",
            time_interval = 8,
            stiffness = 0.64,
            trailing_stiffness = 0.64,
            stiffness_insert_mode = 0.64,
            trailing_stiffness_insert_mode = 0.64,
            matrix_pixel_threshold = 0.5,
        },
    },
    {
        -- notifications
        "nvim-mini/mini.notify",
        version = "*",
        config = function()
            require("mini.notify").setup({
                -- only show the message
                content = {
                    format = function(notif)
                        return notif.msg
                    end,
                },
                -- Move to bottom right corner
                window = {
                    config = function()
                        return {
                            title = "",
                            anchor = "SE",
                            row = vim.o.lines - 3,
                            col = vim.o.columns - 2,
                            border = "none",
                        }
                    end,
                },
            })
        end,
    },
}
