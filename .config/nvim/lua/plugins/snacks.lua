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
        lazygit = { enabled = true },
        words = { enabled = true, debounce = 0 },
        indent = { enabled = true, animate = { enabled = false } },
        picker = { enabled = true, formatters = { file = { filename_first = true } } },
    },
}
