return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                style = "night",
                on_highlights = function(highlights, colors)
                    highlights.GitSignsChange = { fg = colors.yellow }
                    highlights.BufferTabpageFill = { bg = colors.none, fg = colors.dark5 }
                    highlights.WinBar = { bg = colors.none, fg = colors.none }
                    highlights.WinBarNC = { bg = colors.none, fg = colors.none }
                    highlights.SnacksLazygitNormal = { fg = colors.fg, bg = "NONE" }
                end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    }
}
