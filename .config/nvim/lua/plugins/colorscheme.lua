return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
        local float_bg = "#0d1117"
        local float_border = "#30363d"

        require("github-theme").setup({
            options = {
                transparent = true,
            },
            groups = {
                all = {
                    CursorLine = { bg = "#161b22" },

                    NormalFloat = { bg = float_bg },
                    FloatBorder = { fg = float_border, bg = float_bg },
                    FloatTitle = { fg = "#79c0ff", bg = float_bg, bold = true },
                    FloatFooter = { fg = "#8b949e", bg = float_bg },

                    SnacksIndent = { fg = "#21262d" },
                    SnacksIndentScope = { fg = "#40464B" },
                    SnacksNormal = { bg = float_bg },
                    SnacksNormalNC = { bg = float_bg },
                    SnacksInputNormal = { bg = float_bg },
                    SnacksInputBorder = { fg = "#8b949e", bg = float_bg },
                    SnacksInputTitle = { fg = "#79c0ff", bg = float_bg, bold = true },
                    SnacksLazygitBorder = { fg = "#8b949e", bg = float_bg },
                    SnacksLazygitActiveBorder = { fg = "#58a6ff", bg = float_bg, bold = true },
                    SnacksLazygitTitle = { fg = "#79c0ff", bg = float_bg, bold = true },

                    -- cursor word highlight color
                    LspReferenceText = { bg = "#21262d" },
                    LspReferenceRead = { bg = "#21262d" },
                    LspReferenceWrite = { bg = "#21262d" },
                },
            },
        })
        vim.cmd.colorscheme("github_dark_default")
    end,
}
