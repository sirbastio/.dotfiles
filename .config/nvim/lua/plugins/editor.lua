return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    {
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = { lsp = { progress = { enabled = false }, signature = { enabled = false } } },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = { sign = { enabled = false } },
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

        -- Makes rainbow-delimiters create named highlight namespaces instead of anonymous ones.
        -- This allows nvim-treesitter-context to discover and copy delimiter highlights
        -- into context lines.
        config = function()
            getmetatable(require("rainbow-delimiters.lib").nsids).__index = function(namespaces, lang)
                local id = vim.api.nvim_create_namespace("nvim.rainbow-delimiters." .. lang)
                rawset(namespaces, lang, id)
                return id
            end
        end,
    },
}
