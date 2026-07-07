return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            diagnostics_clean = {
                mode = "diagnostics",
                filter = { ["not"] = { ["item.source"] = "cspell" } },
            },
            diagnostics_buffer = {
                mode = "diagnostics",
                filter = { buf = 0, ["not"] = { ["item.source"] = "cspell" } },
            },
            spelling = {
                mode = "diagnostics",
                desc = "Spelling diagnostics",
                filter = { ["item.source"] = "cspell" },
                format = "{message:md} {pos}",
            },
        },
    },
    keys = {
        { "X", vim.diagnostic.open_float, desc = "Current line diagnostics" },
        { "<leader>xx", "<cmd>Trouble diagnostics_clean toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics_buffer toggle<cr>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xs", "<cmd>Trouble spelling toggle<cr>", desc = "Spelling (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
}
