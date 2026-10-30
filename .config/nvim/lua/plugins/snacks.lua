return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
                    { icon = "󱌢 ", key = "M", desc = "Mason", action = ":Mason" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
        quickfile = { enabled = true },
        input = { enabled = true },
        words = { enabled = true, debounce = 150 },
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
