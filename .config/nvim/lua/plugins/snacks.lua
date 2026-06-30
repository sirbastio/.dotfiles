return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        dashboard = { enabled = true },
        image = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        words = { enabled = true, debounce = 0 },
        indent = { enabled = true, animate = { enabled = false } },
    },
}
