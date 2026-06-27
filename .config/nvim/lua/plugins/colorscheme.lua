return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                -- style = "night",
                on_highlights = function(highlights, colors)
                    highlights.GitSignsChange = { fg = colors.yellow }
                end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    }
}
