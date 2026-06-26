local function set_snacks_colors()
    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#21262d" })
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#40464B" })
    vim.api.nvim_set_hl(0, "SnacksLazygitBorder", { fg = "#8b949e" })
    vim.api.nvim_set_hl(0, "SnacksLazygitActiveBorder", { fg = "#58a6ff", bold = true })
    vim.api.nvim_set_hl(0, "SnacksLazygitTitle", { fg = "#79c0ff", bold = true })
end

return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        image = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        words = { enabled = true, debounce = 0 },
        indent = { enabled = true, animate = { enabled = false } },
        picker = { enabled = true, formatters = { file = { filename_first = true } } },
        scroll = {
            enabled = true,
            animate = { duration = { step = 8, total = 160 }, easing = "outQuad" },
            animate_repeat = { elay = 80, duration = { step = 5, total = 80 }, easing = "outQuad" },
        },
        lazygit = {
            enabled = true,
            theme = {
                activeBorderColor = { fg = "SnacksLazygitActiveBorder", bold = true },
                inactiveBorderColor = { fg = "SnacksLazygitBorder" },
                searchingActiveBorderColor = { fg = "SnacksLazygitActiveBorder", bold = true },
            },
            win = {
                border = "rounded",
                title = " Lazygit ",
                title_pos = "center",
                wo = {
                    winhighlight = {
                        Normal = "SnacksNormal",
                        NormalNC = "SnacksNormalNC",
                        NormalFloat = "SnacksNormal",
                        FloatBorder = "SnacksLazygitBorder",
                        FloatTitle = "SnacksLazygitTitle",
                        FloatFooter = "SnacksFooter",
                        WinBar = "SnacksWinBar",
                        WinBarNC = "SnacksWinBarNC",
                        WinSeparator = "SnacksWinSeparator",
                    },
                },
            },
        },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
        set_snacks_colors()
    end,
}
