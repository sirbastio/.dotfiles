return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-mini/mini.statusline", version = false, opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
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
    -- {
    --     -- smooth cursor
    --     "sphamba/smear-cursor.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         -- cursor_color = "#2f81f7",
    --         time_interval = 8,
    --         stiffness = 0.64,
    --         trailing_stiffness = 0.64,
    --         stiffness_insert_mode = 0.64,
    --         trailing_stiffness_insert_mode = 0.64,
    --         matrix_pixel_threshold = 0.5,
    --     },
    -- },
}
