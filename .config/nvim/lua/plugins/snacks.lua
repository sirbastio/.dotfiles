return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        words = { enabled = true, debounce = 0 },
        indent = { enabled = true, animate = { enabled = false } },
        notifier = {
            enabled = true,
            margin = { top = 1, right = 2, bottom = 0 },
            width = { min = 20, max = 0.98 },
            height = { min = 1, max = 0.9 },
        },
        styles = { notification = { wo = { wrap = false, winblend = 0 } } },
        terminal = { enabled = true, win = { style = "terminal" } },
    },
    keys = {
        { "<leader>n", function() Snacks.notifier.show_history() end, desc = "[n]otifications" },
        { "<leader>tt", function() Snacks.terminal() end, desc = "[t]erminal [t]oggle" },
        { "<leader>tn", function() Snacks.terminal.open() end, desc = "[t]erminal [n]ew" },
    },
}
