return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-mini/mini.statusline", version = false, opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.rainbow_delimiters = {
                highlight = {
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterRed",
                    "RainbowDelimiterPink",
                    "RainbowDelimiterPurple",
                },
            }
        end,
    },
    {
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            presets = {
                lsp_doc_border = true,
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
