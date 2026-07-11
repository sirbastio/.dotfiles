return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            attach_to_untracked = true,
            signs = {
                add = { text = " ┃" },
                change = { text = " ┃" },
                delete = { text = " ▸" },
                topdelete = { text = " ┃" },
                changedelete = { text = " ┃" },
                untracked = { text = " ┆" },
            },
        },
        keys = {
            { "<leader>gh", ":Gitsigns preview_hunk<CR>", desc = "[g]it [h]unk preview" },
            { "<leader>gH", ":Gitsigns preview_hunk_inline<CR>", desc = "[G]it [H]unk preview inline" },
            { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "[g]it [d]iff" },
        },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        dependencies = { "esmuellert/codediff.nvim", "folke/snacks.nvim" },
        opts = {
            commit_editor = { staged_diff_split_kind = "vsplit" },
            graph_style = "unicode",
            process_spinner = true,
            treesitter_diff_highlight = true,
        },
        keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" } },
    },
    {
        "folke/snacks.nvim",
        opts = {
            lazygit = {
                enabled = true,
                theme = { inactiveBorderColor = { fg = "SnacksLazygitInactiveBorder" } },
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
            { "<leader>gG", function() Snacks.lazygit() end, desc = "[g]it [g]ui (lazygit)" },
            { "<leader>gl", function() Snacks.lazygit.log() end, desc = "[g]it [l]ogs (lazygit)" },
        },
    },
}
