return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-mini/mini.statusline", version = false, opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "mbbill/undotree",
        lazy = true,
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = { presets = { lsp_doc_border = true } },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.rainbow_delimiters = {
                -- sets the order of the highlighted brackets
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
        -- Replaces rainbow-delimiters anonymous highlight namespace table with named namespaces
        -- that can be read by plugins such as nvim-ufo and nvim-treesitter-context.
        -- This lets those plugins preserve rainbow-delimiters highlighting.
        config = function()
            require("rainbow-delimiters.lib").nsids = setmetatable({}, {
                __index = function(namespaces, lang)
                    local namespace = vim.api.nvim_create_namespace("nvim.rainbow-delimiters." .. lang)
                    rawset(namespaces, lang, namespace)
                    return namespace
                end,
                __newindex = function()
                    error("Table is immutable")
                end,
            })
        end,
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
