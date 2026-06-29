return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { attach_to_untracked = true },
        keys = {
            { "<leader>gh", ":Gitsigns preview_hunk<CR>", desc = "[g]it hunk preview" },
            { "<leader>gd", ":Gitsigns diffthis<CR>",     desc = "[g]it [d]iff" },
        },
    },
    {
        "folke/snacks.nvim",
        opts = {
            lazygit = {
                enabled = true,
                win = {
                    style = "lazygit",
                    width = 0,
                    height = 0,
                    wo = {
                        winhighlight = table.concat({
                            "Normal:SnacksLazygitNormal",
                            "NormalNC:SnacksLazygitNormal",
                            "NormalFloat:SnacksLazygitNormal",
                        }, ","),
                    },
                },
            },
        },
        keys = {
            { "<leader>gg", function() Snacks.lazygit() end,     desc = "[g]it [g]ui (lazygit)" },
            { "<leader>gl", function() Snacks.lazygit.log() end, desc = "[g]it [l]ogs (lazygit)" },
        },
    },
}
